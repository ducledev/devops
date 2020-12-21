#!/bin/bash

# For usage helper
usage() {
  cat <<EOM
    Usage: $0 -u [-k]
      * -u: username. If not specific -k, it just create ".ssh" folder & "authorized_keys" file
      * -k: sshkey. Append sshkey into "authorized_keys" file
      * Example $0 -u user1 -k "ssh-rsaxxxxx"
EOM
  exit 0;
}
[ -z $1 ] && { usage; }

# Start script...
# confirmation
read -p "Are you sure (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

# make sure this script run as root
if [ `whoami` != 'root' ]
  then
    echo "You must be root to do this."
    exit
fi

# parse input params for this script -u, -g, -k
while getopts u:k: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        k) sshkey=${OPTARG};;
    esac
done

# Add ssh key for user
SSH_FOLDER="/home/$username/.ssh";
if [[ ! -d "$SSH_FOLDER" ]]; then
     echo "Create SSH folder: $SSH_FOLDER"
     mkdir -m700 $SSH_FOLDER
     chown $username:$username $SSH_FOLDER
fi

AUTH_FILE="$SSH_FOLDER/authorized_keys"
if [[ ! -f "$AUTH_FILE" ]]; then
     echo "Create authorized_keys file: $AUTH_FILE"
     touch $AUTH_FILE
     chmod 600 $AUTH_FILE
     chown $username:$username $AUTH_FILE
fi

if [[ ! -z "$sshkey" ]]; then
  # set public key for ssh user
  echo "Add SSH key for user $username";
  echo >> "$AUTH_FILE";
  echo "$sshkey" >> "$AUTH_FILE";

  echo "Result:";
  echo 'BEGIN=========================='
  cat $AUTH_FILE
  echo '==========================END'
fi
