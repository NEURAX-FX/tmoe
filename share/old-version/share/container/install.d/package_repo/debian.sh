#!/usr/bin/env bash

tmoe_repo_pkg_debian_like() {
    debian_sources_list() {
        sed -i 's/^deb/##&/g' /etc/apt/sources.list
        cat >>/etc/apt/sources.list <<-'EndOfFile'
#deb http://mirrors.bfsu.edu.cn/debian/ stable main contrib non-free
#deb http://mirrors.bfsu.edu.cn/debian/ stable-updates main contrib non-free
deb http://mirrors.bfsu.edu.cn/debian/ sid main contrib non-free
EndOfFile
    }
    kali_sources_list() {
        sed -i 's/^deb/##&/g' /etc/apt/sources.list
        cat >>/etc/apt/sources.list <<-'EndOfSourcesList'
deb http://mirrors.ustc.edu.cn/kali/ kali-rolling main non-free contrib
EndOfSourcesList
    }
    ubuntu_sources_list() {
        sed -i 's/^deb/##&/g' /etc/apt/sources.list
        cat >>/etc/apt/sources.list <<-'EndOfUbuntuSourceList'
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal-updates main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal-backports main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu-ports/ focal-security main restricted universe multiverse
EndOfUbuntuSourceList
    }

    if grep -q 'Debian' /etc/os-release 2>/dev/null; then
        [[ ${TMOE_GITHUB} = true ]] || debian_sources_list
    elif grep -q 'Kali' /etc/os-release 2>/dev/null; then
        [[ ${TMOE_GITHUB} = true ]] || kali_sources_list
    elif grep -Eq 'Ubuntu|Pop' /etc/os-release 2>/dev/null; then
        [[ ${TMOE_GITHUB} = true ]] || ubuntu_sources_list
    fi
}

tmoe_repo_pkg_apt_common() {
    if [[ ! $(command -v apt) ]]; then
        return
    fi
    if [[ ! $(command -v eatmydata) ]]; then
        apt install -y eatmydata || apt install -y -f eatmydata
    fi
    if [[ ${WEEKLY_BUILD_CONTAINER} != true ]]; then
        eatmydata apt update || apt update
        eatmydata apt upgrade -y || apt upgrade -y
    fi
    for i in sudo whiptail curl wget procps; do
        if [[ ! $(command -v ${i}) ]]; then
            eatmydata apt install -y ${i} 2>/dev/null || apt install -y ${i} 2>/dev/null
        fi
    done
}
