#!/bin/bash
# trap ctrl-c and continue
# call this script with desired iperf command trailing
# example ./myscript/perfmon.sh iperf -s
trap ' ' INT
mpstat -P ALL 1 > cpu.txt  &
free -b -c 600000 -s 1 -w > mem.txt &
set -x; "$@" | tee iperf.txt ; set +x;
kill $!
kill $!
sleep 2;
./myscript/parsecpu.pl cpu.txt >> out.dat
gnuplot ./myscript/plotcpu.gnu
mv out.dat out-all.dat;
mv printme.png printme-all.png;
CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)
for i in $(seq 1 $CORES)
do
	echo "Parsing data Core:" $i;
	./myscript/parsecpu.pl cpu.txt $i >> out.dat
	gnuplot ./myscript/plotcpu.gnu
	mv out.dat out-$i.dat;
	mv printme.png printme-$i.png
done
./myscript/parseram.pl < mem.txt >> mem.dat
gnuplot ./myscript/plotmem.gnu
if [[ $@ = *"iperf3"* ]]; then
    $iperf="iperf.*";
    ./myscript/parseram.pl < iperf.txt > iperf.dat
    gnuplot ./myscript/plotiperf.gnu
fi
now=$(date +"%Y-%m-%d-%S")
echo "insert output archive name";
read filename;
if [[ $? != 1 ]]
then
filename="$filename.$now.tar.gz"
tar -czpmvf $filename cpu.txt mem.txt *.dat *.png $iperf
fi
rm cpu.txt;
rm mem.txt  $iperf;
rm *.dat;
rm *.png;
