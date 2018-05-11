set title 'MEM Plot'
set datafile separator ","
set key box
set key top right
set xlabel 'Time'
set ylabel 'Data' font 'Arial,12'
set autoscale
set term png size 1980,1080
set output "mem.png"
set format y '%.0s%cB'
set yrange [0:*]
plot 'mem.dat' using 1 title 'Used' with lines axes x1y1, 'mem.dat' using 3 title 'Shared' with lines axes x1y1, 'mem.dat' using 4 title 'Buffer' with lines axes x1y1, 'mem.dat' using 5 title 'Cache' with lines axes x1y1
