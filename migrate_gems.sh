#!/bin/bash
#
# https://github.com/dborodin/scripts_etc/
#
# 1. Run on the source environment:
# bash ./migrate_gems.sh > install.sh
# 2. Copy install.sh to the destination environment and run it there:
# bash ./install.sh
#

#!/bin/bash
gem list | grep '(' | while read i; do 
  GEM=`echo $i | awk '{print $1}'`; 
  VERSIONS=`echo $i | awk -F'(' '{print $2}' | tr -d ')'`; 
  if (echo "$VERSIONS" | grep -q ','); then
    echo "$VERSIONS" | tr ',' '\n' | while read j; do 
      echo "gem install $GEM -v `echo $j --ignore-dependencies | cut -f1 -d' '`"; 
    done;
  else 
    echo "gem install $GEM -v `echo $VERSIONS --ignore-dependencies | cut -f1 -d' '`"; 
  fi; 
done
