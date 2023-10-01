#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd $SCRIPT_DIR/.. && ./update.sh

# shell
echo -n "setting private config for shell... "
if [ -e ~/.bashrc ]; then # bashrc
    LOAD_COMMAND_COUNT=$(cat ~/.bashrc | grep dotfiles\/my_scripts\/load_my_files\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "source $SCRIPT_DIR/load_my_files.sh" >> ~/.bashrc
    fi
fi
if [ -e ~/.zshrc ]; then # zshrc
    LOAD_COMMAND_COUNT=$(cat ~/.zshrc | grep dotfiles\/my_scripts\/load_my_files\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "source $SCRIPT_DIR/load_my_files.sh" >> ~/.zshrc
    fi
fi
echo "Done"
echo ""
