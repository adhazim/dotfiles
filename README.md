# Arch Linux Dotfiles

My personal Arch Linux configuration and setup backup.

This repository is used to recreate my Arch Linux environment on a **new laptop** or after reinstalling Arch Linux.

The main purpose is to keep my configurations, package lists, and system setup information so I do not have to manually configure everything from scratch.

---

# My Setup

* OS: Arch Linux
* Window Manager / Compositor: Hyprland
* Shell: Zsh
* Terminal: Kitty
* Editor: Neovim
* Package Manager: pacman
* AUR Helper: yay
* Dotfiles Manager: Git bare repository
* GitHub Repository: `adhazim/dotfiles`

---

# What This Repository Is For

This repository stores my Linux configuration files and setup information.

It can contain configurations such as:

```text
~/.config/hypr/
~/.config/waybar/
~/.config/kitty/
~/.config/nvim/
~/.config/rofi/
~/.config/swaync/
~/.config/wlogout/
~/.config/fastfetch/
~/.zshrc
```

It may also contain:

```text
packages/
system/
```

for package lists and system information.

The repository is designed so that I can:

```text
Old Laptop
    ↓
Backup configuration to GitHub
    ↓
Buy New Laptop
    ↓
Install Arch Linux
    ↓
Clone this repository
    ↓
Restore configuration
    ↓
Install packages
    ↓
Restore my setup
```

---

# Important: What This Repository Does NOT Back Up

This repository is **not a complete backup of my laptop**.

It does not automatically contain:

```text
❌ Personal documents
❌ Pictures
❌ Videos
❌ Music
❌ Personal projects
❌ Database data
❌ Browser profiles
❌ Passwords
❌ API keys
❌ SSH private keys
❌ .env files
❌ Application data
❌ Game data
```

These should be backed up separately.

---

# Before Getting a New Laptop

Before moving to a new laptop, make sure the latest configuration is pushed to GitHub.

## 1. Check the dotfiles

```bash
dotfiles status
```

## 2. Add changed configurations

For example:

```bash
dotfiles add ~/.config/hypr
dotfiles add ~/.config/waybar
dotfiles add ~/.config/kitty
dotfiles add ~/.config/nvim
dotfiles add ~/.config/rofi
dotfiles add ~/.config/swaync
dotfiles add ~/.config/wlogout
dotfiles add ~/.config/fastfetch
dotfiles add ~/.zshrc
```

Only add configurations that should be backed up.

## 3. Review the files

```bash
dotfiles status
```

Make sure there are no secrets or private information.

Do NOT commit:

```text
.env
*.pem
id_rsa
id_ed25519
password files
API keys
access tokens
database credentials
```

## 4. Commit

```bash
dotfiles commit -m "Update dotfiles"
```

## 5. Push to GitHub

```bash
dotfiles push origin master
```

## 6. Confirm

```bash
dotfiles status
```

The expected result is:

```text
Your branch is up to date with 'origin/master'.
nothing to commit
```

---

# Setting Up a New Laptop

The following steps assume:

* I bought a new laptop.
* I installed Arch Linux.
* The new laptop does not have my old SSH key.
* I want to restore my configuration from GitHub.

---

# Step 1 — Install Git

On the new Arch Linux installation:

```bash
sudo pacman -S git
```

Check:

```bash
git --version
```

---

# Step 2 — Configure Git

Set my GitHub username:

```bash
git config --global user.name "adhazim"
```

Set my GitHub email:

```bash
git config --global user.email "YOUR_GITHUB_EMAIL"
```

Check:

```bash
git config --global --list
```

---

# Step 3 — Set Up GitHub SSH

A new laptop may not have the SSH key from my old laptop.

There are two options.

## Option A — Restore My Existing SSH Key

If I have securely backed up my old SSH key, I can restore it to:

```text
~/.ssh/
```

For example:

```bash
mkdir -p ~/.ssh
```

Then restore:

```text
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
```

Set the correct permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

Start the SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add the key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Test:

```bash
ssh -T git@github.com
```

---

# Option B — Create a New SSH Key

If I **do not have my old SSH key**, I can simply create a new one.

This is normally the easiest option for a new laptop.

Generate a new ED25519 key:

```bash
ssh-keygen -t ed25519 -C "YOUR_GITHUB_EMAIL"
```

When asked:

```text
Enter file in which to save the key:
```

Press:

```text
Enter
```

I can set a passphrase for additional security.

Start the SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add the new key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Display the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the entire output.

---

# Step 4 — Add the New SSH Key to GitHub

Log in to GitHub.

Go to:

```text
GitHub
→ Settings
→ SSH and GPG keys
→ New SSH key
```

Give the key a name such as:

```text
New Laptop - Arch Linux
```

Paste the contents of:

```bash
cat ~/.ssh/id_ed25519.pub
```

into GitHub.

Save the key.

> The public key (`id_ed25519.pub`) can be added to GitHub.
>
> Never upload the private key (`id_ed25519`) to this repository.

---

# Step 5 — Test GitHub SSH

Run:

```bash
ssh -T git@github.com
```

A successful connection should show something similar to:

```text
Hi adhazim! You've successfully authenticated, but GitHub does not provide shell access.
```

If this appears, SSH is working.

---

# Step 6 — Clone the Dotfiles Repository

My dotfiles repository uses a **bare Git repository**.

Clone it using:

```bash
git clone --bare git@github.com:adhazim/dotfiles.git ~/.dotfiles
```

The Git repository will be located at:

```text
~/.dotfiles
```

---

# Step 7 — Create the `dotfiles` Command

Create the alias:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

To make it permanent in Zsh:

```bash
echo "alias dotfiles='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'" >> ~/.zshrc
```

Reload Zsh:

```bash
source ~/.zshrc
```

Test:

```bash
dotfiles status
```

---

# Step 8 — Restore the Configuration

Run:

```bash
dotfiles checkout
```

This restores the files tracked by the repository into my home directory.

For example:

```text
~/.zshrc
~/.config/hypr/
~/.config/kitty/
~/.config/nvim/
~/.config/waybar/
```

and other tracked configuration files.

---

# If Git Shows Checkout Conflicts

The new Arch installation may already contain default configuration files.

For example:

```text
error: The following untracked working tree files would be overwritten by checkout
```

Do not delete files immediately.

Create a temporary backup:

```bash
mkdir -p ~/restore-backup
```

For example, if `.zshrc` causes a conflict:

```bash
mv ~/.zshrc ~/restore-backup/
```

Then run:

```bash
dotfiles checkout
```

The version from the GitHub repository can then be restored.

---

# Step 9 — Restore Packages

Check whether package lists exist:

```bash
dotfiles ls-files | grep '^packages/'
```

If the official package list exists:

```bash
sudo pacman -S --needed - < packages/packages.txt
```

For AUR packages:

```bash
yay -S --needed - < packages/aur-packages.txt
```

If `yay` is not installed yet, install it before restoring the AUR packages.

---

# Step 10 — Restore Hyprland

Check:

```bash
ls ~/.config/hypr
```

Then:

```bash
ls ~/.config/hypr/UserConfigs
```

Verify:

* Monitor configuration
* Keybinds
* Window rules
* Wallpapers
* Environment variables
* Startup applications
* Waybar
* Notifications

---

# Step 11 — Restore Waybar

Check:

```bash
ls ~/.config/waybar
```

If Waybar is installed, start/restart it:

```bash
pkill waybar
waybar &
```

Check that the modules and styling are working.

---

# Step 12 — Restore Kitty

Check:

```bash
ls ~/.config/kitty
```

Launch Kitty and check:

* Font
* Theme
* Transparency
* Keybindings
* Terminal settings

---

# Step 13 — Restore Neovim

Check:

```bash
ls ~/.config/nvim
```

Start Neovim:

```bash
nvim
```

If Lazy.nvim is configured, allow it to install the configured plugins.

External development tools may also need to be installed again:

```text
LSP servers
Formatters
Debuggers
PHP
Python
Java
C/C++
C#
Node.js
```

The configuration is stored in Git, but the actual programs are installed separately.

---

# Step 14 — Restore Zsh

Check:

```bash
cat ~/.zshrc
```

Check Oh My Zsh:

```bash
ls ~/.oh-my-zsh
```

Install any required programs used by `.zshrc`, for example:

```text
zsh
fzf
fastfetch
pyenv
phpbrew
```

depending on the current configuration.

---

# Step 15 — Restore Other Applications

Install applications that were used on the old laptop.

Examples:

```text
Kitty
Neovim
Firefox
Spotify
DBeaver
MongoDB Compass
Kdenlive
Thunar
Rofi
Waybar
SwayNC
Wlogout
```

The exact applications should come from the package lists or my own software list.

---

# Step 16 — Restore Personal Projects

Restore my projects from their separate backups or GitHub repositories.

For example:

```text
~/Projects/
```

For Laravel projects, reinstall dependencies:

```bash
composer install
```

and:

```bash
npm install
```

if the project uses Node.js.

The `.env` file should be restored separately and should not be stored publicly in this repository.

---

# Step 17 — Restore Databases

Databases are backed up separately from this repository.

Examples:

```text
MongoDB
PostgreSQL
```

Restore database dumps after installing the required database software.

Do not put database passwords or sensitive database dumps into this public repository.

---

# Step 18 — Restore SSH Keys for Other Services

GitHub SSH is only one type of SSH key.

If I use SSH for other services, such as:

```text
Servers
Virtual machines
Development environments
```

restore those keys separately.

Never upload private SSH keys to this public repository.

---

# Step 19 — Check the Setup

Check Git:

```bash
dotfiles status
```

Check GitHub:

```bash
ssh -T git@github.com
```

Check Zsh:

```bash
echo $SHELL
```

Check Hyprland:

```bash
hyprctl version
```

Check Neovim:

```bash
nvim --version
```

Check packages:

```bash
pacman -Q
```

---

# Complete New Laptop Workflow

The overall process is:

```text
              OLD LAPTOP
                  │
                  ▼
        Update dotfiles
                  │
                  ▼
        Commit changes
                  │
                  ▼
        Push to GitHub
                  │
                  ▼
        ┌─────────────────┐
        │  GitHub Backup  │
        └─────────────────┘
                  │
                  │
                  ▼
             NEW LAPTOP
                  │
                  ▼
           Install Arch
                  │
                  ▼
            Install Git
                  │
                  ▼
       Configure GitHub SSH
                  │
                  ▼
       Clone ~/.dotfiles
                  │
                  ▼
       Create dotfiles alias
                  │
                  ▼
       dotfiles checkout
                  │
                  ▼
       Restore configurations
                  │
                  ▼
       Restore package lists
                  │
                  ▼
       Install applications
                  │
                  ▼
       Restore personal files
                  │
                  ▼
       Restore databases/projects
                  │
                  ▼
          Reboot / Test
                  │
                  ▼
        Arch Linux Setup Ready
```

---

# Quick Setup Commands

For a new laptop, the basic process is:

### 1. Install Git

```bash
sudo pacman -S git
```

### 2. Configure Git

```bash
git config --global user.name "adhazim"
git config --global user.email "YOUR_GITHUB_EMAIL"
```

### 3. Create a new SSH key if needed

```bash
ssh-keygen -t ed25519 -C "YOUR_GITHUB_EMAIL"
```

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Then add:

```bash
cat ~/.ssh/id_ed25519.pub
```

to GitHub.

### 4. Test GitHub

```bash
ssh -T git@github.com
```

### 5. Clone dotfiles

```bash
git clone --bare git@github.com:adhazim/dotfiles.git ~/.dotfiles
```

### 6. Create the alias

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

### 7. Restore

```bash
dotfiles checkout
```

### 8. Restore packages

```bash
sudo pacman -S --needed - < packages/packages.txt
```

```bash
yay -S --needed - < packages/aur-packages.txt
```

### 9. Reboot

```bash
reboot
```

---

# Updating This Repository

Whenever I change my Linux configuration:

```bash
dotfiles status
```

Add the required files:

```bash
dotfiles add <files>
```

Review:

```bash
dotfiles status
```

Commit:

```bash
dotfiles commit -m "Update dotfiles"
```

Push:

```bash
dotfiles push origin master
```

---

# Security Reminder

This repository may be public.

Before pushing anything, check that I am not uploading:

```text
❌ Private SSH keys
❌ Passwords
❌ API keys
❌ Tokens
❌ .env files
❌ Database credentials
❌ Personal/private information
```

A Git repository should contain my **configuration**, not my secrets.

---

# Goal

The goal of this repository is to make moving to a new laptop simple:

> **Install Arch → connect GitHub → restore dotfiles → install packages → restore personal data → continue working.**

This repository is my backup and setup reference for my Arch Linux environment.
