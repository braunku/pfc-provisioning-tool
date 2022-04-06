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
    printf "${menu} ${number} 4)${menu} Install KBUS MQTT Daemon ${normal}\n"
    printf "${menu} ${number} 5)${menu} Install Containers ${normal}\n"
    printf "${menu} ${number} 6)${menu} Install DataPlotterApp 2.4 ${normal}\n"
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
    printf "${menu} ${number} c)${menu} Install KBUS Modbus ${normal}\n"
    printf "${menu} ${number} d)${menu} Install Grafana ${normal}\n"
    printf "${menu} ${number} e)${menu} Install InfluxDB ${normal}\n"
    printf "${menu} ${number} f)${menu} Install KBUX Daemon Container Beta ${normal}\n"
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
        6) clear;
            option_picked "Option 6 Picked - Install DataPlotterApp";
            wget https://github.com/braunku/pfc-provisioning-tool/raw/main/install-dataplotter_2.4_armhf.ipk;
            opkg install install-dataplotter_2.4_armhf.ipk; 
            rm install-dataplotter_2.4_armhf.ipk;
            printf "DataPlotterApp 2.4 Installed.  Accessible at http://<pfc-ip-address>/dataplotter/dataplotter.html";
            show_menu;
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
        a) clear;
            option_picked "Option a Picked - Install Node-RED";
            docker volume create --name node_red_user_data;
            docker run --restart unless-stopped -d --name node-red --network=host -v node_red_user_data:/data nodered/node-red:latest-minimal;
            printf "Node-RED Installed";
            show_container_menu;
        ;;
        b) clear;
            option_picked "Option b Picked - Install Mosquitto Broker 1.5";
            docker run -d --restart unless-stopped --name mosquitto --network=host eclipse-mosquitto:1.5;
            printf "Mosquitto Broker v1.5 Installed";
            show_container_menu;
        ;;
        c) clear;
            option_picked "Option c Picked - Install KBUS Modbus Coupler";
            docker run -d --init --restart unless-stopped --privileged -p 502:502 --name=pfc-modbus-server -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket wagoautomation/pfc-modbus-server; 
            printf "KBUS Modbus Coupler Installed";
            show_container_menu;
        ;;
        d) clear;
            option_picked "Option d Picked - Install Grafana";
            docker volume create grafana-storage;
            docker run -d --restart unless-stopped --network=host --name=grafana -v grafana-storage:/var/lib/grafana grafana/grafana;
            printf "Grafana Installed";
            show_container_menu;
        ;;
        e) clear;
            option_picked "Option e Picked - Install InfluxDB";
            docker volume create influx-storage;
            docker run -d --restart unless-stopped --name=influxdb --network=host -v influx-storage:/etc/influxdb/ influxdb;
            printf "InfluxDB Installed";
            show_container_menu;
        ;;        
        f) clear;
            option_picked "Option f Picked - Install KBUS Daemon Container";
            docker run -d --init --restart unless-stopped --privileged --network=host --name=kbus -v kbusapidata:/etc/kbus-api -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket jessejamescox/pfc-kbus-api;
            printf "KBUS Daemon Installed";
            show_container_menu;
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
