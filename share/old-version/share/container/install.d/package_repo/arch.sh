#!/usr/bin/env bash

tmoe_repo_pkg_arch_like() {
    if [ "$(cut -c 1-4 /etc/issue 2>/dev/null)" = "Arch" ] || [ "$(cut -c 1-7 /etc/issue 2>/dev/null)" = "Manjaro" ]; then
        [[ ${WEEKLY_BUILD_CONTAINER} = true ]] || pacman -Syu --noconfirm --needed base base-devel
        if [[ -e /etc/pacman.conf ]]; then
            sed -i.bak -E "s@^#(Color)@\1@" /etc/pacman.conf
        fi
        if [[ ! $(command -v paru) ]]; then
            pacman -Sy --noconfirm --needed paru 2>/dev/null
        fi
        fix_whiptail_0_52_21
    fi
}
