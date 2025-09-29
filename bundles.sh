#!/usr/bin/env bash

# Enhanced error handling
set -euo pipefail

#═══════════════════════════════════════════════════════════════════════════════
#     ____  __  ___   ______  __    ___________
#    / __ )/ / / / | / / __ \/ /   / ____/ ___/
#   / __  / / / /  |/ / / / / /   / __/  \__ \
#  / /_/ / /_/ / /|  / /_/ / /___/ /___ ___/ /
# /_____/\____/_/ |_/_____/_____/_____//____/
#═══════════════════════════════════════════════════════════════════════════════
# BUNDLES - Essential Package Installation Script for Ubuntu/Debian
# Created by: mingfei
# Usage: ./bundles.sh [--help]
#
# Installs curated collections of packages across different categories:
# • Basic Tools      • CLI Utilities     • Desktop Apps      • Programming
# • Media Tools      • Disk Management   • Security Tools    • Full Suite
#═══════════════════════════════════════════════════════════════════════════════

# Variables
LOGFILE="install.log"

# Enhanced logging with timestamps and levels
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOGFILE"
}

log_info() { log "INFO" "$@"; }
log_error() { log "ERROR" "$@"; }
log_warn() { log "WARN" "$@"; }
log_success() { log "SUCCESS" "$@"; }

# Enhanced error handler
error_handler() {
    local line_num=$1
    log_error "Script failed at line $line_num"
    log_error "Last command: $BASH_COMMAND"
    log_error "Cleaning up and exiting..."
    cleanup
    exit 1
}

# Cleanup function
cleanup() {
    log_info "Performing cleanup..."
    # Add cleanup tasks here if needed
}

# Set up error trapping
trap 'error_handler $LINENO' ERR
trap 'log_info "Script interrupted by user"; cleanup; exit 130' SIGINT
trap 'cleanup' EXIT

# Define the lists of applications
declare -A app_lists
app_lists[basic]="curl build-essential htop git vim fzf ripgrep fdclone cmake zip tmux unzip locate bat jq wget rsync openssh-server 7zip power-profiles-daemon mtr unp"
app_lists[cli]="btop tldr neofetch cmatrix speedtest-cli ranger tty-clock lynx cava sysbench vlock mocp pipes-sh iotop iftop atop nvtop iperf3 wavemon lshw cbonsai s-tui"
app_lists[desktop]="qalculate-gtk hardinfo cpu-x libreoffice gdebi thunderbird"
app_lists[diskman]="bleachbit stacer gnome-disk-utility gparted duf fdisk kdiskmark ndcu"
app_lists[programming]="python3-full python3-pip python3-virtualenv golang npm nodejs gcc rustup docker.io docker-compose lazygit lazydocker"
app_lists[media]="kdenlive vlc blender audacity gimp inkscape krita obs-studio ffmpeg darktable mpv celluloid geeqie"
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
    # Initialize logging
    log_info "=== Bundle Setup Script Started ==="

    print_ascii_art
    echo ""
    print_menu

    # Retrieve installation options
    install_type=$(get_user_choice)
    if [ "$install_type" == "abort" ]; then
        log_info "Installation aborted by user"
        exit 0
    fi
    apps_to_install=${app_lists[$install_type]}

    # if the list is empty
    if [ -z "$apps_to_install" ]; then
        log_error "No applications to install for category: $install_type"
        exit 1
    fi

    # Confirmation message
    echo "| The following apps will be installed:"
    echo "| $apps_to_install"
    read -p "| Do you want to proceed? (y/n): " confirm
    if [[ $confirm != [yY] ]]; then
        log_info "Installation cancelled by user"
        exit 0
    fi

    # Loop through the apps and install them
    log_info "Updating package lists..."
    sudo apt update

    for app in $apps_to_install; do
        log_info "Installing $app..."

        # Choose the right install command
        case "$app" in
            "lazygit")
                cmd="go install github.com/jesseduffield/lazygit@latest"
                ;;
            "lazydocker")
                cmd="go install github.com/jesseduffield/lazydocker@latest"
                ;;
            *)
                cmd="sudo apt-get install -y $app"
                ;;
        esac

        # Execute and log (same for all)
        if $cmd >> "$LOGFILE" 2>&1; then
            log_success "$app installed successfully"
        else
            log_error "Failed to install $app"
        fi
    done

    # Post-installation setup function
    post_install_setup() {
        local package="$1"
        local description="$2"
        local command="$3"

        if [[ "$apps_to_install" =~ "$package" ]]; then
            log_info "Setting up $description..."

            if eval "$command" >> "$LOGFILE" 2>&1; then
                log_success "$description set up successfully"
            else
                log_error "Failed to set up $description"
            fi
        fi
    }

    # Run post-installation setup
    post_install_setup "rustup" "Rust programming language" "rustup install stable"
    post_install_setup "openssh-server" "SSH server" "sudo systemctl enable ssh && sudo systemctl start ssh"
    post_install_setup "locate" "locate database" "sudo updatedb"

    # Docker reminder if installed
    if [[ "$apps_to_install" =~ "docker.io" ]]; then
        echo ""
        log_info "IMPORTANT: To use Docker without sudo, run the following command:"
        echo "           sudo usermod -aG docker \$USER"
        echo "           Then log out and back in for changes to take effect."
        echo ""
    fi

    log_success "=== Installation completed successfully! ==="
}

main "$@"
