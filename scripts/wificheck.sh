cat << "eof" > /tmp/wificheck.sh

while :
do
curl -sf http://www.baidu.com/ >/dev/null || wifi
sleep 600
done

eof

sh /tmp/wificheck.sh &
