#!/usr/bin/perl

# This script parses the output of `mpstat -P ALL`, presenting the
# info in a structure more ameniable to post-processing tools for test
# reports
# Usage:  parsecpu cpu.txt [ncpu]
my $regex = qr/(?:[01]\d|2[0123]):(?:[012345]\d):(?:[012345]\d)/mp;

open (FH,'<',$ARGV[0]);
while (<FH>) {
  $line=$_;
  chomp($line);
  $line =~ s/^\s+//;
  ($time,$cpu,$usr,$nice,$sys,$iowait,$irq,$soft,$steal,$guest,$gnice,$idle) = split(/ +/,"$line");
  next if($time !~ $regex);
  next if($cpu eq "CPU");
  $reqcpu=$ARGV[1];
  
  if(not defined $reqcpu){
	$reqcpu='all';
  }else{
	$reqcpu=$reqcpu-1;
  }
  next if($cpu ne $reqcpu);
  print $time."\t".$cpu."\t".$usr."\t".$nice."\t".$sys."\t".$iowait."\t".$irq."\t".$soft."\t".$steal."\t".$guest."\t".$gnice."\t".$idle;
  print "\n";
}
exit;
