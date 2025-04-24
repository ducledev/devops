#!/bin/bash

set -e # halt if error occurs

BASHRC_LOCATION="$HOME/.bashrc"

f=".bashrc-custom-aliases"
NEW_RC_PATH="$HOME/$f"

cat > $NEW_RC_PATH << END_OF_FILE 

# wsh wave terminal
alias wv='wsh view'
alias we='wsh edit'

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

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kgns='kubectl get namespaces'
alias kgall='kubectl get all'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kl='kubectl logs'
alias kex='kubectl exec -it'
alias kns='kubectl config set-context --current --namespace'
alias kctx='kubectl config use-context'
alias kcurrent='kubectl config current-context'
alias kctxs='kubectl config get-contexts'
KUBE_HELP_CONTENT=\$(cat <<EOM
 \n
 k           = kubectl                                    \n
 kgp         = kubectl get pods                           \n
 kgd         = kubectl get deployments                    \n
 kgs         = kubectl get services                       \n
 kgn         = kubectl get nodes                          \n
 kgns        = kubectl get namespaces                     \n
 kgall       = kubectl get all                            \n
 kdp [pod]   = kubectl describe pod                       \n
 kdd [depl]  = kubectl describe deployment                \n
 kds [svc]   = kubectl describe service                   \n
 kl [pod]    = kubectl logs                               \n
 kex [pod]   = kubectl exec -it                           \n
 kns [ns]    = kubectl config set-context --current --namespace \n
 kctx [ctx]  = kubectl config use-context                 \n
 kcurrent    = kubectl config current-context             \n
 kctxs       = kubectl config get-contexts                \n
EOM
)
alias khelp='echo -e \$KUBE_HELP_CONTENT'

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
