#!/usr/bin/env bash

tmoe_repo_pkg_slackware() {
    if [ "$(grep 'ID=' /etc/os-release | head -n 1 | cut -d '=' -f 2)" = "slackware" ]; then
        sed -i 's/^ftp/#&/g' /etc/slackpkg/mirrors
        sed -i 's/^http/#&/g' /etc/slackpkg/mirrors
        sed -i '$ a\https://mirrors.bfsu.edu.cn/slackwarearm/slackwarearm-current/' /etc/slackpkg/mirrors
        slackpkg update gpg
        slackpkg update
        slackpkg install newt
    fi
}
