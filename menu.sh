#!/bin/sh
show_menu(){
    normal=`echo "\033[m"`
    menu=`echo "\033[36m"` #Blue
    number=`echo "\033[33m"` #yellow
    bgred=`echo "\033[41m"`
    fgred=`echo "\033[31m"`
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} 1)${menu} Disable PLC Runtime${normal}\n"
    printf "${menu}**${number} 2)${menu} Install Docker${normal}\n"
    printf "${menu}**${number} 3)${menu} Install KBUS Daemon${normal}\n"
    printf "${menu}**${number} 4)${menu} Disable OPC-UA Server${normal}\n"
    printf "${menu}**${number} 5)${menu} Disable IO-Check${normal}\n"
    printf "${menu}**${number} 6)${menu} Restart PLC${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please enter a menu option and enter or ${fgred}x to exit. ${normal$
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
            printf "sudo mount /dev/sdh1 /mnt/DropBox/; #The 3 terabyte";
            show_menu;
        ;;
        2) clear;
            option_picked "Option 2 Picked";
            printf "sudo mount /dev/sdi1 /mnt/usbDrive; #The 500 gig drive";
            show_menu;
        ;;
        3) clear;
            option_picked "Option 3 Picked";
            printf "sudo service apache2 restart";
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