set title 'CPU Plot'
set xdata time
set datafile separator "\t"
set key box
set key top right
set xlabel 'Time'
set ylabel 'Data' font 'Arial,12'
set autoscale
set term png size 1980,1080
set output "printme.png"
set timefmt "%H:%M:%S"
plot 'out.dat' using 1:3 title 'User' with lines,'out.dat' using 1:4 title 'Nice' with lines, 'out.dat' using 1:5 title 'Sys' with lines, 'out.dat' using 1:6 title 'IoWait' with lines, 'out.dat' using 1:7 title 'IRQ' with lines, 'out.dat' using 1:8 title 'Soft' with lines, 'out.dat' using 1:9 title 'Steal' with lines, 'out.dat' using 1:10 title 'Guest' with lines, 'out.dat' using 1:11 title 'GNice' with lines, 'out.dat' using 1:12 title 'Idle' with lines

