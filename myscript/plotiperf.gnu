set title 'Iperf Plot'
set datafile separator ","
set key box
set key top right
set xlabel 'Time'
set ylabel 'Speed'
set autoscale
set term png size 1980,1080
set output "iperf.png"
set yrange [0:*]
set format y '%.0s%cbit/s'
plot 'iperf.dat' using 1:2 title 'Bandwidth' with lines;
