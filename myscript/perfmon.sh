#!/bin/bash
# trap ctrl-c and continue
# call this script with desired iperf command trailing
# example ./myscript/perfmon.sh iperf -s
trap ' ' INT


function clean {
	rm cpu.txt;
	rm mem.txt;
	rm command.txt  $iperf;
	rm *.dat;
	rm *.png;
	exit;
}
function compress {
	tar -czpmvf $1 cpu.txt mem.txt *.dat *.png command.txt  $iperf;
}

function parsecpu {
	echo "Parsing data Core:" $1;
	./myscript/parsecpu.pl cpu.txt $1 >> out.dat;
	gnuplot ./myscript/plotcpu.gnu;
	mv out.dat out-$1.dat;
	mv printme.png printme-$1.png;
}
function parseram {
	./myscript/parseram.pl < mem.txt >> mem.dat;
	gnuplot ./myscript/plotmem.gnu;
}

mpstat -P ALL 1 > cpu.txt  &
free -b -c 600000 -s 1 -w > mem.txt &
set -x; "$@" | tee command.txt ; set +x;
kill $!;
kill $!;
sleep 2;

parsecpu $all;

CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu);
for i in $(seq 1 $CORES); do
	parsecpu $i;
done;
parseram;
if [[ $@ = *"iperf3"* ]]; then
    $iperf="iperf.*";
    ./myscript/parseiperf.pl < command.txt > iperf.dat;
    gnuplot ./myscript/plotiperf.gnu;
fi

if [[ -z "${FILENAME}" ]]; then
	echo "insert output archive name";
	read FILENAME;
	if [[ $? != 1 ]]; then
		now=$(date +"%Y-%m-%d-%S");
		FILENAME="$FILENAME.$now.tar.gz";
		compress $FILENAME;
		clean;
	fi;
fi;
compress $FILENAME;
clean;

