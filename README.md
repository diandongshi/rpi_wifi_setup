# rpi_wifi_setup

auto set up the wifi connection for raspberrypi with wifi.txt in usb


copy wifi_setup.sh to /etc/init.d
sudo chown root:root wifi_setup.sh
sudo chmod +x wifi_setup.sh
sudo update-rc.d wifi_setup.sh defaults
