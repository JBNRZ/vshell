#!/bin/bash
echo 1 | update-alternatives --config iptables
iptables -A INPUT -p udp --dport 123 -j DROP
iptables -A OUTPUT -p udp --dport 123 -j DROP
cat<<EOF>conf/vshell.conf
#License授权
License=itlopmByVH5mOMaIjQlsYA4Bfkp4sOFc6nmay3IfOEqkdQU16hjXUy+/w6m48KGANHr0nK53NWM6FnoDVQr4CW3gPATg6CpLgpxb+kGzh0fmBVser8jSHNHgmg9V0gKK3vkyO9SosmLl16V5mVxobJCvORTHWNTG2KAIeK1S28k=
# bridge port
bridge_port=8084
bridge_ip=0.0.0.0
# 上线域名，上线CDN域名
bridge_host=
bridge_cdn_host=
# 如果dns_port不为0，则开启dns监听。除DNS直连外都需设置 dns_port=53
dns_port=0
dns_domain=example.com
# DNS payload 最大长度，越大速度越快。不同DNS服务支持的不同，中转DNS是512，Cloudflare DOH 是1452, Google DOH 是4096
maxDNSsize=512
# vkey, which clients can use to connect to the server
# 服务端校验客户端的密钥，必须开启，可自定义
vkey=$VKEY
# 流量加密盐，替换盐可以改变流量特征
encrypt_salt=$ENCRYPT_SALT
# 超时间隔
disconnect_timeout=60
# 心跳间隔
ping_time=10
# web
# 站点title
web_title=$TITLE
web_port=8082
web_ip=0.0.0.0
# 开启basic认证可防止被资产测绘收录
web_basic_auth=true
web_username=$USERNAME
web_password=$PASSWORD
# web_jwt_secret可留空，会使用随机字符串作为jwtSecret
web_jwt_secret=
web_open_ssl=false
web_cert_file=conf/server.pem
web_key_file=conf/server.key

#Traffic data persistence interval(minute)
#Ignorance means no persistence
#flow_store_interval=1

#dingding robot
# 钉钉上线通知，需要配置access_token和关键词，留空不开启功能
dingding_access_token=
dingding_key_word=
# 企业微信群机器人上线通知，留空不开启功能
wx_key=

# log level LevelEmergency->0  LevelAlert->1 LevelCritical->2 LevelError->3 LevelWarning->4 LevelNotice->5 LevelInformational->6 LevelDebug->7
log_level=7
# log_path=vshell.log

#------------------------------------------------------------------
#后面的设置默认无需修改

#Whether to restrict IP access, true or false or ignore
#ip_limit=true

#p2p
#p2p_ip=127.0.0.1
#p2p_port=6000

#allow_ports=9001-9009,10001,11000-12000

#extension
system_info_display=false

#cache
http_cache=false
http_cache_length=100

#get origin ip
http_add_origin_header=false

#pprof debug options
#pprof_ip=0.0.0.0
#pprof_port=9999
EOF
date -s "2023/01/01"
nohup ./vshell &
sleep 5
iptables -D INPUT -p udp --dport 123 -j DROP
iptables -D OUTPUT -p udp --dport 123 -j DROP
ntpdate ntp.aliyun.com
