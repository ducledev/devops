#!/bin/bash

set -e # halt if error occurs
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"
echo $SCRIPT_HOME;

BASHRC_LOCATION="$HOME/.bashrc"

f=".bashrc-ps1"

cat <<EOT > "$HOME/$f"

function GitBranch() {
    git symbolic-ref --short HEAD >& /dev/null
    if [ $? -eq 0 ]; then
        git symbolic-ref --short HEAD
    fi
}

PS1='\n╭\[\e[33m\]\u\[\e[m\]@\[\033[00;32m\]\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00m\] \[\e[31m\]$(GitBranch)\[\e[m\]\n╰\[\033[01;37m\]\h\[\033[00m\] \$ '


EOT

# ================== Add ~/.bashrc-ps1 into ~/.bashrc
BASHRC_COMMON_STRING=$(cat  <<EOM

# custom ps1
source "$HOME/$f"

EOM
)

# -q be quiet; -F pattern is a plain string
grep -qF "$f" $BASHRC_LOCATION || echo -e "$BASHRC_COMMON_STRING" >> $BASHRC_LOCATION

echo "Installed $f"
echo "=== Aftermath: ==="
grep -iE "custom ps1|$f" $BASHRC_LOCATION