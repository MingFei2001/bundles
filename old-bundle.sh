#!/bin/sh

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
#
# ------------------------------------------

# ------------------------------------------
# Welcoming text
echo " "
echo "| Basic Ubuntu and Debian Linux ESSENTIAL Setup Script"
echo "| a.k.a. BUNDLE Setup Script"
echo "| Made by mingfei"
echo "| p/s: Run this script with sudo priviledges"
echo " "
# ------------------------------------------

# ------------------------------------------
# Update the system to the latest
echo "| Updating System..."
echo " "
apt-get update
apt-get upgrade -y
echo " "
# ------------------------------------------
# Start to install software
echo "| installing curl build-essential"
apt install curl build-essential -y
echo " "

echo "| installing git tldr"
apt install git tldr -y
echo " "

echo "| installing vim neofetch duf"
apt install vim neofetch duf -y
echo " "

echo "| installing btop cmatrix"
apt install btop cmatrix -y
echo " "

echo "| installing fzf ripgrep"
apt install fzf ripgrep -y
echo " "

echo "| installing fdclone cmake"
apt install fdclone cmake -y
echo " "

echo "| installing speedtest-cli tty-clock"
apt install speedtest-cli tty-clock -y
echo " "

echo "| installing ranger tmux"
apt install ranger tmux -y
echo " "

# ------------------------------------------
# End of script
echo " "
echo "| That's the end of the script."
echo "| Exiting..."
echo " "
# ------------------------------------------
# Old bundle extra script
# ------------------------------------------
# System Utilities

# echo "| installing stacer"
# apt install stacer -y
# echo " "

# echo "| installing uget"
# apt install uget -y
# echo " "

# echo "| installing scrcpy"
# apt install scrcpy -y
# echo " "

# echo "| installing pandoc"
# apt install pandoc -y
# echo " "

# echo "| installing gparted"
# apt install gparted -y
# echo " "

# echo "| installing sysbench"
# apt install sysbench -y
# echo " "

# echo "| installing docker docker-compose"
# apt install docker docker-compose -y
# echo " "

# echo "| installing hardinfo"
# apt install hardinfo -y
# echo " "

# echo "| installing cpu-x"
# apt install cpu-x -y
# echo " "
#
# ------------------------------------------
# Cybersecurity Applications

# echo "| installing nmap"
# apt install netcat -y
# echo " "

# echo "| installing netcat"
# apt install netcat -y
# echo " "

# echo "| installing wireshark"
# apt install wireshark -y
# echo " "

# echo "| installing tshark"
# apt install tshark -y
# echo " "

# echo "| installing clamav"
# apt install clamav -y
# echo " "

# echo "| installing gufw"
# apt install gufw -y
# echo " "

# ------------------------------------------
# Creative Suite
#
# echo "| installing mpv"
# apt install mpv -y
# echo " "

# echo "| installing vlc"
# apt install vlc -y
# echo " "

# echo "| installing celluloid"
# apt install celluloid -y
# echo " "

# echo "| installing gimp"
# apt install gimp -y
# echo " "

# echo "| installing krita"
# apt install krita -y
# echo " "

# echo "| installing inkscape"
# apt install inkscape -y
# echo " "

# echo "| installing kdenlive"
# apt install kdenlive -y
# echo " "

# echo "| installing audacity"
# apt install audacity -y
# echo " "

# echo "| installing obs-studio"
# apt install obs-studio -y
# echo " "

# echo "| installing libreoffice"
# apt install libreoffice -y
# echo " "

# echo "| installing qutebrowser"
# apt install qutebrowser -y
# echo " "

# echo "| installing blender"
# apt install blender -y
# echo " "

# ------------------------------------------

### Take note that chromium is not in ubuntu repositories
# apt install chromium -y
# snap install chromium
# snap install code --classic
# snap install neovim --classic

# ------------------------------------------
