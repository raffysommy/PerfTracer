#!/usr/bin/perl

# This script parses the output of `sysbench --test=cpu`, presenting the
# info in a structure more ameniable to post-processing tools for test
# reports
# Usage:  parse_sysbench_cpu < cpu.output
my $regex = qr/(?:[01]\d|2[0123]):(?:[012345]\d):(?:[012345]\d)/mp;


while (<>) {
  $line=$_;
  chomp($line);
  $line =~ s/^\s+//;
  ($time,$cpu,$usr,$nice,$sys,$iowait,$irq,$soft,$steal,$guest,$gnice,$idle) = split(/ +/,"$line");
  next if($time !~ $regex);
  next if($cpu eq "CPU");
  next if($cpu ne "all");
  print $time."\t".$cpu."\t".$usr."\t".$nice."\t".$sys."\t".$iowait."\t".$irq."\t".$soft."\t".$steal."\t".$guest."\t".$gnice."\t".$idle;
  print "\n";
}
exit;
