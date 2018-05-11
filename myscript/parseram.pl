#!/usr/bin/perl

# This script parses the output of `watch -n 1 "free>>out.txt"`, presenting the
# info in a structure more ameniable to post-processing tools for test
# reports
# Usage:  ./parseram.pl < mem.output
my $regex = qr/(?:[01]\d|2[0123]):(?:[012345]\d):(?:[012345]\d)/mp;


while (<>) {
  next if (/^\s*$/);
  $line=$_;
  chomp($line);
  chop($line);
  ($type,$total,$used,$free,$shared,$buff,$cache,$avaiable) = split(/ +/,"$line",8);
  next if($type eq "total");
  next if($type ne "Mem:");
  print $used.",".$free.",".$shared.",".$buff.",".$cache;
  print "\n";
}
exit;
