#!/bin/bash

info() { 
  echo -e "\e[1;34m[INFO]\e[0m $1" 
}

info "Open GNOME extensions"
xdg-open https://extensions.gnome.org/extension/517/caffeine/
xdg-open https://extensions.gnome.org/extension/779/clipboard-indicator/
xdg-open https://extensions.gnome.org/extension/4167/custom-hot-corners-extended/
xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/


info "GNOME settings"
gnome-extensions enable forge@jmmaranan.com

gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

gsettings set org.gnome.desktop.wm.preferences button-layout ':close'

gsettings set org.gnome.desktop.interface show-battery-percentage true

# config dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true 

gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color true

gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(0,0,0)'

gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.4

gsettings set org.gnome.shell.extensions.dash-to-dock show-trash true

gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false


info "Configure pamac (AUR + Flatpak + keep builds)"
sudo sed -i \
  -e 's/^#EnableAUR/EnableAUR/' \
  -e 's/^#CheckAURUpdates/CheckAURUpdates/' \
  -e 's/^#EnableFlatpak/EnableFlatpak/' \
  -e 's/^#CheckFlatpakUpdates/CheckFlatpakUpdates/' \
  -e 's/^#KeepBuiltPkgs/KeepBuiltPkgs/' \
  /etc/pamac.conf


info "Remove default apps"
PKGS=(
  gnome-calendar gnome-contacts gnome-maps gnome-weather gnome-clocks
  gnome-tour endeavour gnome-chess gnome-mines iagno malcontent
  quadrapassel htop micro
)

sudo pamac remove --no-confirm $(pacman -Qq "${PKGS[@]}" 2>/dev/null) || true




