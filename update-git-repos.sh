#!/usr/bin/env bash
DIRS=`ls -d */`

NC='\033[0m' # No Color
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGRAY='\033[0;37m'
YELLOW='\033[1;33m'
#printf "I ${RED}love${NC} Stack Overflow\n"

_stdout(){
  if [ "$#" -eq 0 ]; then echo; return; fi
  echo -e "* $@${NC}"
}

_stderr(){
  if [ "$#" -eq 0 ]; then echo; return; fi
  echo -e "* $@${NC}" >&2
}

_update(){
  local DIR MSG
  DIR="$1"
# _stdout ${DIR}
  pushd ${DIR} > /dev/null

  MSG="${CYAN}${DIR::-1} ${YELLOW}($(git rev-parse --abbrev-ref HEAD))"
  # is clean ?
  if git status --porcelain --untracked-files=no > /dev/null 2>&1; then
    # has upstream ?
    if git rev-parse --abbrev-ref --symbolic-full-name '@{u}' > /dev/null 2>&1; then
      # Working directory clean
      if git pull > /dev/null; then
        _stdout "${GREEN}pulled ${MSG}"
      else
        _stderr "${RED}fail ${MSG}"
      fi
    else
      _stdout "${PURPLE}local ${MSG}"
    fi
  else
    # Uncommitted changes
    _stderr "${RED}dirty ${MSG}"
  fi

  popd > /dev/null
# _stdout
}

for x in ${DIRS}; do
  _update $x
done
