#!/usr/bin/env bash

tmoe_repo_pkg_gentoo_void() {
    if grep -qi gentoo /etc/os-release 2>/dev/null; then
        sed -i 's@GENTOO_MIRRORS=.*@GENTOO_MIRRORS="https://mirrors.bfsu.edu.cn/gentoo"@g' /etc/portage/make.conf 2>/dev/null
        emerge-webrsync 2>/dev/null || true
        emerge --sync 2>/dev/null || true
        [[ $(command -v whiptail) ]] || emerge -av dev-libs/newt
    elif grep -qi void /etc/os-release 2>/dev/null; then
        sed -i 's@https://alpha.de.repo.voidlinux.org@https://mirrors.bfsu.edu.cn/voidlinux@g' /etc/xbps.d/*-repository-*.conf 2>/dev/null
        xbps-install -S
        xbps-install -uy xbps
        xbps-install -y wget curl newt
    fi
}
