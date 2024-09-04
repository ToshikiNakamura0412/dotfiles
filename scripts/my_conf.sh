OS_NAME="_init_"

if [[ -e /etc/os-release ]]; then
  source /etc/os-release
  OS_NAME=$(echo $ID)
fi

# Show git branch
if [[ -n "$BASH_VERSION" ]]; then
  if ! type __git_ps1 &> /dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
  fi
fi

if [[ $OS_NAME == "alpine" ]]; then
  alias ll='ls -l'
  alias la='ls -lA'
  alias l='ls -la'

elif [[ $OS_NAME == "ubuntu" ]]; then

  # Set alias commands for ROS
  if [[ -d /opt/ros ]]; then
    alias cw='cd $ROS_WORKSPACE'
    alias cs='cd $ROS_WORKSPACE/src'

    if [[ $ROS_VERSION -eq 1 ]]; then
      alias cb='catkin build -DCMAKE_BUILD_TYPE=RelWithDebInfo'
      alias cbt='catkin build --this -DCMAKE_BUILD_TYPE=RelWithDebInfo'

      # Set alias commands for ROS completion and build
      function create_simple_compile_flags() {
        echo "-I/opt/ros/$ROS_DISTRO/include" > compile_flags.txt
        echo "-I$PWD/include" >> compile_flags.txt
      }
      function cbt_export_compile_commands() {
        catkin build --this -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
        echo ""
        if [[ -e package.xml ]]; then
          local package_name=$(cat package.xml | grep '<name>' | awk -F '[>]' '{print $2}' | awk -F '[<]' '{print $1}')
          if [[ -e $ROS_WORKSPACE/build/$package_name/compile_commands.json ]]; then
            ln -sfv $ROS_WORKSPACE/build/$package_name/compile_commands.json ./compile_commands.json
          else
            echo "Error: compile_commands.json not found in build directory"
          fi
        else
          echo "Error: package.xml not found in current directory, so can't create symlink to compile_commands.json"
        fi
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
