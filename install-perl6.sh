#!/bin/sh
git clone git://github.com/rakudo/rakudo.git
cd rakudo
perl Configure.pl --gen-parrot --gen-nqp --backends=parrot,jvm
make
make install
