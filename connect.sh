## LxaNce Hacker 
__version__=1.0
clear

## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"



## Script termination
exit_on_signal_SIGINT() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
	exit 0
}

exit_on_signal_SIGTERM() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
	exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
	return
}


# Check for a newer release
check_update(){
	echo -ne "${GREEN}[${WHITE}+${GREEN}]${CYAN} Checking for update : "
	relase_url='https://api.github.com/repos/LxaNce-Hacker/samba/releases/latest'
	new_version=$(curl -s "${relase_url}" | grep '"tag_name":' | awk -F\" '{print $4}')
	tarball_url="https://github.com/LxaNce-Hacker/samba/archive/refs/tags/${new_version}.tar.gz"

	if [[ $new_version != $__version__ ]]; then
		echo -ne "${ORANGE}update found\n"${WHITE}
		sleep 2
		echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Downloading Update..."
		pushd "$HOME" > /dev/null 2>&1
		wget "${tarball_url}" -O ".samba.tar.gz"

		if [[ -e ".samba.tar.gz" ]]; then
			tar -xf .samba.tar.gz -C "$BASE_DIR" --strip-components 1 > /dev/null 2>&1
			[ $? -ne 0 ] && { echo -e "\n\n${RED}[${WHITE}!${RED}]${RED} Error occured while extracting."; reset_color; exit 1; }
			rm -f .samba.tar.gz
			popd > /dev/null 2>&1
			{ sleep 3; clear; banner_small; }
			echo -ne "\n${GREEN}[${WHITE}+${GREEN}] Successfully updated! Run samba again\n\n"${WHITE}
			{ reset_color ; exit 1; }
		else
			echo -e "\n${RED}[${WHITE}!${RED}]${RED} Error occured while downloading."
			{ reset_color; exit 1; }
		fi
	else
		echo -ne "${GREEN}up to date\n${WHITE}" ; sleep .5
	fi
}


## Check Internet Status
check_status() {
	echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Internet Status : "
	timeout 3s curl -fIs "https://api.github.com" > /dev/null
	[ $? -eq 0 ] && echo -e "${GREEN}Online${WHITE}" && check_update || echo -e "${RED}Offline${WHITE}"
}

## Banner
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

		${GREEN}[${WHITE}-${GREEN}]${CYAN} Tool Created by LxaNce-Hacker (Prince Katiyar)${WHITE}
	EOF
	check_status
}

banner

echo -e
read -p "${RED}[${ORANGE}*${RED}]${GREEN} Enter Target IP : ${RED}" IP

read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Do You Want To Change The WorkGround ? ${GREEN}[${CYAN}Y${GREEN}/${CYAN}N${GREEN}] :${ORANGE} " op

if [[ ${op,,} == "y" ]]; then
	echo -e "\n"
	read -p "${RED}[${ORANGE}*${RED}]${GREEN} Enter Target WorkGround : ${RED}" workground
else
	echo -e "${RED}\n\n                                          ...Ok Dear"
fi

read -p "${RED}[${ORANGE}*${RED}]${GREEN} Enter Target Server Username : ${RED}" username

if [[ ${workground} ]]; then
	smbclient -L $IP -W $workground -U $username
else
	smbclient -L $IP -U $username
fi
read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Do You Want To Connect That Server? ${GREEN}[${CYAN}Y${GREEN}/${CYAN}N${GREEN}] :${ORANGE} " ops

if [[ ${ops,,} == "y" ]]; then
	echo -e "\n"
	read -p "${RED}[${ORANGE}*${RED}]${GREEN} Enter Target ShareName : ${RED}" sharename
	if [[ ${workground} ]]; then
		smbclient \\\\$IP\\C$ -W $workground -U $username 
	else
		smbclient \\\\$IP\\C$ -U $username 
	fi
else
	echo -e "${GREEN}\n\n                                        ...Bye "
	{ reset_color; exit 1; }
fi


