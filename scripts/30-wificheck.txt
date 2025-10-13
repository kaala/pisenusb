cat << "eof" > /tmp/wificheck.sh

while :
do

curl -s -o /dev/null http://baidu.com

r=$?
test $r = 0 && echo 0 > /sys/class/leds/blue:system/brightness
test $r = 0 || echo 1 > /sys/class/leds/blue:system/brightness
test $r = 0 || wifi

sleep 600

done

eof

sleep 10
sh /tmp/wificheck.sh &
