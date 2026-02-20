#!/bin/bash

set -e

LOG="$HOME/dev-install.log"
exec > >(tee -a "$LOG") 2>&1

info() {
  echo -e "\e[1;34m[INFO]\e[0m $1"
}

warn() {
  echo -e "\e[1;33m[WARN]\e[0m $1"
}

sudo -v

###############################################################################
info "Install Warp Terminal"
###############################################################################

if ! grep -q "warpdotdev" /etc/pacman.conf; then
  sudo sh -c "echo -e '\n[warpdotdev]\nServer = https://releases.warp.dev/linux/pacman/\$repo/\$arch' >> /etc/pacman.conf"
  sudo pacman-key -r "linux-maintainers@warp.dev"
  sudo pacman-key --lsign-key "linux-maintainers@warp.dev"
  sudo pacman -Sy --noconfirm warp-terminal
else
  warn "Warp repo already exists"
fi


###############################################################################
info "Install CLI Packages"
###############################################################################

CLI_PKGS=(
  fastfetch
  btop
  lazygit
  neovim
  asciiquarium
  tty-clock
  pipes.sh
)

sudo pamac install --no-confirm "${CLI_PKGS[@]}"


###############################################################################
info "Install NVM + Node"
###############################################################################

if [ ! -d "$HOME/.nvm" ]; then

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

fi

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install 24
nvm use 24

npm install -g \
  git-cz \
  @google/gemini-cli


###############################################################################
info "Install PHP + Composer"
###############################################################################

if ! command -v php &>/dev/null; then

  /bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"

fi


###############################################################################
info "Install Docker"
###############################################################################

DOCKER_PKGS=(
  docker
  docker-compose
  docker-buildx
)

sudo pamac install --no-confirm "${DOCKER_PKGS[@]}"

sudo systemctl enable --now docker

if ! groups "$USER" | grep -q docker; then
  sudo usermod -aG docker "$USER"
fi

sudo chmod 666 /var/run/docker.sock || true


###############################################################################
info "Install Desktop Apps"
###############################################################################

DESKTOP_PKGS=(
  visual-studio-code-bin
  stacer-bin
  obs-studio
  pear-desktop-bin
  onlyoffice-desktopeditors
  ttf-times-new-roman
)

sudo pamac install --no-confirm "${DESKTOP_PKGS[@]}"


###############################################################################
info "Finished"
info "Reboot recommended"
info "Log: $LOG"
###############################################################################
