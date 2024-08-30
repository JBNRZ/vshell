#!/bin/bash
echo 1 | sudo update-alternatives --config iptables
sudo iptables -A INPUT -p udp --dport 123 -j DROP
sudo iptables -A OUTPUT -p udp --dport 123 -j DROP
cat<<EOF>conf/vshell.conf
# License授权
license=$LICENSE

# 控制端模式 web/gui/all，web模式只开启web端，gui模式开启gui api，all模式开启所有
master_type=web

# web
web_title=Something
web_port=8082
web_ip=0.0.0.0

# 开启basic认证可防止被资产测绘收录
web_basic_auth=true
# web_jwt_secret可留空更安全，会使用随机字符串作为jwtSecret
web_jwt_secret=
web_username=$USERNAME
web_password=$PASSWORD

# web ssl
web_open_ssl=false
web_cert_file=conf/server.pem
web_key_file=conf/server.key

# dingding robot
dingding_access_token=
dingding_key_word=

# wechat robot
wx_key=

# log level LevelEmergency->0  LevelAlert->1 LevelCritical->2 LevelError->3 LevelWarning->4 LevelNotice->5 LevelInformational->6 LevelDebug->7
log_level=7
log_path=

# pprof debug options
#pprof_ip=0.0.0.0
#pprof_port=9999
EOF
sudo date -s "2023/01/01"
nohup ./vshell &
sleep 5
sudo iptables -D INPUT -p udp --dport 123 -j DROP
sudo iptables -D OUTPUT -p udp --dport 123 -j DROP
sudo ntpdate ntp.aliyun.com
