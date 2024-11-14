#!/bin/bash

set -x

test -z ${PROJ:-} && PROJ=user-group-automate

venv_path="$PROJ_PATH/src/python/user-group-automate/.venv"
home_venv_path="$HOME_PROJ_PATH/src/python/user-group-automate/.venv"
venv_path="$PROJ_PATH/src/python/user-group-automate/.venv"

test -d $venv_path && sudo rm -r $venv_path
cp -vr $home_venv_path $venv_path

perl -pi -e "s|/home/$APPUSR||g" $venv_path/bin/activate

echo "source $PROJ_PATH/src/python/user-group-automate/.venv/bin/activate" >>~/.bashrc
trap : TERM INT
sleep infinity &
wait
