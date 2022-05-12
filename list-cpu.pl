#!/usr/bin/perl -w

use strict;
use warnings;

my @hosts;

foreach (1 .. 25) {
  push @hosts, sprintf 'atcpcw%02d', $_;
}

foreach (1 .. 25) {
	#  next if ($_ ~~ [1,4,8,10..15]);
  push @hosts, sprintf 'atcsqa%02d', $_;
}

foreach (1 .. 5) {
  push @hosts, sprintf 'atctlc%02d', $_;
}

foreach (@hosts) {
  my $host_name = $_;
  my $test = `getent hosts $host_name`;
  next if (length($test) == 0);

  my $line = `ssh -o ConnectTimeout=2 $host_name 'echo "\$(grep -c ^processor /proc/cpuinfo) - \$(uptime) - \$(uname -m -r)"' 2> /dev/null`;
  #print $line;
  #8 -  14:08:10 up 55 days, 20:29, 11 users,  load average: 1.02, 1.27, 1.82 - 2.6.32-642.6.2.el6.x86_64 x86_64
  my @info = split(' - ', $line);
  my $msg;
  if (@info > 0) {
    my $cpu_num = $info[0];
    #print $cpu_num;
    my ($load) = $info[1] ? $info[1] =~ m/: (.+)/ : "?, ?, ?";
    my ($cpu_load1, $cpu_load5, $cpu_load15) = split(',', $load);
    #print "$cpu_load1, $cpu_load5, $cpu_load15";
    my ($os_name, $arch_name) = split(' ', $info[2]);
    #print "$os_name, $arch_name";
    $msg = sprintf '%10s: %2d cores, load (%6s, %6s, %6s), arch %8s, os %s', $host_name, $cpu_num,
                    $cpu_load1, $cpu_load5, $cpu_load15, $arch_name, $os_name;
  } else {
    $msg = sprintf '%10s: -- cores, load (------, ------, ------), arch --------, os ----', $host_name;
  }

  print "$msg\n";
}

__END__
my $counter = 1;
while ($counter < 30) {
  $counter++;
}

for x in `seq -w 30`; do getent hosts atcpcw$x > /dev/null && echo "$x"; done
