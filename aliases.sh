# Set ROS alias command
alias cw='cd ~/catkin_ws'
alias cs='cd ~/catkin_ws/src'
alias cb='catkin build --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'
alias cbt='catkin build --this --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'

# Set Neovim alias command
alias nv='nvim'

# Set tmux alias command
alias tmuxj='tmux new-session \; source-file ~/.tmux.session.conf'

# Others
alias cls='clear'
alias logo='neofetch'

# compile command for ROS completion
function catkin-compile-commands-json() {
    local catkin_ws=${ROS_WORKSPACE}
    (cd "${catkin_ws}" && catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1)
    # Find compile_commands.json in build directory and create symlink to the top of the package
    # directories.
    local package_directories=$(find "${catkin_ws}/src" -name package.xml | xargs -n 1 dirname)
    for package_dir in $(echo $package_directories); do
        local package=$(echo $package_dir | xargs -n 1 basename)
        (
            cd "${catkin_ws}"
            if [ -e ${catkin_ws}/build/$package/compile_commands.json ]; then
                ln -sf ${catkin_ws}/build/$package/compile_commands.json \
                    $(rospack find $package)/compile_commands.json
            fi
            # if [ -e ${catkin_ws}/build/${package^^}/compile_commands.json ]; then
            #     ln -sf ${catkin_ws}/build/${package^^}/compile_commands.json \
            #         $(rospack find $package)/compile_commands.json
            # fi
        )
    done
}
