<h1 style="font-weight:normal">
  &nbsp;WAGO Provisioning Tool&nbsp;
  <a href="provisioning gif"><img src=wago-provisioning-tool.png></a>
  <a href="docker gif"><img src=docker-menu.png></a>
</h1>

An open-source provisioning utility for WAGO PFC controllers.

This project is still in beta - please use at your own risk and post any bugs to [issues](https://https://github.com/braunku/pfc-provisioning-tool/issues)
<br>

Features
========
* Easy to use menu interface
* Install common software and disable unnecessary services

Get started
===========
Connect to your controller using ssh as the root user.  Run this utility  with the following command from the default /root directory:

`curl -L https://raw.githubusercontent.com/braunku/pfc-provisioning-tool/main/menu.sh -o menu.sh -s && sh menu.sh`

Depending on the device Firmware, this command might not work.  In this case, please use the following command;

wget -O menu.sh https://raw.githubusercontent.com/braunku/pfc-provisioning-tool/main/menu.sh && sh menu.sh

To re-open the tool just type;

`./menu.sh`

Requirements
============
* WAGO PFC200 with firmware 18+
License
=======
wago-provisioning-tool is under the MIT license. See the [LICENSE](https://github.com/braunku/wago-provisioning-tool/blob/main/LICENSE.md) for more information.

Links
=====
* [Kurt Braun YouTube](https://www.youtube.com/channel/WAGOKurt)
* [Kurt Braun LinkedIn](https://www.linkedin.com/in/wago-kurt-braun/)
