#!/bin/bash

# For usage helper
usage() {
  cat <<EOM
    Usage: $0 -u [-g] [-k]
      * -u: username
      * -g: group name
      * Example $0 -u user1 -g group1
EOM
  exit 0;
}
[ -z $1 ] && { usage; }

# Start script...
# confirmation
read -p "Are you sure to create user (y/n)? " -n 1 -r
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
while getopts u:g:k: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        g) group=${OPTARG};;
    esac
done
echo "Create Username: $username, Group: $group";

if [[ -z $username ]]; then echo "-u username is required"; exit 1; fi
# Add a new user, use --comment option as FullName
echo "Add user without password: $username";
adduser $username --disabled-password;

# Assign group for user
if [[ ! -z "$group" ]]; then
  echo "Add user $username into $group group";
  usermod -a -G $group $username;
fi
