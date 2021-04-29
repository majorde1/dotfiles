#!/bin/zsh

compress() {
  tar cvzf $1.tar.gz $1
}

vman() {
  nvim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}
