#!/usr/bin/perl

# This script parses the output of `iperf`, presenting the
# info in a structure more ameniable to post-processing tools for test
# reports
# Usage:  ./parseiperf.pl < iperf.txt
my $linepoint=false;


while (<>) {
  next if (/^\s*$/);
  $line=$_;
  chomp($line);
  chop($line);
  next if(index($line,"omitted")!=-1);
  ($waste,$id,$interval,$sec,$transfer,$transferunit,$bw,$bwunit,$total,$datagrams) = split(/ +/,"$line",10);
  if(($waste eq "-") && $linepoint){ exit;}
  next if($sec ne "sec");
  next if(index($line,"nan")!=-1);
  ($stime,$etime) = split(/-/,"$interval",2);
  $linepoint=true;
  print $stime.",".$bw*1024;
  print "\n";
}
exit;
