# Manjaro GNOME Setup

Post-install scripts for Manjaro with GNOME. Includes system tweaks, package installation, development environment setup, and GNOME configuration.

---

## Scripts

### `setup.sh`

Configures GNOME and system defaults.

**Features**

* Opens recommended GNOME extensions for manual install
* Enables installed extensions (`forge@jmmaranan.com`)
* Applies GNOME settings via `gsettings`
* Configures Pamac (AUR, Flatpak, keep builds)
* Removes selected default GNOME applications
* Updates the system

---

### `packages.sh`

Installs development tools, CLI utilities, and desktop applications.

**Features**

* Installs CLI tools:

  * fastfetch
  * btop
  * lazygit
  * neovim
  * asciiquarium
  * tty-clock
  * pipes.sh

* Installs and configures:

  * NVM and Node.js 24
  * global npm packages (`git-cz`, `@google/gemini-cli`)
  * PHP 8.4 and Composer
  * Docker and Docker Compose
  * Warp terminal

* Installs desktop applications:

  * visual-studio-code-bin
  * onlyoffice-desktopeditors
  * obs-studio
  * stacer-bin
  * pear-desktop-bin

* Installs fonts:

  * ttf-times-new-roman

---

## Requirements

* Manjaro GNOME
* Bash
* pacman
* pamac
* sudo

---

## Usage

Run system setup:

```bash
chmod +x setup.sh
./setup.sh
```

Run package installation:

```bash
chmod +x packages.sh
./packages.sh
```

---

## Recommended order

```bash
./setup.sh
./packages.sh
```

---

## Notes

* Scripts are safe to re-run
* Some changes require logout or reboot
* Docker group changes require relogin
* GNOME extensions must be installed manually

---

## Logs

Each script generates a log file:

* `~/postinstall.log`
* `~/dev-install.log`