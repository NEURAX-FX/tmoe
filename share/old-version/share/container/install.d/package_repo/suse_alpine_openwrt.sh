#!/usr/bin/env bash

tmoe_repo_pkg_opensuse_alpine_openwrt() {
    if grep -q 'openSUSE' "/etc/os-release" 2>/dev/null; then
        [[ ${TMOE_GITHUB} = true ]] || {
            zypper mr -da
            if [ "$(uname -m)" = 'aarch64' ]; then
                zypper addrepo -fcg https://mirrors.bfsu.edu.cn/opensuse/ports/aarch64/tumbleweed/repo/oss bfsu-mirror-oss
            else
                zypper addrepo -fcg https://mirrors.bfsu.edu.cn/opensuse/tumbleweed/repo/oss/ bfsu-mirror-oss
                zypper addrepo -fcg https://mirrors.bfsu.edu.cn/opensuse/tumbleweed/repo/non-oss/ bfsu-mirror-non-oss
            fi
            zypper --gpg-auto-import-keys refresh
        }
        zypper in -y wget curl newt
    elif grep -q 'Alpine Linux' "/etc/issue" 2>/dev/null; then
        [[ ${TMOE_GITHUB} = true ]] || sed -i 's/dl-cdn.alpinelinux.org/mirrors.bfsu.edu.cn/g' /etc/apk/repositories
        apk update && apk upgrade
        apk add bash tzdata newt sudo shadow
    elif grep -q 'OpenWrt' "/etc/os-release" 2>/dev/null; then
        mkdir -pv /var/lock/
        touch /var/lock/opkg.lock
        opkg update
        opkg install libustream-openssl ca-bundle ca-certificates bash dialog whiptail
    fi
}
