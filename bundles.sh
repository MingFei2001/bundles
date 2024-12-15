#!/usr/bin/env bash

# ------------------------------------------
#     ____  __  ___   ______  __    ___________
#    / __ )/ / / / | / / __ \/ /   / ____/ ___/
#   / __  / / / /  |/ / / / / /   / __/  \__ \
#  / /_/ / /_/ / /|  / /_/ / /___/ /___ ___/ /
# /_____/\____/_/ |_/_____/_____/_____//____/
# ------------------------------------------

# ------------------------------------------
# Welcome to the BUNDLE Setup Script
# Essential Setup for Ubuntu and Debian Systems
# ------------------------------------------
# Created by mingfei
# ------------------------------------------
# This script is designed for easy installation of
# essential applications. Simply clone this
# repository and execute the script in your bash
# shell to install a selection of useful apps.
# ------------------------------------------
# Note: Use this script at your own risk.
# ------------------------------------------

# ------------------------------------------
# List of software
#
# Basic Tools:
# curl build-essential htop git vim fzf ripgrep fdclone cmake zip tmux
# unzip locate bat jq wget rsync openssh-server 7zip
#
# CLI Tools:
# btop tldr neofetch cmatrix speedtest-cli ranger tty-clock lynx cava sysbench vlock
#
# Desktop Applications
# qalculate-gtk hardinfo cpu-x libreoffice gdebi thunderbird
#
# Disk Management Tools:
# bleachbit stacer gnome-disk-utility gparted duf fdisk
#
# Programming Toolkit:
# python3-full python3-virtualenv golang npm nodejs gcc rustup docker.io docker-compose
#
# Media Editor and Viewer:
# kdenlive vlc blender audacity gimp inkscape krita obs-studio ffmpeg darktable mpv celluloid
#
# Hacking and Security Tools:
# nmap wireshark tshark gufw clamav clamtk gnupg netcat
#
# ------------------------------------------

# Variables
LOGFILE="install.log"

# Define the lists of applications
declare -A app_lists
app_lists[basic]="curl build-essential htop git vim fzf ripgrep fdclone cmake zip tmux unzip locate bat jq wget rsync openssh-server 7zip"
app_lists[cli]="btop tldr neofetch cmatrix speedtest-cli ranger tty-clock lynx cava sysbench vlock"
app_lists[desktop]="qalculate-gtk hardinfo cpu-x libreoffice gdebi thunderbird"
app_lists[diskman]="bleachbit stacer gnome-disk-utility gparted duf fdisk kdiskmark"
app_lists[programming]="${app_lists[basic]} python3-full python3-virtualenv golang npm nodejs gcc rustup docker.io docker-compose lazygit lazydocker"
app_lists[media]="kdenlive vlc blender audacity gimp inkscape krita obs-studio ffmpeg darktable mpv celluloid"
app_lists[hacking]="nmap wireshark tshark gufw clamav clamtk gnupg netcat"
app_lists[full]="${app_lists[basic]} ${app_lists[cli]} ${app_lists[desktop]} ${app_lists[programming]} ${app_lists[media]}"

# Print ASCII art banner
print_ascii_art() {
    cat << "EOF"
# ------------------------------------------
    ____  __  ___   ______  __    ___________
   / __ )/ / / / | / / __ \/ /   / ____/ ___/
  / __  / / / /  |/ / / / / /   / __/  \__ \
 / /_/ / /_/ / /|  / /_/ / /___/ /___ ___/ /
/_____/\____/_/ |_/_____/_____/_____//____/
# ------------------------------------------
EOF
}

# Print option menu
print_menu() {
    echo "| -----------------------------"
    echo "| Bundle Setup Script"
    echo "| -----------------------------"
    echo "| [1] Basic Tools"
    echo "| [2] CLI Tools"
    echo "| [3] Desktop Application"
    echo "| [4] Programming Toolkit"
    echo "| [5] Media Editor and Viewer"
    echo "| [6] Disk Management Tools"
    echo "| [7] Hacking Tools"
    echo "| [8] Full Desktop Suite"
    echo "| [0] Abort"
    echo "| -----------------------------"
}

# Function to display menu and get user choice
get_user_choice() {
    while true; do
        read -p "| Enter your choice (0-7): " choice
        case $choice in
            1) echo "basic"; break ;;
            2) echo "cli"; break ;;
            3) echo "desktop"; break ;;
            4) echo "programming"; break ;;
            5) echo "media"; break ;;
            6) echo "diskman"; break ;;
            7) echo "hacking"; break ;;
            8) echo "full"; break ;;
            0) echo "abort"; break ;;
            *) echo "Invalid choice. Please enter a number between 0 and 8." ;;
        esac
    done
}

# Main script
main() {
    # Capture force quitting event and exit safely
    trap "echo 'Exiting...'; exit" SIGINT

    print_ascii_art
    echo ""
    print_menu

    # Retrieve installation options
    install_type=$(get_user_choice)
    if [ "$install_type" == "abort" ]; then
        echo "| Installation aborted."
        echo "| Installation aborted by the user." >> "$LOGFILE"
        exit 0
    fi
    apps_to_install=${app_lists[$install_type]}

    # if the list is empty
    if [ -z "$apps_to_install" ]; then
        echo "| Error: no applications to install."
        echo "| Error: no applications to install." >> "$LOGFILE"
        exit 1
    fi

    # Confirmation message
    echo "| The following apps will be installed:"
    echo "| $apps_to_install"
    read -p "| Do you want to proceed? (y/n): " confirm
    if [[ $confirm != [yY] ]]; then
        echo "| Installation cancelled."
        echo "| Installation cancelled by the user." >> "$LOGFILE"
        exit 0
    fi

    # Loop through the apps and install them
    sudo apt update
    for app in $apps_to_install; do
        echo "| Installing $app..."
        echo "| Installing $app..." >> "$LOGFILE"

        case "$app" in
            "lazygit")
                if go install github.com/jesseduffield/lazygit@latest >> "$LOGFILE" 2>&1; then
                    echo "| $app installed successfully"
                    echo "| $app installed successfully" >> "$LOGFILE"
                else
                    echo "| Failed to install $app"
                    echo "| Failed to install $app" >> "$LOGFILE"
                fi
                    ;;
            "lazydocker")
                if go install github.com/jesseduffield/lazydocker@latest >> "$LOGFILE" 2>&1; then
                    echo "| $app installed successfully"
                    echo "| $app installed successfully" >> "$LOGFILE"
                else
                    echo "| Failed to install $app"
                    echo "| Failed to install $app" >> "$LOGFILE"
                fi
                    ;;
            *)
                if sudo apt-get install -y "$app" >> "$LOGFILE" 2>&1; then
                    echo "| $app installed successfully"
                    echo "| $app installed successfully" >> "$LOGFILE"
                else
                    echo "| Failed to install $app"
                    echo "| Failed to install $app" >> "$LOGFILE"
                fi
                    ;;
        esac
    done

    # Installing Rust if installed
    if [[ "$apps_to_install" =~ "rustup" ]]; then
        echo "| Installing Rust programming language..."
        echo "| Installing Rust programming language..." >> "$LOGFILE"

        if rustup install stable >> "$LOGFILE" 2>&1; then
            echo "| Rust installed successfully"
            echo "| Rust installed successfully" >> "$LOGFILE"
        else
            echo "| Failed to install Rust"
            echo "| Failed to install Rust" >> "$LOGFILE"
        fi
    else
        printf "\033[31m| Not installing Rust\n"
        printf "\033[31m| Not installing Rust\n" >> "$LOGFILE"
    fi

    # Setting up the SSH server if installed
    if [[ $apps_to_install =~ "openssh-server" ]]; then
        echo "| Setting up SSH server..."
        echo "| Setting up SSH server..." >> "$LOGFILE"

        if sudo systemctl enable ssh >> "$LOGFILE" 2>&1 && sudo systemctl start ssh >> "$LOGFILE" 2>&1; then
            echo "| SSH server set up successfully"
            echo "| SSH server set up successfully" >> "$LOGFILE"
        else
            echo "| Failed to set up SSH server"
            echo "| Failed to set up SSH server" >> "$LOGFILE"
        fi

    else
        printf "\033[31m| Not setting up SSH\n"
        printf "\033[31m| Not setting up SSH\n" >> "$LOGFILE"

    fi

    echo "| Installation complete!"
    echo "| Installation complete!" >> "$LOGFILE"
}

main "$@"
