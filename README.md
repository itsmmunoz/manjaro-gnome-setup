# Manjaro GNOME Setup

Post-install script for Manjaro GNOME that applies common GNOME tweaks, enables extensions, configures Pamac (AUR + Flatpak), and removes unnecessary preinstalled apps.

---

## Features

- Opens recommended GNOME extensions for manual install  
- Enables installed extensions (`forge@jmmaranan.com`)
- Applies GNOME settings via `gsettings`
- Configures Pamac (AUR, Flatpak, keep builds)
- Safely removes selected default applications

---

## Requirements

- Manjaro GNOME
- Bash, pacman, pamac, gnome-extensions

---

## Usage

```bash
chmod +x setup.sh
./setup.sh
````

Requires sudo for some steps.

---

## Notes

* Extensions are not installed automatically
* No GNOME Shell/session restart
* Idempotent and safe to re-run

