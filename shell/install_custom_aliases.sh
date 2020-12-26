#!/bin/bash

# Start script...
# confirmation
read -p "Are you sure to install custom aliases (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

set -e # halt if error occurs
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"
echo $SCRIPT_HOME;

BASHRC_LOCATION="$HOME/.bashrc"

f=".bashrc-custom-aliases"
cat "$SCRIPT_HOME/$f" > "$HOME/$f"

# ================== Add ~/.bashrc-custom-aliases into ~/.bashrc
BASHRC_COMMON_STRING=$(cat  <<EOM

# custom aliases
source "$HOME/$f"

EOM
)

# -q be quiet; -F pattern is a plain string
grep -qF "$f" $BASHRC_LOCATION || echo -e "$BASHRC_COMMON_STRING" >> $BASHRC_LOCATION

source $BASHRC_LOCATION
echo "Installed $f"
