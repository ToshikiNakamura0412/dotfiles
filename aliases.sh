# Set ROS alias command
alias cw='cd $ROS_WORKSPACE'
alias cs='cd $ROS_WORKSPACE/src'
alias cb='catkin build --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'
alias cbt='catkin build --this --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'

# Set Neovim alias command
alias nv='nvim'

# Set tmux alias command
alias tmuxj='tmux new-session \; source-file ~/.tmux.session.conf'

# Others
alias cls='clear'
alias logo='neofetch'

# Set compile command for ROS completion
function catkin-compile-commands-json() {
    cd $ROS_WORKSPACE && catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1

    # Find compile_commands.json in build directory and create symlink to the top of the package directories.
    local package_xmls=$(find $ROS_WORKSPACE/src -name package.xml)
    for package_xml in $(echo $package_xmls); do
        local package_name=$(cat $package_xml | grep '<name>' | sed 's/ //g' | sed s/name//g | sed s/\<//g | sed s/\>//g | sed 's/\///g')
        if [ -e $ROS_WORKSPACE/build/$package_name/compile_commands.json ]; then
            ln -sf $ROS_WORKSPACE/build/$package_name/compile_commands.json $(rospack find $package_name)/compile_commands.json
        fi
    done
}
