#!/bin/bash

set -e

LOG="$HOME/postinstall.log"
exec > >(tee -a "$LOG") 2>&1

info() {
  echo -e "\e[1;34m[INFO]\e[0m $1"
}

warn() {
  echo -e "\e[1;33m[WARN]\e[0m $1"
}

sudo -v

###############################################################################
info "Configure pamac (Enable AUR, Flatpak, Keep builds)"
###############################################################################
sudo sed -i 's/^#EnableAUR/EnableAUR/' /etc/pamac.conf
sudo sed -i 's/^#CheckAURUpdates/CheckAURUpdates/' /etc/pamac.conf
sudo sed -i 's/^#EnableFlatpak/EnableFlatpak/' /etc/pamac.conf
sudo sed -i 's/^#CheckFlatpakUpdates/CheckFlatpakUpdates/' /etc/pamac.conf
sudo sed -i 's/^#KeepBuiltPkgs/KeepBuiltPkgs/' /etc/pamac.conf


###############################################################################
info "Remove default GNOME apps"
###############################################################################
PKGS=(
  gnome-calendar
  gnome-contacts
  gnome-maps
  gnome-weather
  gnome-clocks
  gnome-tour
  endeavour
  gnome-chess
  gnome-mines
  iagno
  malcontent
  quadrapassel
  htop
  micro
)

TO_REMOVE=()

for pkg in "${PKGS[@]}"; do
  if pacman -Q "$pkg" &>/dev/null; then
    TO_REMOVE+=("$pkg")
  fi
done

if [ ${#TO_REMOVE[@]} -gt 0 ]; then
  sudo pamac remove --no-confirm "${TO_REMOVE[@]}"
else
  warn "No packages to remove"
fi


###############################################################################
info "Open GNOME extensions for manual install"
###############################################################################
xdg-open https://extensions.gnome.org/extension/517/caffeine/
xdg-open https://extensions.gnome.org/extension/779/clipboard-indicator/
xdg-open https://extensions.gnome.org/extension/4167/custom-hot-corners-extended/
xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/


###############################################################################
info "GNOME configuration"
###############################################################################
set_if_exists() {

  schema="$1"
  key="$2"
  value="$3"

  if gsettings writable "$schema" "$key" >/dev/null 2>&1; then

    gsettings set "$schema" "$key" "$value"

  else

    warn "$schema::$key not available"

  fi
}

enable_extension() {

  EXT="$1"

  if gnome-extensions list | grep -q "$EXT"; then

    gnome-extensions enable "$EXT"

  else

    warn "Extension $EXT not installed"

  fi
}


# interface
set_if_exists org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

set_if_exists org.gnome.desktop.wm.preferences button-layout ':close'

set_if_exists org.gnome.desktop.interface show-battery-percentage true


# dash to dock
set_if_exists org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true

set_if_exists org.gnome.shell.extensions.dash-to-dock custom-background-color true

set_if_exists org.gnome.shell.extensions.dash-to-dock background-color "'rgb(0,0,0)'"

set_if_exists org.gnome.shell.extensions.dash-to-dock background-opacity 0.4

set_if_exists org.gnome.shell.extensions.dash-to-dock show-trash true

set_if_exists org.gnome.shell.extensions.dash-to-dock show-show-apps-button false


# forge
enable_extension forge@jmmaranan.com

set_if_exists org.gnome.shell.extensions.forge focus-on-hover-enabled true

set_if_exists org.gnome.shell.extensions.forge focus-border-color "'rgba(236, 94, 94, 1)'"


###############################################################################
info "Updating system"
###############################################################################
sudo pamac update --no-confirm


###############################################################################
info "Post install finished"
info "Log saved at $LOG"
###############################################################################