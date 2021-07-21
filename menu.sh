#!/bin/sh
show_menu(){
    normal=`echo "\033[m"`
    menu=`echo "\033[36m"` #blue
    number=`echo "\033[33m"` #yellow
    bgred=`echo "\033[41m"`
    fgred=`echo "\033[31m"`
    printf "\n${menu}********* WAGO Provisioning Tool ***********${normal}\n"
    printf "${menu} ${number} 1)${menu} Install Docker ${normal}\n"
    printf "${menu} ${number} 2)${menu} Disable PLC Runtime ${normal}\n"
    printf "${menu} ${number} 3)${menu} Disable OPC-UA ${normal}\n"
    printf "${menu} ${number} 9)${menu} Restart PLC ${normal}\n"
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
            option_picked "Option 1 Picked - Install Docker";
            wget https://github.com/WAGO/docker-ipk/releases/download/v1.0.4-beta/docker_20.10.5_armhf.ipk;
            opkg install docker_20.10.5_armhf.ipk; 
            rm docker_20.10.5_armhf.ipk;
            printf "Docker v20.10.5 Installed.";
            clear;
            show_menu;
        ;;
        2) clear;
            option_picked "Option 2 Picked - Disable Runtime";
            /etc/config-tools/config_runtime runtime-version=0;
            printf "Stopping Runtime";
            show_menu;
        ;;
        3) clear;
            option_picked "Option 4 Picked - Disable OPC-UA";
            /etc/config-tools/config-opcua --set=\"state\":\"disable\";
            /etc/config-tools/config-opcua -r 
            printf "OPC-UA Disabled";
            show_menu;
        ;;
        9) clear;
            option_picked "Option 3 Picked - Rebooting";
            reboot now;
            printf "PLC will restart";
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