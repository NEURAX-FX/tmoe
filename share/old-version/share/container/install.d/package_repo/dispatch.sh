#!/usr/bin/env bash

for i in /usr/local/etc/tmoe-linux/container/install.d/package_repo/*.sh; do
    case "${i}" in
    *dispatch.sh) continue ;;
    *) . "${i}" ;;
    esac
done

tmoe_container_configure_repo_and_packages() {
    tmoe_repo_pkg_debian_like
    tmoe_repo_pkg_arch_like
    tmoe_repo_pkg_opensuse_alpine_openwrt
    tmoe_repo_pkg_apt_common
    tmoe_repo_pkg_gentoo_void
    tmoe_repo_pkg_rpm
    tmoe_repo_pkg_slackware
}
