#!/bin/bash

set -e # halt if error occurs

BASHRC_LOCATION="$HOME/.bashrc"

f=".bashrc-custom-aliases"
NEW_RC_PATH="$HOME/$f"

cat > $NEW_RC_PATH << END_OF_FILE 

# Tmux aliases
alias tmuxnew='tmux new -s'                     # tmuxnew session_name
alias tmuxattach='tmux attach-session -t'       # tmuxattach session_name
alias tmuxls='tmux ls'
TMUX_HELP_CONTENT=\$(cat <<EOM
 \n 
 Ctrl+B > c (new window)			\n
 Ctrl+B > $ (name your session)		\n
 Ctrl+B > , (renames a window)		\n
 Ctrl+B > d (detach from your session)	\n
 Ctrl+B > 0 (switch to window 0 by number)	\n
 Ctrl+B > % (split current pane horizontally into two panes \n
 Ctrl+B > o (go to the next pane)
 Ctrl+B > x (close the current pane)
EOM
)
alias tmuxhelp='echo -e \$TMUX_HELP_CONTENT'

# others
alias cdssh='cd ~/.ssh'

COLOR_1="\033[00;31m";
ENDCOLOR_1="\033[00m";
function format_string_c() {
  text=\$1;
  echo "\${COLOR_1}\$text\${ENDCOLOR_1}";
}

END_OF_FILE

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
