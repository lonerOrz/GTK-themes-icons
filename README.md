# GTK-themes-icons

### 🎨 GTK Themes, Icons, and Fcitx5 Themes

This repository is a collection of GTK themes, icons, and Fcitx5 skins. It serves as a hosting and deployment tool, allowing you to quickly set up your desktop environment's appearance.

---

## 🛠️ Dependencies

Ensure you have the following tools installed:

- `tar` & `unzip` (for extraction)
- `tput` (for colored output)

---

## 🚀 Quick Installation

To automatically install all themes and icons to their respective system directories (`~/.themes`, `~/.icons`, and `~/.local/share/fcitx5/themes`):

```bash
git clone --depth 1 https://github.com/lonerOrz/GTK-themes-icons.git
cd GTK-themes-icons
chmod +x autotract.sh
./autotract.sh
```

---

## 🔧 Applying Themes

### Using GUI (Recommended)

Use [**nwg-look**](https://github.com/nwg-piotr/nwg-look) or `lxappearance` to apply themes and icons easily.

### Using CLI

```bash
# Set GTK Theme
gsettings set org.gnome.desktop.interface gtk-theme "Andromeda-dark"

# Set Icon Theme
gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue-Dark"
```

---

## 🔄 Maintenance (For Developers)

This repository includes a `sync-back.sh` script to help you package themes from your local system back into this repository for backup or distribution.

1. Add or modify themes in your system folders.
2. Run `./sync-back.sh`.
3. Follow the interactive prompts to compress and update the files in the repo.
4. Commit and push your changes.

---

## 🤟 Credits and Source

- **Andromeda Dark GTK Theme**: [EliverLara/Andromeda-gtk](https://github.com/EliverLara/Andromeda-gtk)
- **Flat Remix Icon Themes**: [daniruiz/flat-remix](https://github.com/daniruiz/flat-remix)
- **WhiteSur GTK Theme**: [vinceliuice/WhiteSur-gtk-theme](https://github.com/vinceliuice/WhiteSur-gtk-theme)

---

_Maintained by [lonerOrz](https://github.com/lonerOrz)_
