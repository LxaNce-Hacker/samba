#!/bin/bash

__version__=1.2
clear

## Directories
BASE_DIR=$(realpath "$(dirname "$BASH_SOURCE")")

## Enhanced ANSI colors with cyberpunk theme
RED="$(printf '\033[31m')"
GREEN="$(printf '\033[32m')"
ORANGE="$(printf '\033[33m')"
BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"
CYAN="$(printf '\033[36m')"
WHITE="$(printf '\033[37m')"
BLACK="$(printf '\033[30m')"
YELLOW="$(printf '\033[93m')"
PURPLE="$(printf '\033[95m')"
NEON_GREEN="$(printf '\033[92m')"
NEON_BLUE="$(printf '\033[94m')"
NEON_MAGENTA="$(printf '\033[95m')"
NEON_CYAN="$(printf '\033[96m')"
BRIGHT_WHITE="$(printf '\033[97m')"

# Background colors
REDBG="$(printf '\033[41m')"
GREENBG="$(printf '\033[42m')"
ORANGEBG="$(printf '\033[43m')"
BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"
CYANBG="$(printf '\033[46m')"
WHITEBG="$(printf '\033[47m')"
BLACKBG="$(printf '\033[40m')"

# Special effects
BOLD="$(printf '\033[1m')"
DIM="$(printf '\033[2m')"
BLINK="$(printf '\033[5m')"
REVERSE="$(printf '\033[7m')"
RESETBG="$(printf '\e[0m\n')"
RESET="$(printf '\033[0m')"

## Script termination with cyberpunk style
exit_on_signal_SIGINT() {
    echo -e "\n${NEON_CYAN}╔══════════════════════════════════════════════════════════════╗"
    echo -e "║${RED}${BOLD}  ⚠️  PROGRAM INTERRUPTED - DISCONNECTING FROM SERVER  ⚠️      ${RESET}${NEON_CYAN}║"
    echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"
    reset_color
    exit 0
}

exit_on_signal_SIGTERM() {
    echo -e "\n${NEON_MAGENTA}╔══════════════════════════════════════════════════════════════╗"
    echo -e "║${RED}${BOLD}  🔌  SYSTEM TERMINATED - CLOSING CONNECTION  🔌               ${RESET}${NEON_MAGENTA}║"
    echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"
    reset_color
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
    tput sgr0
    tput op
    return
}

## Cyberpunk loading animation
cyber_loading() {
    local text="$1"
    echo -ne "${NEON_CYAN}[${BLINK}●${RESET}${NEON_CYAN}] ${text}"
    for i in {1..3}; do
        echo -ne "${NEON_GREEN}▓"
        sleep 0.3
    done
    echo -e "${RESET}"
}

# Check for updates with cyberpunk theme
check_update() {
    cyber_loading "Checking for updates"
    relase_url='https://api.github.com/repos/LxaNce-Hacker/samba/releases/latest'
    new_version=$(curl -s "${relase_url}" | grep '"tag_name":' | awk -F\" '{print $4}' 2>/dev/null)
    tarball_url="https://github.com/LxaNce-Hacker/samba/archive/refs/tags/${new_version}.tar.gz"

    if [[ $new_version != $__version__ && -n $new_version ]]; then
        echo -e "${NEON_MAGENTA}[${BLINK}⚡${RESET}${NEON_MAGENTA}] ${YELLOW}UPDATE AVAILABLE${RESET}"
        sleep 2
        echo -e "\n${NEON_GREEN}[${WHITE}↓${NEON_GREEN}]${ORANGE} Downloading update..."
        pushd "$HOME" > /dev/null 2>&1
        wget "${tarball_url}" -O ".samba.tar.gz" 2>/dev/null

        if [[ -e ".samba.tar.gz" ]]; then
            tar -xf .samba.tar.gz -C "$BASE_DIR" --strip-components 1 > /dev/null 2>&1
            [ $? -ne 0 ] && { echo -e "\n\n${RED}[${WHITE}!${RED}]${RED} Error occurred during extraction."; reset_color; exit 1; }
            rm -f .samba.tar.gz
            popd > /dev/null 2>&1
            { sleep 3; clear; banner; }
            echo -e "\n${NEON_GREEN}[${WHITE}✓${NEON_GREEN}] Update successful! Please restart the tool\n${RESET}"
            { reset_color ; exit 1; }
        else
            echo -e "\n${RED}[${WHITE}!${RED}]${RED} Download failed. Please try again."
            { reset_color; exit 1; }
        fi
    else
        echo -e "${NEON_GREEN}Already up to date${RESET}"
        sleep 0.5
    fi
}

## Check Internet Status with cyberpunk theme
check_status() {
    echo -ne "\n${NEON_CYAN}[${WHITE}◉${NEON_CYAN}]${PURPLE} Internet Status : "
    timeout 3s curl -fIs "https://api.github.com" > /dev/null 2>&1
    [ $? -eq 0 ] && echo -e "${NEON_GREEN}${BOLD}ONLINE${RESET}" && check_update || echo -e "${RED}${BOLD}OFFLINE${RESET}"
}

## Enhanced consent with cyberpunk theme
get_consent() {
    echo -e "${NEON_CYAN}╔═══════════════════════════════════════════════════════════════╗"
    echo -e "║${YELLOW}${BOLD}                    ⚖️  LEGAL USAGE AGREEMENT  ⚖️                  ${RESET}${NEON_CYAN}║"
    echo -e "╠═══════════════════════════════════════════════════════════════╣"
    echo -e "║${WHITE} This tool requires proper authorization for usage:             ${NEON_CYAN}║"
    echo -e "║${NEON_GREEN} 1. You OWN the target network/system, OR                      ${NEON_CYAN}║"
    echo -e "║${NEON_GREEN} 2. You have EXPLICIT written permission from owner, OR        ${NEON_CYAN}║"
    echo -e "║${NEON_GREEN} 3. You are performing AUTHORIZED penetration testing          ${NEON_CYAN}║"
    echo -e "╠═══════════════════════════════════════════════════════════════╣"
    echo -e "║${RED}${BOLD} ⚠️  UNAUTHORIZED ACCESS IS ILLEGAL AND UNETHICAL  ⚠️           ${RESET}${NEON_CYAN}║"
    echo -e "║${WHITE} This tool is for educational and authorized testing only       ${NEON_CYAN}║"
    echo -e "╚═══════════════════════════════════════════════════════════════╝${RESET}"
    echo -e ""

    while true; do
        read -p "${NEON_MAGENTA}[${WHITE}?${NEON_MAGENTA}] ${CYAN}Do you have legal authorization to proceed? ${NEON_GREEN}[${WHITE}yes${NEON_GREEN}/${RED}no${NEON_GREEN}]: ${RESET}" consent

        case ${consent,,} in
            yes|y)
                echo -e "${NEON_GREEN}[${WHITE}✓${NEON_GREEN}] ${BOLD}Authorization confirmed - Proceeding...${RESET}"
                sleep 1
                break
                ;;
            no|n)
                echo -e "${RED}[${WHITE}✗${RED}] ${BOLD}Authorization required - Exiting tool...${RESET}"
                exit 1
                ;;
            *)
                echo -e "${ORANGE}[${WHITE}!${ORANGE}] Invalid input. Please enter 'yes' or 'no'${RESET}"
                ;;
        esac
    done
}

## Cyberpunk Banner
banner() {
    cat <<- EOF
		${RED}
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠴⠖⠒⠛⠛⠒⠦⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢺⠃⠀⠀⠀⣀⡀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⣴⣶⣿⣿⣷⠟⠉⠉⢳⡄⠀⠀⠀⠀⠀⠀⣯⠉⠙⠒⠦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣆⣀⣀⣴⠇⠀⠀⠀⠀⡤⠀⣼⣇⠀⠀⠀⠀⠈⠙⠶⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣟⣿⠾⠷⣿⣿⣦⡀⠀⠀⠀⠀⣴⠃⢠⠇⢹⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⢀⣄⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣟⠀⣠⡟⠁⠙⠿⣦⠀⢀⣾⠏⢠⠏⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠸⡏⠉⠉⠙⠛⠛⠛⠛⠛⠿⠶⠶⠶⢶⣶⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠟⣟⠀⠀⣀⣴⣟⣴⣟⣡⣴⣯⣤⣀⣼⠀⠀⠀⢰⡄⠀⠀⠀⠀⠀⠀⠀⠹⣆⠀⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⡄⠀⠀⠀⠀⠀⠀⠀⢸⠀⠸⣿⣿⣟⣋⣉⣉⣯⣀⣸⠃⠀⠈⠃⠀⠀⠀⢘⣇⠀⠀⠀⠀⠀⣠⡦⠀⠙⣆⠀⠀⠀⠀⠀⠀
		${RED}⠀⠀⠀⠀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⡄⠀⠀⠀⠀⠀⠀⢸⡆⢰⣟⣚⣛⣛⣿⣛⣛⣛⣿⣆⣀⣀⣀⣤⡀⠀⠀⢿⡄⡄⠀⢀⣾⣿⠇⠀⠀⠹⡄⠀⠀⠀⠀⠀
		${RED}⢤⢤⣤⣀⣀⣱⡀SAMBA SERVER⠀⠈⢿⣄⠀⢀⣀⣀⣠⣾⣧⣸⡇⠀⠀⠀⠀⣠⡾⣛⣋⣭⡥⠴⠂⠘⣿⡄⠀⠘⣿⣧⡴⠟⠋⣁⠀⠀⠀⠀⢷⠀⠀⠀⠀⠀
		${RED}⢸⠀⠀⠀⠀⠉⠻⡄⠀Don't Misuse⠈⢿⡟⠉⠙⠻⣍⠉⠃⠙⠷⠤⢤⠤⠤⠼⠿⣿⣯⠤⠤⠐⠀⠀⢻⣿⣦⣤⣾⠿⣷⣶⣯⣥⣴⣶⣶⣦⣼⡆⠀⠀⠀⠀
		${RED}⢸⠀⠀⠀⠀⠀⠀⠹⣆⠀⠀⠀⠀It⠀⠀⠀⠀⠀⠀⠀⠈⢿⡶⠶⠒⣿⣄⣀⣀⡀⠀⢸⡆⠀⠀⢠⠏⢳⡖⠒⠒⠀⠀⢸⣿⣇⠈⠙⡆⠀⠙⠣⠀⠀⠀⠀⠀⠙⣧⠀⠀⠀⠀
		${RED}⢸⠀⠀⠀⠀⠀⠀⠀⠘⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣥⣿⣯⣿⣿⣿⠿⢿⣶⣶⣾⠤⢬⣽⣷⣶⣦⣴⣿⣿⠏⠀⠀⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡀⠀⠀⠀
		${RED}⢸⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⣈⣉⣽⣿⣶⠖⠀⠉⠉⠙⠳⠤⣤⣴⣃⣀⣀⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⠀⠀
		${RED}⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠒⠲⠤⢄⣀⣀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⠟⠛⠛⠛⠛⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠉⠓⠛⠓⠢⠤⣄
		${RED}⠸⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠬⠭⠭⠿⠶⢶⣶⣾⣯⡤⡥⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⢼
		${RED}                                                  Version : ${__version__}
${NEON_CYAN}
╠════════════════════════════════════════════════════════════════════╣
║${NEON_GREEN} Purpose: ${WHITE}Network Administration & Authorized File Sharing          ${NEON_CYAN}║
║${NEON_GREEN} Author:  ${WHITE}LxaNce-Hacker - Enhanced Security Edition                 ${NEON_CYAN}║
║${YELLOW} Warning: ${RED}${BOLD}Only use on networks you own or have explicit permission  ${RESET}${NEON_CYAN}║
╚════════════════════════════════════════════════════════════════════╝
${RESET}

${NEON_GREEN}░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
${NEON_BLUE}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
${NEON_MAGENTA}██████████████████████████████████████████████████████████████████████
${RESET}

EOF
    check_status
}

## Enhanced input validation
validate_ip() {
    local ip=$1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 0
    else
        return 1
    fi
}

## Main function with cyberpunk theme
main() {
    clear
    banner
    get_consent
    clear
    banner

    echo -e ""
    echo -e "${NEON_CYAN}╔══════════════════════════════════════════════════════════════╗"
    echo -e "║${YELLOW}${BOLD}                🎯 SMB SERVER CONNECTION 🎯                   ${RESET}${NEON_CYAN}║"
    echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo -e ""

    # IP Input with validation
    while true; do
        read -p "${NEON_MAGENTA}[${WHITE}◉${NEON_MAGENTA}]${NEON_GREEN} Enter Target Server IP: ${NEON_CYAN}" IP
        if validate_ip "$IP"; then
            echo -e "${NEON_GREEN}[${WHITE}✓${NEON_GREEN}] Valid IP detected - Target locked...${RESET}"
            break
        else
            echo -e "${RED}[${WHITE}✗${RED}] Invalid IP format. Please enter a valid IPv4 address.${RESET}"
        fi
    done

    echo -e ""
    read -n1 -p "${NEON_MAGENTA}[${WHITE}?${NEON_MAGENTA}]${ORANGE} Do you want to change the WorkGroup? ${NEON_GREEN}[${NEON_CYAN}Y${NEON_GREEN}/${NEON_CYAN}N${NEON_GREEN}]: ${ORANGE}" op

    if [[ ${op,,} == "y" ]]; then
        echo -e "\n"
        read -p "${NEON_MAGENTA}[${WHITE}◉${NEON_MAGENTA}]${NEON_GREEN} Enter Target WorkGroup: ${NEON_CYAN}" workground
        echo -e "${NEON_GREEN}[${WHITE}✓${NEON_GREEN}] WorkGroup configured: ${YELLOW}$workground${RESET}"
    else
        echo -e "${NEON_BLUE}\n[${WHITE}◉${NEON_BLUE}] Using default WorkGroup configuration...${RESET}"
    fi

    echo -e ""
    read -p "${NEON_MAGENTA}[${WHITE}◉${NEON_MAGENTA}]${NEON_GREEN} Enter Target Server Username: ${NEON_CYAN}" username

    echo -e ""
    echo -e "${NEON_CYAN}╔══════════════════════════════════════════════════════════════╗"
    echo -e "║${YELLOW}${BOLD}             🔍 SCANNING SMB SHARED FOLDERS 🔍                ${RESET}${NEON_CYAN}║"
    echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"
    echo -e ""

    cyber_loading "Connecting to SMB server"

    echo -e "${BRIGHT_WHITE}"
    if [[ ${workground} ]]; then
        smbclient -L $IP -W $workground -U $username
    else
        smbclient -L $IP -U $username
    fi
    echo -e "${RESET}"

    echo -e ""
    read -n1 -p "${NEON_MAGENTA}[${WHITE}?${NEON_MAGENTA}]${ORANGE} Do you want to connect to the server? ${NEON_GREEN}[${NEON_CYAN}Y${NEON_GREEN}/${NEON_CYAN}N${NEON_GREEN}]: ${ORANGE}" ops

    if [[ ${ops,,} == "y" ]]; then
        echo -e "\n"
        read -p "${NEON_MAGENTA}[${WHITE}◉${NEON_MAGENTA}]${NEON_GREEN} Enter Target Share Name: ${NEON_CYAN}" sharename

        echo -e ""
        echo -e "${NEON_CYAN}╔══════════════════════════════════════════════════════════════╗"
        echo -e "║${YELLOW}${BOLD}                🔗 ESTABLISHING CONNECTION 🔗                ${RESET}${NEON_CYAN}║"
        echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"

        cyber_loading "Connecting to share"

        echo -e "${NEON_GREEN}[${WHITE}✓${NEON_GREEN}] Connection established successfully${RESET}"
        echo -e "${BRIGHT_WHITE}"

        if [[ ${workground} ]]; then
            smbclient \\\\$IP\\${sharename:-C$} -W $workground -U $username
        else
            smbclient \\\\$IP\\${sharename:-C$} -U $username
        fi
    else
        echo -e ""
        echo -e "${NEON_BLUE}╔══════════════════════════════════════════════════════════════╗"
        echo -e "║${CYAN}${BOLD}              🔌 DISCONNECTING FROM SERVER 🔌                 ${RESET}${NEON_BLUE}║"
        echo -e "╚══════════════════════════════════════════════════════════════╝${RESET}"
        echo -e "${NEON_GREEN}[${WHITE}◉${NEON_GREEN}] Connection terminated - Goodbye!${RESET}"
        { reset_color; exit 1; }
    fi
}

# Execute main function
main
