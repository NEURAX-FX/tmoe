#!/usr/bin/env bash

tmoe_repo_pkg_rpm() {
    if grep -q '^ID=fedora' /etc/os-release 2>/dev/null; then
        [[ ${WEEKLY_BUILD_CONTAINER} = true ]] || dnf update -y
        [[ $(command -v sudo) ]] || dnf install -y sudo
        [[ $(command -v ip) ]] || dnf install -y iproute
        dnf install -y --skip-broken dnf-utils passwd findutils man-db glibc-all-langpacks || true
        [[ $(command -v whiptail) ]] || dnf install --skip-broken -y newt
        fix_whiptail_0_52_21
    elif grep -Eq 'CentOS|Rocky Linux|rhel' /etc/os-release 2>/dev/null; then
        [[ $(command -v dnf) ]] || yum install -y dnf
        yes | dnf install -y --skip-broken epel-release
        dnf install -y dnf-utils "glibc-langpack-${TMOE_LANG_QUATER}*" || yum install -y --skip-broken dnf-utils glibc-all-langpacks
        [[ $(command -v whiptail) ]] || yum install --skip-broken -y newt
    fi
}
