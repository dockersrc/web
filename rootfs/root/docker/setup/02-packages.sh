#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202601292017-git
# @@Author           :  CasjaysDev
# @@Contact          :  CasjaysDev <docker-admin@casjaysdev.pro>
# @@License          :  MIT
# @@Copyright        :  Copyright 2026 CasjaysDev
# @@Created          :  Thu Jan 29 08:17:16 PM EST 2026
# @@File             :  02-packages.sh
# @@Description      :  script to run packages
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :  N/A
# @@Resource         :  N/A
# @@Terminal App     :  yes
# @@sudo/root        :  yes
# @@Template         :  templates/dockerfiles/init_scripts/02-packages.sh
# - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
set -o pipefail
[ "$DEBUGGER" = "on" ] && echo "Enabling debugging" && set -x$DEBUGGER_OPTIONS
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set env variables
exitCode=0

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Predefined actions

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Main script

# Install yay AUR helper if on Arch Linux
if [ -f /etc/arch-release ]; then
  echo "Detected Arch Linux - Installing yay AUR helper..."
  
  # Install yay AUR helper if not present
  if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay AUR helper..."
    
    # Ensure abc user exists and has sudo rights
    if ! id -u abc >/dev/null 2>&1; then
      useradd -m -s /bin/bash abc
    fi
    echo "abc ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/abc
    
    # Clone and build yay as abc user
    rm -rf /tmp/yay
    cd /tmp
    git clone --depth 1 https://aur.archlinux.org/yay.git
    chown -R abc:abc /tmp/yay
    
    # Build yay with proper error handling
    cd /tmp/yay
    su - abc -c "cd /tmp/yay && makepkg -si --noconfirm --needed" || {
      echo "ERROR: yay build failed, trying alternative method..."
      # Alternative: use yay-bin from AUR (pre-compiled)
      cd /tmp
      rm -rf /tmp/yay-bin
      git clone --depth 1 https://aur.archlinux.org/yay-bin.git
      chown -R abc:abc /tmp/yay-bin
      cd /tmp/yay-bin
      su - abc -c "cd /tmp/yay-bin && makepkg -si --noconfirm --needed"
    }
    
    # Cleanup
    cd /
    rm -rf /tmp/yay /tmp/yay-bin
    
    if command -v yay >/dev/null 2>&1; then
      echo "yay installed successfully"
    else
      echo "WARNING: yay installation failed"
    fi
  fi
  
  echo "XFCE4 and yay installation complete"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set the exit code
#exitCode=$?
# - - - - - - - - - - - - - - - - - - - - - - - - -
exit $exitCode
# - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
# - - - - - - - - - - - - - - - - - - - - - - - - -
