ROS_DISTRO=noetic

# Set basic ROS conf
export ROS_WORKSPACE=$HOME/catkin_ws
export ROS_PACKAGE_PATH=$ROS_WORKSPACE/src:$ROS_PACKAGE_PATH
export ROSCONSOLE_FORMAT='[${severity}] [${time}] [${node}]: ${message}'
export EDITOR='vim'
if [ $0 = 'bash' ]; then # bash
    source /opt/ros/$ROS_DISTRO/setup.bash
    source $ROS_WORKSPACE/devel/setup.bash
else # zsh
    source /opt/ros/$ROS_DISTRO/setup.zsh
    source $ROS_WORKSPACE/devel/setup.zsh
fi

# Set ROS alias command
alias cw='cd $ROS_WORKSPACE'
alias cs='cd $ROS_WORKSPACE/src'
alias cb='catkin build --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'
alias cbt='catkin build --this --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo'

# Set compile command for ROS completion
function ln-compile-commands-json() {
    # Find compile_commands.json in build directory and create symlink to the top of the package directories.
    local package_xmls=$(find $ROS_WORKSPACE/src -name package.xml)
    for package_xml in $(echo $package_xmls); do
        local package_name=$(cat $package_xml | grep '<name>' | sed 's/ //g' | sed s/name//g | sed s/\<//g | sed s/\>//g | sed 's/\///g')
        if [ -e $ROS_WORKSPACE/build/$package_name/compile_commands.json ]; then
            ln -sf $ROS_WORKSPACE/build/$package_name/compile_commands.json $(rospack find $package_name)/compile_commands.json
        fi
    done
}
function catkin-compile-commands-json() {
    cd $ROS_WORKSPACE && catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1
    ln-compile-commands-json
}
function catkin-compile-commands-json-this() {
    catkin build --this --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1
    ln-compile-commands-json
}
