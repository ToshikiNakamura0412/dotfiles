DISTROS=(
    "alpine"
    "arch"
    "centos"
    "debian"
    "fedora"
    "opensuse-leap"
    "ubuntu"
    "mac"
)

function check_os() {
    if [[ "$(uname)" != "Linux" ]] && [[ "$(uname)" != "Darwin" ]]; then
        echo "This OS is not supported."
        exit 1
    fi
}

function get_distro() {
    if [[ "$(uname)" == "Linux" ]] && [[ -e /etc/os-release ]]; then
        source /etc/os-release
        echo ${ID}
    elif [[ "$(uname)" == "Darwin" ]]; then
        echo "mac"
    else
        echo ""
    fi
}

function is_valid_distro() {
    local distro=$1
    if [[ -z ${distro} ]]; then
        echo -e "\e[31mError: distro is empty\e[m"
        return 1
    fi
    for d in ${DISTROS[@]}; do
        if [[ ${distro} == ${d} ]]; then
            return 0
        fi
    done
    return 1
}

# You should set unique element in the target file at the end of the array 'target_strings' to avoid deleting other lines.
function delete_lines() {
    local target_file=$1
    if [[ -z ${target_file} ]]; then
        echo -e "\e[31mError: target_file is empty\e[m"
        return
    fi
    shift 1
    local target_strings=("$@")
    if [[ ${#target_strings[@]} -eq 0 ]]; then
        echo -e "\e[31mError: target_strings is empty\e[m"
        return
    fi
    local search_string=$(echo ${target_strings[${#target_strings[@]}-1]} | sed 's/\\//g' | sed 's/^ *//g')

    if grep -Fq "${search_string}" ${target_file}; then
        while grep -Fq "${search_string}" ${target_file}; do
            target_line=$(grep -Fn "${search_string}" ${target_file} | cut -d ":" -f 1 | head -n 1)
            if [[ $(get_distro) == "mac" ]]; then
                sed -i '' "$((target_line - ${#target_strings[@]} + 1)),$((target_line))d" ${target_file}
            else
                sed -i "$((target_line - ${#target_strings[@]} + 1)),$((target_line))d" ${target_file}
            fi
        done
    else
        ERROR_COUNT_OF_DELETE_LINES=$((ERROR_COUNT_OF_DELETE_LINES + 1))
    fi
}

function add_lines() {
    local target_file=$1
    if [[ -z ${target_file} ]]; then
        echo -e "\e[31mError: target_file is empty\e[m"
        return
    fi
    shift 1
    local target_strings=("$@")
    if [[ ${#target_strings[@]} -eq 0 ]]; then
        echo -e "\e[31mError: target_strings is empty\e[m"
        return
    fi

    for target_string in "${target_strings[@]}"; do
        echo ${target_string} >> ${target_file}
    done
}
