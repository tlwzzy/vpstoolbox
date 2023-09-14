#!/usr/bin/env bash

## i2pd模组 i2pd moudle

install_i2pd(){
  set +e
  if [[ ${dist} == debian ]]; then
wget -q -O - https://repo.i2pd.xyz/.help/add_repo | sudo bash -s -
apt-get update
apt-get install libminiupnpc17 -y
curl -LO https://github.com/PurpleI2P/i2pd/releases/download/2.36.0/i2pd_2.36.0-1buster1_amd64.deb
dpkg -i i2pd_2.36.0-1buster1_amd64.deb
#apt-get install i2pd -y
 elif [[ ${dist} == ubuntu ]]; then
  add-apt-repository ppa:purplei2p/i2pd -y
  apt-get update
  apt-get install i2pd -y
 else
  echo "fail"
 fi
  cat > '/etc/i2pd/i2pd.conf' << EOF
## Configuration file for a typical i2pd user
## See https://i2pd.readthedocs.io/en/latest/user-guide/configuration/
## for more options you can use in this file.

## Lines that begin with "## " try to explain what's going on. Lines
## that begin with just "#" are disabled commands: you can enable them
## by removing the "#" symbol.

## Tunnels config file
## Default: ~/.i2pd/tunnels.conf or /var/lib/i2pd/tunnels.conf
# tunconf = /var/lib/i2pd/tunnels.conf

## Tunnels config files path
## Use that path to store separated tunnels in different config files.
## Default: ~/.i2pd/tunnels.d or /var/lib/i2pd/tunnels.d
# tunnelsdir = /var/lib/i2pd/tunnels.d

## Where to write pidfile (default: i2pd.pid, not used in Windows)
# pidfile = /run/i2pd.pid

## Logging configuration section
## By default logs go to stdout with level 'info' and higher
##
## Logs destination (valid values: stdout, file, syslog)
##  * stdout - print log entries to stdout
##  * file - log entries to a file
##  * syslog - use syslog, see man 3 syslog
log = syslog
## Path to logfile (default - autodetect)
# logfile = /var/log/i2pd/i2pd.log
## Log messages above this level (debug, info, *warn, error, none)
## If you set it to none, logging will be disabled
loglevel = error
## Write full CLF-formatted date and time to log (default: write only time)
# logclftime = true

## Daemon mode. Router will go to background after start
# daemon = true

## Specify a family, router belongs to (default - none)
# family =

## External IP address to listen for connections
## By default i2pd sets IP automatically
# host = 1.2.3.4

## Port to listen for connections
## By default i2pd picks random port. You MUST pick a random number too,
## don't just uncomment this
# port = 9000

## Enable communication through ipv4
ipv4 = true
## Enable communication through ipv6
ipv6 = true

## Network interface to bind to
# ifname =
## You can specify different interfaces for IPv4 and IPv6
# ifname4 = 
# ifname6 = 

## Enable NTCP transport (default = true)
# ntcp = true
## If you run i2pd behind a proxy server, you can only use NTCP transport with ntcpproxy option 
## Should be http://address:port or socks://address:port
# ntcpproxy = http://127.0.0.1:8118
## Enable SSU transport (default = true)
ssu = true

## Should we assume we are behind NAT? (false only in MeshNet)
nat = true

## Bandwidth configuration
## L limit bandwidth to 32KBs/sec, O - to 256KBs/sec, P - to 2048KBs/sec,
## X - unlimited
## Default is X for floodfill, L for regular node
bandwidth = X
## Max % of bandwidth limit for transit. 0-100. 100 by default
# share = 100

## Router will not accept transit tunnels, disabling transit traffic completely
## (default = false)
# notransit = true

## Router will be floodfill
# floodfill = true

[http]
## Web Console settings
## Uncomment and set to 'false' to disable Web Console
# enabled = true
## Address and port service will listen on
address = 127.0.0.1
port = 7070
strictheaders = false
## Path to web console, default "/"
webroot = /${password1}_i2p/
## Uncomment following lines to enable Web Console authentication 
# auth = true
# user = i2pd
# pass = changeme

[httpproxy]
## Uncomment and set to 'false' to disable HTTP Proxy
# enabled = true
## Address and port service will listen on
address = 127.0.0.1
port = 4444
## Optional keys file for proxy local destination
# keys = http-proxy-keys.dat
## Enable address helper for adding .i2p domains with "jump URLs" (default: true)
# addresshelper = true
## Address of a proxy server inside I2P, which is used to visit regular Internet
outproxy = http://false.i2p
## httpproxy section also accepts I2CP parameters, like "inbound.length" etc.
#inbound.length = 2
#inbound.quantity = 16
#outbound.length = 2
#outbound.quantity = 16

[socksproxy]
## Uncomment and set to 'false' to disable SOCKS Proxy
# enabled = true
## Address and port service will listen on
address = 127.0.0.1
port = 4447
## Optional keys file for proxy local destination
# keys = socks-proxy-keys.dat
## Socks outproxy. Example below is set to use Tor for all connections except i2p
## Uncomment and set to 'true' to enable using of SOCKS outproxy
# outproxy.enabled = true
## Address and port of outproxy
# outproxy = 127.0.0.1
# outproxyport = 9050
## socksproxy section also accepts I2CP parameters, like "inbound.length" etc.
# inbound.length = 2
# inbound.quantity = 16
# outbound.length = 2
# outbound.quantity = 16

[sam]
## Uncomment and set to 'true' to enable SAM Bridge
# enabled = true
# singlethread = false
## Address and port service will listen on
# address = 127.0.0.1
# port = 7656

[bob]
## Uncomment and set to 'true' to enable BOB command channel
# enabled = true
## Address and port service will listen on
# address = 127.0.0.1
# port = 2827

[i2cp]
## Uncomment and set to 'true' to enable I2CP protocol
enabled = true
# singlethread = false
## Address and port service will listen on
# address = 127.0.0.1
# port = 7654

[i2pcontrol]
## Uncomment and set to 'true' to enable I2PControl protocol
# enabled = on
## Address and port service will listen on
# address = 127.0.0.1
# port = 7650
## Authentication password. "itoopie" by default
# password = ${password1}

[precomputation]
## Enable or disable elgamal precomputation table
## By default, enabled on i386 hosts
# elgamal = true

[upnp]
## Enable or disable UPnP: automatic port forwarding (enabled by default in WINDOWS, ANDROID)
enabled = true
## Name i2pd appears in UPnP forwardings list (default = I2Pd)
# name = I2Pd

[reseed]
## Options for bootstrapping into I2P network, aka reseeding
## Enable or disable reseed data verification.
verify = true
## URLs to request reseed data from, separated by comma
## Default: "mainline" I2P Network reseeds
# urls = https://reseed.i2p-projekt.de/,https://i2p.mooo.com/netDb/,https://netdb.i2p2.no/
## Path to local reseed data file (.su3) for manual reseeding
# file = /path/to/i2pseeds.su3
## or HTTPS URL to reseed from
# file = https://legit-website.com/i2pseeds.su3
## Path to local ZIP file or HTTPS URL to reseed from
# zipfile = /path/to/netDb.zip
## If you run i2pd behind a proxy server, set proxy server for reseeding here
## Should be http://address:port or socks://address:port
# proxy = http://127.0.0.1:8118
## Minimum number of known routers, below which i2pd triggers reseeding. 25 by default
# threshold = 25

[addressbook]
## AddressBook subscription URL for initial setup
## Default: inr.i2p at "mainline" I2P Network
# defaulturl = http://xk6ypey2az23vtdkitjxvanlshztmjs2ekd6sp77m4obszf6ocfq.b32.i2p/hosts.txt
## Optional subscriptions URLs, separated by comma
# subscriptions = http://xk6ypey2az23vtdkitjxvanlshztmjs2ekd6sp77m4obszf6ocfq.b32.i2p/alive-hosts.txt,http://kqypgjpjwrphnzebod5ev3ts2vtii6e5tntrg4rnfijqc7rypldq.b32.i2p/cgi-bin/newhosts.txt,http://gh6655arkncnbrzq5tmq4xpn36734d4tdza6flbw5xppye2dt6ga.b32.i2p/hosts.txt,http://udhdrtrcetjm5sxzskjyr5ztpeszydbh4dpl3pl4utgqqw2v4jna.b32.i2p/hosts.txt,http://rus.i2p/hosts.txt

[limits]
## Maximum active transit sessions (default:2500)
transittunnels = 65535
## Limit number of open file descriptors (0 - use system limit)  
# openfiles = 0
## Maximum size of corefile in Kb (0 - use system limit) 
# coresize = 0
## Threshold to start probabalistic backoff with ntcp sessions (0 - use system limit) 
# ntcpsoft = 0
## Maximum number of ntcp sessions (0 - use system limit) 
# ntcphard = 0

[trust]
## Enable explicit trust options. false by default
# enabled = true
## Make direct I2P connections only to routers in specified Family.
# family = MyFamily
## Make direct I2P connections only to routers specified here. Comma separated list of base64 identities.
# routers = 
## Should we hide our router from other routers? false by default
# hidden = true

[exploratory]
## Exploratory tunnels settings with default values
# inbound.length = 3
# inbound.quantity = 16
# outbound.length = 3
# outbound.quantity = 16

[ntcp2]

enabled = true
published = true

[persist]
## Save peer profiles on disk (default: true)
profiles = true

[cpuext]
## Use CPU AES-NI instructions set when work with cryptography when available (default: true)
# aesni = true
## Use CPU AVX instructions set when work with cryptography when available (default: true)
# avx = true
## Force usage of CPU instructions set, even if they not found
## DO NOT TOUCH that option if you really don't know what are you doing!
# force = false
EOF
    cat > '/etc/i2pd/tunnels.conf.d/mywebsite.conf' << EOF
[my-website]
type = http
host = 127.0.0.1
port = 80
inbound.length = 1
outbound.length = 1
#inbound.quantity = 16
#outbound.quantity = 16
keys = my-website.dat
EOF
    cat > '/etc/i2pd/tunnels.conf.d/ssh.conf' << EOF
[SSH-SERVER]
type = server
host = 127.0.0.1
port = 22
inbound.length = 1
outbound.length = 1
#inbound.quantity = 16
#outbound.quantity = 16
keys = ssh-in.dat
EOF
    cat > '/etc/i2pd/tunnels.conf.d/proxy.conf' << EOF
[PROXY-SERVER]
type = server
host = 127.0.0.1
port = 8388
inbound.length = 1
outbound.length = 1
#inbound.quantity = 16
#outbound.quantity = 16
keys = ssh-in.dat
EOF
cd /etc/i2pd/tunnels.conf.d
curl -LO https://raw.githubusercontent.com/tlwzzy/vpstoolbox/master/conf/tg-mtproxy.conf
cd
    cat > '/lib/systemd/system/i2pd.service' << EOF
[Unit]
Description=I2P Router written in C++
Documentation=man:i2pd(1) https://i2pd.readthedocs.io/en/latest/
After=network.target

[Service]
User=i2pd
Group=i2pd
#RuntimeDirectory=i2pd
#RuntimeDirectoryMode=0700
#LogsDirectory=i2pd
#LogsDirectoryMode=0700
Type=forking
ExecStart=/usr/sbin/i2pd --conf=/etc/i2pd/i2pd.conf --tunconf=/etc/i2pd/tunnels.conf --tunnelsdir=/etc/i2pd/tunnels.conf.d --pidfile=/run/i2pd/i2pd.pid --logfile=/var/log/i2pd/i2pd.log --daemon --service
ExecReload=/bin/sh -c "kill -HUP $MAINPID"
PIDFile=/run/i2pd/i2pd.pid

KillSignal=SIGQUIT
# If you have the patience waiting 10 min on restarting/stopping it, uncomment this.
# i2pd stops accepting new tunnels and waits ~10 min while old ones do not die.
#KillSignal=SIGINT
#TimeoutStopSec=10m

LimitNOFILE=65536
Restart=on-failure
RestartSec=3s

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable i2pd
systemctl restart i2pd
cd /etc/i2pd/
depend="libboost-chrono-dev \
    libboost-date-time-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libssl-dev \
    zlib1g-dev"
apt-get install -y $depend
git clone --recursive https://github.com/purplei2p/i2pd-tools
cd /etc/i2pd/i2pd-tools
make
cd /etc/i2pd/
curl -LO https://github.com/majestrate/XD/releases/download/v0.3.4/XD-0.3.4-linux-amd64
mv XD-0.3.4-linux-amd64 XD
cp XD XD-cli
  cat > '/etc/systemd/system/xd.service' << EOF
[Unit]
Description=Standalone I2P BitTorrent Client
Documentation=https://github.com/majestrate/XD/releases
Requires=network.target
After=network.target

[Service]
User=root
RemainAfterExit=yes
ExecStart=/etc/i2pd/XD /etc/i2pd/torrents.ini
ExecReload=/usr/bin/kill -HUP \$MAINPID
ExecStop=/usr/bin/kill -s STOP \$MAINPID
LimitNOFILE=65536
RestartSec=3s
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable xd
systemctl restart xd
cd
}
