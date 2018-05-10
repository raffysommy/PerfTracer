#!/bin/bash
mpstat -P ALL 1 >> file.txt
./myscript/parse.pl < file.txt >> out.dat
gnuplot ./myscript/plot1.gnu
now=$(date +"%Y-%m-%d-%S")
filename="cpu.$now.tar.gz"
tar -czpmvf $filename file.txt out.dat printme.png
rm file.txt;
rm out.dat;
rm printme.png;
