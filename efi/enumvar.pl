#!/bin/perl
$sum = 0;
while (<*>) {
  if(-d) {
    $sum++;
    m|(.*)-([\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12})$| or next;
#   printf "%2d: %s %-32s %s\n",$sum,$2,$1,$_;
    printf "%2d: %s\n",$sum,$_;
  }
}
