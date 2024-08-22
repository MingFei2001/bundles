#!/usr/bin/env bash

# ------------------------------------------
# ____   _    _  _   _  _____   _       ______
# |  _ \ | |  | || \ | ||  __ \ | |     |  ____|
# | |_) || |  | ||  \| || |  | || |     | |__
# |  _ < | |  | || . ` || |  | || |     |  __|
# | |_) || |__| || |\  || |__| || |____ | |____
# |____/  \____/ |_| \_||_____/ |______||______|
#
# ------------------------------------------

# ------------------------------------------
# Welcome to BUNDLE setup script
# Basic Ubuntu and Debian Linux ESSENTIAL Setup Script
# This script is made by me, mingfei
# ------------------------------------------
# This script is created so i can just
# simply git clone this and run it in bash
# to install simple apps
# ------------------------------------------
# P/S: Use it at your own risk
# ------------------------------------------

# ------------------------------------------
# List of software
#
# curl build-essential git tldr vim neofetch duf
# btop cmatrix fzf ripgrep fdclone cmake zip
# speedtest-cli ranger tty-clock tmux unzip
# locate bat
#
# ------------------------------------------


# Define the lists of applications
declare -A app_lists
app_lists[basic]="curl build-essential git tldr vim neofetch duf btop cmatrix fzf ripgrep fdclone cmake zip speedtest-cli ranger tty-clock tmux unzip locate bat"
app_lists[advanced]="${app_lists[basic]} app4 app5 app6 app7 app8 app9"
app_lists[extras]="app10 app11 app12"

echo "| -----------------------------";
echo "| Bundle Setup Script";
echo "| -----------------------------";
echo "| [1] Basic installation";
echo "| [2] Full installation";
echo "| [3] Extras installation";
echo "| [0] Abort";
echo "| -----------------------------";

# Function to display menu and get user choice
get_user_choice() {
    while true; do
        read -p "| Enter your choice (1-3): " choice
        case $choice in
            1) echo "basic"; break ;;
            2) echo "advanced"; break ;;
            3) echo "extras"; break ;;
            *) echo "| Invalid choice. Please enter a number between 1 and 3." ;;
        esac
    done
}

# Main script
install_type=$(get_user_choice)
apps_to_install=${app_lists[$install_type]}

if [ -z "$apps_to_install" ]; then
    echo "| No applications to install."
    exit 0
fi

echo "| The following apps will be installed:"
echo "| $apps_to_install"

read -p "| Do you want to proceed? (y/n): " confirm
if [[ $confirm != [yY] ]]; then
    echo "| Installation cancelled."
    exit 0
fi

# Loop through the apps and install them
for app in $apps_to_install; do
    echo "| Installing $app..."
    # Uncomment the following line to actually install the apps
    if sudo apt-get install -y "$app"; then
        echo "| $app installed successfully"
    else
        echo "| Failed to install $app"
    fi
done

echo "| Installation complete!"
