#!/bin/bash

set -ouex pipefail

# Add ryanabx's cosmic-epoch repo
if [[ "${FEDORA_MAJOR_VERSION}" == "rawhide" ]]; then \
    curl -Lo /etc/yum.repos.d/_copr_ryanabx-cosmic.repo \
        https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-rawhide/ryanabx-cosmic-epoch-fedora-rawhide.repo \
; else curl -Lo /etc/yum.repos.d/_copr_ryanabx-cosmic.repo \
        https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx-cosmic-epoch-fedora-$(rpm -E %fedora).repo \
; fi


# Install cosmic-desktop and supporting packages
rpm-ostree install cosmic-desktop;
rpm-ostree install gnome-keyring-pam NetworkManager-tui NetworkManager-openvpn;


# Enable cosmic-greeter and disable other display managers
systemctl disable gdm || true;
systemctl disable sddm || true;
systemctl enable cosmic-greeter;
# ostree container commit; # do this in the COntainerfile
mkdir -p /var/tmp && chmod -R 1777 /var/tmp
