#/bin/fish

wifi=$(nmcli device wifi list | sed -n '1!p' | cut -b 9- | dmenu -i -p "Select Wifi :" | cut -d' ' -f1)
pass=$(echo "" | dmenu -i -p "Enter Password :")

[ -n "$pass" ] && nmcli device wifi connect "$wifi" password "$pass" || nmcli device wifi connect "$bssid"
sleep 10

if ping -q -c 2 -W 2 google.com >/dev/null; then
  notify-send "Your internet is working :)"
else
  notify-send "Your internet is not working :("
fi
