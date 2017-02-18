#!/usr/bin/env bash
config="/etc/wpa_supplicant/wpa_supplicant.conf"
repeat=0
lag=5
while true
do
    let repeat++
    ifconfig -a wlan0 |grep "192" > /dev/null 2>&1
    if [ $? = 1 ]; then
        file="$(find /media/pi/*sda*/ -name "wifi.txt")"
        if [ ! -z $file ]; then
            ssid="$(cat $file |sed -n '1p')"
            psk="$(cat $file |sed -n '2p')"
            if [ ! -z $ssid -a ! -z $psk ]; then
                ifdown wlan0 > /dev/null 2>&1
                rm -f /var/run/wpa_supplicant/wlan0 > /dev/null 2>&1
                echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > $config
                echo "update_config=1" >> $config
                echo "country=GB" >> $config
                echo "" >> $config
                echo "network={" >> $config
                echo "        ssid=\"$ssid\"" >> $config
                echo "        psk=\"$psk\"" >> $config
                echo "}" >> $config
                ifup wlan0 > /dev/null 2>&1
                break
            fi
        fi
    fi
    if [[ "$repeat" -gt "10" ]];then
        lag=10
    fi
    sleep $lag
done

