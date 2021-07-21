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
    printf "${menu} ${number} 3)${menu} Disable OPC-UA & IO-Check Services${normal}\n"
    printf "${menu} ${number} 4)${menu} Install KBUS Daemon ${normal}\n"
    printf "${menu} ${number} 5)${menu} Install Containers ${normal}\n"

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

show_container_menu(){
    normal=`echo "\033[m"`
    menu=`echo "\033[36m"` #blue
    number=`echo "\033[33m"` #yellow
    bgred=`echo "\033[41m"`
    fgred=`echo "\033[31m"`
    printf "\n${menu}********* Docker Containers ***********${normal}\n"
    printf "${menu} ${number} a)${menu} Install Node-RED ${normal}\n"
    printf "${menu} ${number} b)${menu} Install Mosquitto ${normal}\n"
    printf "${menu} ${number} c${menu} Install KBUS Modbus ${normal}\n"
    printf "${menu} ${number} d)${menu} Install Grafana ${normal}\n"
    printf "${menu} ${number} e)${menu} Install InfluxDB ${normal}\n"
    printf "${menu} ${number} 8)${menu} Main Menu ${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please enter a menu option and enter or ${fgred}x to exit. ${normal}"
    read opt
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
            option_picked "Option 3 Picked - Disable OPC-UA & IO Check Services";
            /etc/config-tools/config-opcua --set=\"state\":\"disable\";
            /etc/config-tools/config-opcua -r 
            printf "OPC-UA Disabled";
            /etc/config-tools/config_iocheckport state="disabled";
            printf "IO Check Disabled";
            show_menu;
        ;;
        4) clear;
            option_picked "Option 4 Picked - Install KBUS Daemon";
            wget https://github.com/jessejamescox/kbus-daemon-installer/archive/refs/heads/main.zip 
            unzip main.zip 
            sh kbus-daemon-installer-main/installer.sh
            printf "KBUS Daemon Installed";
            show_menu;
        ;;

        5) clear; # Docker sub-menu
            option_picked "Option 5 Picked - Install Containers";
            printf "Select Container";
            show_container_menu;
        ;;
        8) clear; # Return to main menu
            show_menu;
        ;;
        9) clear;
            option_picked "Option 9 Picked - Rebooting";
            reboot now;
            printf "PLC will restart";
            show_menu;
        ;;
        x) clear;
            chmod +x menu.sh;
            printf "Type ./menu.sh to re-open this tool";
            printf "\n";
            exit;
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