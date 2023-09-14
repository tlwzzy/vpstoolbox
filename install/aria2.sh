#!/usr/bin/env bash

## Aria2模组 Aria2 moudle

#---Author Info---
ver="1.0.0"
Author="tlwzzy"
url="https://tlwzzy.com/"
github_url="https://github.com/tlwzzy/vpstoolbox"
#-----------------

install_aria2(){
TERM=ansi whiptail --title "安装中" --infobox "安装Aria2中..." 7 68
trackers_list=$(wget --no-check-certificate -qO- https://trackerslist.com/all_aria2.txt)
ariaport=$(shuf -i 13000-19000 -n 1)
mkdir /etc/aria2/
  cat > '/etc/systemd/system/aria2.service' << EOF
[Unit]
Description=Aria2c download manager
Documentation=https://aria2.github.io/manual/en/html/index.html
Requires=network.target
After=network.target

[Service]
Type=forking
User=root
RemainAfterExit=yes
ExecStart=/usr/local/bin/aria2c --conf-path=/etc/aria2/aria2.conf
ExecReload=/usr/bin/kill -HUP \$MAINPID
ExecStop=/usr/bin/kill -s STOP \$MAINPID
LimitNOFILE=65536
RestartSec=3s
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
  cat > '/etc/aria2/aria2.conf' << EOF
#!!! Do not change these settings unless you know what you are doing !!!
#Upload Settings###
#on-download-complete=/etc/aria2/autoupload.sh
#Global Settings###
daemon=true
async-dns=true
#enable-async-dns6=true
log-level=warn
console-log-level=info
human-readable=true
log=/var/log/aria2.log
rlimit-nofile=51200
event-poll=epoll
min-tls-version=TLSv1.2
dir=/usr/share/nginx/aria2/
file-allocation=falloc
check-integrity=true
conditional-get=false
disk-cache=64M #Larger is better,but should be smaller than available RAM !
enable-color=true
continue=true
always-resume=true
max-concurrent-downloads=50
content-disposition-default-utf8=true
#split=16
##Http(s) Settings#######
enable-http-keep-alive=true
http-accept-gzip=true
min-split-size=10M
max-connection-per-server=16
lowest-speed-limit=0
disable-ipv6=false
max-tries=0
#retry-wait=0
input-file=/usr/local/bin/aria2.session
save-session=/usr/local/bin/aria2.session
save-session-interval=60
force-save=true
metalink-preferred-protocol=https
##Rpc Settings############
enable-rpc=true
rpc-allow-origin-all=true
rpc-listen-all=false
rpc-secure=false
rpc-listen-port=6800
rpc-secret=$ariapasswd
#Bittorrent Settings######
follow-torrent=true
listen-port=$ariaport
enable-dht=true
enable-dht6=true
enable-peer-exchange=true
seed-ratio=0
bt-enable-lpd=true
bt-hash-check-seed=true
bt-seed-unverified=false
bt-save-metadata=true
bt-load-saved-metadata=true
bt-require-crypto=true
bt-force-encryption=true
bt-min-crypto-level=arc4
bt-max-peers=0
bt-tracker=$trackers_list
EOF
clear
apt-get install nettle-dev libgmp-dev libssh2-1-dev libc-ares-dev libxml2-dev zlib1g-dev libsqlite3-dev libssl-dev libuv1-dev -q -y
curl -LO --progress-bar https://raw.githubusercontent.com/tlwzzy/vpstoolbox/master/binary/aria2c.xz
xz --decompress aria2c.xz
cp -f aria2c /usr/local/bin/aria2c
chmod +x /usr/local/bin/aria2c
rm -rf aria2c
apt-get autoremove -q -y
touch /var/log/aria2.log
touch /usr/local/bin/aria2.session
mkdir /usr/share/nginx/aria2/
chmod 755 /usr/share/nginx/aria2/
systemctl daemon-reload
systemctl enable aria2
systemctl restart aria2
cd
## 安装 AriaNG
if [[ ! -d /usr/share/nginx/ariang ]]; then
  mkdir /usr/share/nginx/ariang
fi
cd /usr/share/nginx/ariang
curl -LO https://github.com/mayswind/AriaNg/releases/download/1.1.7/AriaNg-1.1.7.zip
unzip *
rm -rf *.zip
cd
TERM=ansi whiptail --title "安装中" --infobox "拉取全自动Aria2上传脚本中..." 7 68
cd /etc/aria2/
curl -LO https://raw.githubusercontent.com/tlwzzy/vpstoolbox/master/install/autoupload.sh
chmod +x /etc/aria2/autoupload.sh
}

