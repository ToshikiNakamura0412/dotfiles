if [[ -e ~/.config/dotfiles/common.bash ]]; then
  source ~/.config/dotfiles/common.bash
else
  echo -e "\e[31mError: ~/.config/dotfiles/common.bash not found\e[m"
  echo "Please run install.bash"
  return
fi

check_os
DISTRO=$(get_distro)

# Show git branch
if [[ -n "${BASH_VERSION}" ]]; then
  if ! type __git_ps1 &> /dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
  fi
fi

if [[ ${DISTRO} == "alpine" ]]; then
  alias ll='ls -l'
  alias la='ls -lA'
  alias l='ls -la'

elif [[ ${DISTRO} == "ubuntu" ]]; then

  # Set alias commands for ROS
  if [[ -d /opt/ros ]]; then
    function cw() {
      cd ${ROS_WORKSPACE}
    }
    alias cs='cd ${ROS_WORKSPACE}/src'

    if [[ ${ROS_VERSION} -eq 1 ]]; then
      # Set alias commands for ROS completion and build
      function create_simple_compile_flags() {
        echo "-I/opt/ros/${ROS_DISTRO}/include" > compile_flags.txt
        echo "-I${PWD}/include" >> compile_flags.txt
      }
      function ln-compile-commands-json() {
        # Find compile_commands.json in build directory and create symlink to the top of the package directories.
        local package_xmls=$(find ${ROS_WORKSPACE}/src -name package.xml)
        for package_xml in $(echo ${package_xmls}); do
          local package_name=$(cat ${package_xml} | grep '<name>' | awk -F '[>]' '{print $2}' | awk -F '[<]' '{print $1}')
          if [[ -e ${ROS_WORKSPACE}/build/${package_name}/compile_commands.json ]]; then
            ln -sf ${ROS_WORKSPACE}/build/${package_name}/compile_commands.json $(rospack find ${package_name})/compile_commands.json
          fi
        done
      }
      function cb() {
        cw && catkin build --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
        ln-compile-commands-json
      }
      function cbt() {
        catkin build --this --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
        ln-compile-commands-json
      }

    else
      # Set alias commands for build
      function cb() {
        local pwd=$(pwd)
        cd $ROS_WORKSPACE
        colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
        cd $pwd
      }
      function cbt() {
        if [[ -e package.xml ]]; then
          local pwd=$(pwd)
          local package_name=$(cat package.xml | grep '<name>' | awk -F '[>]' '{print $2}' | awk -F '[<]' '{print $1}')
          cd $ROS_WORKSPACE
          colcon build --packages-select $package_name --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
          cd $pwd
        else
          echo "Error: package.xml not found in current directory, so can't build a package"
        fi
      }

      # Set alias commands for clean workspace
      function colcon_clean() {
        echo -n "rm: remove directories 'build' 'install' 'log'? (yes/no) "
        read str
        if [[ $str == "yes" ]]; then
          local pwd=$(pwd)
          cd $ROS_WORKSPACE
          rm -rf build install log
          cd $pwd
        fi
        unset AMENT_PREFIX_PATH
        unset CMAKE_PREFIX_PATH
        if [[ -n "$BASH_VERSION" ]]; then
          source /opt/ros/humble/setup.bash
        else
          source /opt/ros/humble/setup.zsh
        fi
      }

      # Enable tab completion of colcon_cd
      if [[ -n "$BASH_VERSION" ]]; then
        function _colcon_cd_packages() {
          local cur=${COMP_WORDS[COMP_CWORD]}
          local packages=$(cd && colcon list -n)
          COMPREPLY=($(compgen -W "$packages" -- "$cur"))
        }
        complete -F _colcon_cd_packages colcon_cd
      else
        function _colcon_cd_packages() {
          local packages=$(cd && colcon list -n)
          reply=(${(ps:\n:)packages})
        }
        compctl -K _colcon_cd_packages colcon_cd
      fi
    fi
  fi
fi
