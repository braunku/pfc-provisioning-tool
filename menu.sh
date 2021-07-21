#!/bin/sh
show_menu(){
    normal=`echo "\033[m"`
    menu=`echo "\033[36m"` #Blue
    number=`echo "\033[33m"` #yellow
    bgred=`echo "\033[41m"`
    fgred=`echo "\033[31m"`
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} 1)${menu} Install Docker ${normal}\n"
    printf "${menu}**${number} 2)${menu} Disable PLC Runtime ${normal}\n"
    printf "${menu}**${number} 3)${menu} Restart APLC ${normal}\n"
    printf "${menu}**${number} 4)${menu} Some other commands ${normal}\n"
    printf "${menu}**${number} 5)${menu} Some other commands${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please enter a menu option and enter or ${fgred}x to exit. ${normal}"
    read opt
}

option_picked(){
    msgcolor=`echo "\033[01;31m"` # bold red
    normal=`echo "\033[00;00m"` # normal white
    message=${@:-"${normal}Error: No message passed"}
    printf "${msgcolor}${message}${normal}\n"
}

clear
show_menu
while [ $opt != '' ]
    do
    if [ $opt = '' ]; then
      exit;
    else
      case $opt in
        1) clear;
            option_picked "Option 1 Picked";
            wget https://github.com/WAGO/docker-ipk/releases/download/v1.0.4-beta/docker_20.10.5_armhf.ipk
            opkg install docker_20.10.5_armhf.ipk 
            rm docker_20.10.5_armhf.ipk
            printf "Installing Docker v20.10.5";
            show_menu;
        ;;
        2) clear;
            option_picked "Option 2 Picked";
            /etc/config-tools/config_runtime runtime-version=0
            printf "Stopping Runtime";
            show_menu;
        ;;
        3) clear;
            option_picked "Option 3 Picked";
            reboot now
            printf "PLC will restart";
            show_menu;
        ;;
        4) clear;
            option_picked "Option 4 Picked";
            printf "ssh lmesser@ -p 2010";
            show_menu;
        ;;
        x)exit;
        ;;
        \n)exit;
        ;;
        *)clear;
            option_picked "Pick an option from the menu";
            show_menu;
        ;;
      esac
    fi
done    