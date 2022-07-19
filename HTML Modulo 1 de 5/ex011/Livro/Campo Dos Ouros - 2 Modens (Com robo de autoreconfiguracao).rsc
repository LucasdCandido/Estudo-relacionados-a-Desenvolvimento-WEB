/interface bridge
add name=Wifimaxx
/interface ethernet
set [ find default-name=ether1 ] name=ether1-RASP
set [ find default-name=ether2 ] name=ether2-LAN
set [ find default-name=ether3 ] name=ether3-LAN
set [ find default-name=ether4 ] name=ether4-LAN
set [ find default-name=ether5 ] name=ether5-LIVRE
/interface l2tp-client
add connect-to=91d70a2e9e61.sn.mynetname.net name=l2tp-out1 password=\
    MicropassM4xx user=tunel-teste
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n default-forwarding=no \
    disabled=no frequency=auto mode=ap-bridge radio-name=\
    "WIFIMAXX GRATIS 2Ghz" ssid="Wifimaxx Guarulhos+Conectada"
set [ find default-name=wlan2 ] band=5ghz-a/n/ac default-forwarding=no \
    disabled=no mode=ap-bridge radio-name="Wifimaxx Guarulhos+Conectada 5G" \
    ssid="Wifimaxx Guarulhos+Conectada"
/interface eoip
add mac-address=02:45:FD:27:C0:12 name=eoip-tunnel1 remote-address=10.0.0.1 \
    tunnel-id=10
/system leds
    set 0 interface=wlan1
    set 1 interface=wlan2
    set 2 interface=ether1-RASP
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
add dns-name=wifimaxx.int hotspot-address=10.5.48.1 html-directory=\
    flash/hotspot login-by=http-pap name=hsprof-Wifimaxx radius-interim-update=1m use-radius=yes
/ip hotspot user profile
set [ find default=yes ] idle-timeout=2h keepalive-timeout=1m on-login="/ip firewall mangle add chain=customlog src-address=\$address connection-state=new action=return log=yes log-prefix=$user comment=\$user" on-logout=\
    "/ip firewall mangle remove [find comment=\"\$user\"]" rate-limit=1M/1M shared-users=unlimited
/ip pool
    add name=wifimaxx ranges=10.5.48.2-10.5.63.254
/ip dhcp-server
    add address-pool=wifimaxx disabled=no interface=Wifimaxx lease-time=2h name=dhcp1
/ip hotspot
    add address-pool=wifimaxx addresses-per-mac=1 disabled=no idle-timeout=2h \
    interface=Wifimaxx keepalive-timeout=10m name=[/system routerboard get serial-number] profile=\
    hsprof-Wifimaxx
/system logging action
set 3 bsd-syslog=yes remote=172.105.159.140
/interface bridge port
add bridge=Wifimaxx interface=wlan1
add bridge=Wifimaxx interface=wlan2
add bridge=Wifimaxx interface=eoip-tunnel1
/ip address
add address=10.5.48.1/20 interface=Wifimaxx network=10.5.48.0
add address=192.168.88.46/24 interface=ether1-RASP network=192.168.88.0
/ip cloud
set ddns-enabled=yes
/ip dhcp-server network
add address=10.5.48.0/20 comment="hotspot network" gateway=10.5.48.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
add action=drop chain=forward comment=Xvideos content=xvideos
add action=drop chain=forward comment=Porn content=porn
add action=drop chain=forward comment=xxx content=xxx
add action=drop chain=forward comment=Redtube content=redtube
add action=drop chain=forward comment=xhamster content=xhamster
add action=drop chain=forward comment=pornhub content=pornhub
add action=drop chain=forward comment=xnxx content=xnxx
add action=drop chain=forward comment=youporn content=youporn
add action=drop chain=forward comment=video-one content=video-one
add action=drop chain=forward comment=beeg content=beeg
add action=drop chain=forward comment=livejasmin content=livejasmin
add action=drop chain=forward comment=fapdu content=fapdu
add action=drop chain=forward comment=xplastic content=xplastic
add action=drop chain=forward comment=safada.tv content=safada.tv
add action=drop chain=forward comment=pornonacionalvideos content=pornonacionalvideos
add action=drop chain=forward comment=caseirosexo content=caseirosexo
add action=drop chain=forward comment=nudelas content=nudelas
add action=drop chain=forward comment=flagrasamadores content=flagrasamadores
add action=drop chain=forward comment=pornobrasileiro content=pornobrasileiro
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat comment="masquerade network" log=yes log-prefix=NAT-RULE-MASQ
add action=dst-nat chain=dstnat dst-port=2222 protocol=tcp to-addresses=192.168.88.1 to-ports=22
add action=dst-nat chain=dstnat dst-port=2121 protocol=tcp to-addresses=192.168.88.1 to-ports=21
/ip hotspot user
add name=admin password=gusana1914
add name=1234 password=gusana1914
/ip hotspot walled-garden
add comment="place hotspot rules here" disabled=yes
add dst-host=*wifimaxx.com.br
add dst-host=*mmaxx.me
add dst-host=*googleapis.com
add dst-host=*bluemaxx.com.br
add dst-host=*bradesco*
add dst-host=*analytics*
add dst-host=*.movidesk.com
add dst-host=*gstatic*
add dst-host=*.jquery.com
add dst-host=cds.s5x3j6q5.hwcdn.net
add dst-host=*s3.amazonaws.com
/ip hotspot walled-garden ip add dst-address=45.33.63.142 action=accept
/ip hotspot walled-garden add dst-host=googletagmanager action=allow
/ip route
add comment=GW-RASP distance=1 gateway=192.168.88.1 routing-mark=to_rasp
add distance=2 gateway=192.168.10.1 routing-mark=to_rb
add comment=GW-RASP distance=1 gateway=192.168.88.1
/ip service
set telnet disabled=yes
set ftp port=2021
set www port=89
set ssh port=2022
/radius
add address=34.95.164.250 comment="GCP Radius" secret=519aeae92bc6f4bc17f4e35a4e56b4b8 service=hotspot timeout=1s500ms
add address=45.33.63.142 comment="Linode Radius" secret=519aeae92bc6f4bc17f4e35a4e56b4b8 service=hotspot timeout=1s500ms
/system clock
set time-zone-autodetect=no time-zone-name=America/Sao_Paulo
/system identity
set name=[/system routerboard get serial-number]
/system logging
add action=remote prefix=HOTSPOT-LOG topics=hotspot
add action=remote prefix=FIREWALL-LOG topics=firewall
add action=remote prefix=TESTE-ROBOT topics=script
/system ntp client
set enabled=yes primary-ntp=200.160.0.8
/system scheduler
    add interval=1m30s name=keep_alive on-event=keep_alive policy=read,write,test start-time=startup
    add interval=5m name=check-gw on-event=check-gw policy=read,write,test start-time=startup
    add interval=1m name=robot on-event=robot policy=reboot,read,write,policy,test start-time=startup
    add interval=1m name=serial on-event=serial policy=read,write,policy,test start-time=startup
    add name=online on-event=online policy=read,write,policy,test start-time=startup
/system script
add dont-require-permissions=no name=keep_alive owner=admin policy=read,write,test \
    source=":local hsidentity [/system identity get name]\r\
    \n:local hsgroup \"wifimaxx-campodosouros\"\r\
    \n:local hsdate [/system clock get date]\r\
    \n:local hstime [/system clock get time]\r\
    \n:local hsmessage \"keepalive\"\r\
    \n:local kind \"route-ap\"\r\
    \n\r\
    \n#str_replace para MikroTik\r\
    \n:global replaceChar do={\
    \n  :for i from=0 to=([:len \$1] - 1) do={\
    \n    :local char [:pick \$1 \$i]\
    \n    :if (\$char = \$2) do={\
    \n      :set \$char \$3\
    \n    }\
    \n    :set \$output (\$output . \$char)\
    \n  }\
    \n  :return \$output\
    \n}\r\
    \n\r\
    \n#Routerboard Info\r\
    \n:local model [ \$replaceChar [/system routerboard get model] \" \" \"\" ]\r\
    \n:local os [/system license get software-id]\r\
    \n:local serial [/system routerboard get serial-number]\r\
    \n:local firmware [/system routerboard get current-firmware]\r\
    \n\r\
    \n#count active users\r\
    \n:local hscountactive 0\r\
    \n:foreach i in=[/ip hotspot active find] do={ :set hscountactive (\$hscou\
    ntactive +1) }\r\
    \n\r\
    \n/tool fetch address=\"panel.bradescoeventos.com.br\" host=\"panel.brades\
    coeventos.com.br\" mode=http src-path=\"wifi/services/hotspots/keepalive\\\
    \?identity=\$hsidentity&group=\$hsgroup&kind=\$kind&model=\$model&os=\$os&\
    serial=\$serial&firmware=\$firmware&time=\$hstime&date=\$hsdate&message=\$\
    hsmessage&active=\$hscountactive\" keep-result=no"
add dont-require-permissions=no name=check-gw owner=admin policy=\
    read,write,test source=":local rasp [/ping 8.8.8.8 count=10 interface=ethe\
    r1-RASP routing-table=\"to_rasp\"]\r\
    \n:local rb [/ping 8.8.8.8 count=10 interface=lte1 routing-table=\"to_rb\"\
    ]\r\
    \n\r\
    \n:if (\$rb < \$rasp ) do={\r\
    \n\r\
    \n/ip route set [/ip route find comment=\"GW-RASP\"] distance=1\r\
    \n/ip route set [/ip route find comment=\"Route-RASP\"] distance=1\r\
    \n\r\
    \n} else={\r\
    \n\r\
    \n/ip route set [/ip route find comment=\"GW-RASP\"] distance=10\r\
    \n/ip route set [/ip route find comment=\"Route-RASP\"] distance=10\r\
    \n\r\
    \n}\r\
    \n\r\
    \n:local hsidentity [/system identity get name]\r\
    \n:local serial [/system routerboard get serial-number]\r\
    \n\r\
    \n/tool fetch address=\"services.wifimaxx.com.br\" host=\"services.wifimax\
    x.com.br\" mode=http src-path=\"monitor/linkquality\?identity=\$hsidentity\
    &serial=\$serial&rb=\$rb&rasp=\$rasp\" keep-result=no"
add dont-require-permissions=yes name=robot owner=admin policy=\
    reboot,read,write,policy,test source="#WI-FI\r\
    \n:local w1;\r\
    \n:local ssid1 [/interface wireless get [/interface wireless find name=wla\
    n1] ssid]\r\
    \n\r\
    \n\t/interface wireless monitor wlan1 once do={\r\
    \n  \t\t:set w1 \$status\r\
    \n\r\
    \n\t\t:if (\$w1 = \"disabled\" || \$w1 = \"searching-for-network\" || \$ss\
    id1 != \"Wifimaxx Guarulhos+Conectada\") do={\r\
    \n\t\t\t:execute {/system reset}\r\
    \n\t\t\t:log info \"Erro wlan1\"\r\
    \n\t\t} else={\r\
    \n\t\t\t\t:log info \"wlan1 ok\"\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\r\
    \n:local w2;\r\
    \n:local ssid2 [/interface wireless get [/interface wireless find name=wla\
    n2] ssid]\r\
    \n\r\
    \n\t/interface wireless monitor wlan2 once do={\r\
    \n  \t\t:set w2 \$status\r\
    \n\r\
    \n\t\t:if (\$w2 = \"disabled\" || \$w2 = \"searching-for-network\" || \$ss\
    id2 != \"Wifimaxx Guarulhos+Conectada\") do={\r\
    \n\t\t\t:execute {/system reset}\r\
    \n\t\t\t:log info \"Erro wlan2\"\r\
    \n\t\t} else={\r\
    \n\t\t\t\t:log info \"wlan2 ok\"\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\r\
    \n#IDENTITY\r\
    \n:local identity [/system identity get name]\r\
    \n\t:if (\$identity = \"MikroTik\") do={\r\
    \n\t\t:execute {/system reset}\r\
    \n\t\t:log info \"Erro Identity\"\r\
    \n\t} else={\r\
    \n\t\t\t\t:log info \"identity ok\"\r\
    \n\t\t}\r\
    \n\r\
    \n#BRIDGE WIFIMAXX\r\
    \n:local bb [/interface bridge find name=\"Wifimaxx\"]\r\
    \n\t:if ([:len \$bb] = 0) do={\r\
    \n\t\t:execute {/system reset}\r\
    \n\t\t:log info \"Erro Bridge Wifimaxx\"\r\
    \n\t} else={\r\
    \n\t\t\t\t:log info \"bridge Wifimaxx ok\"\r\
    \n\t\t}\r\
    \n\r\
    \n#BRIDGE WIFIMAXX PORT\r\
    \n:if ([:len [/interface bridge port find interface=\"wlan1\" bridge=\"Wif\
    imaxx\"]]=0) do={\r\
    \n\t:execute {/system reset}\r\
    \n\t:log info \"Erro Bridge Port Wifimaxx\"\r\
    \n} else={\r\
    \n        :if ([:len [/interface bridge port find interface=\"wlan2\" brid\
    ge=\"Wifimaxx\"]]=0) do={\r\
    \n\t\t\r\
    \n\t\t:log info \"Erro Bridge Port Wifimaxx\"\r\
    \n        } else={\r\
    \n        \t\t:log info \"Bridge Port Wifimaxx ok\"\r\
    \n        }\r\
    \n    }\r\
    \n\r\
    \n#IP-1\r\
    \n:if ([:len [/ip address find address=\"10.5.48.1/20\" interface=\"Wifima\
    xx\"]]=0) do={\r\
    \n\t\t:execute {/system reset}\r\
    \n\t\t:log info \"Erro IP1\"\r\
    \n\t} else={\r\
    \n\t\t\t\t:log info \"IP1 ok\"\r\
    \n\t\t}\r\
    \n\r\
    \n#IP-2\r\
    \n:local ip2 [/ip address find interface=\"Wifimaxx\"]\r\
    \n\t:if ([:len \$ip2] = 0) do={\r\
    \n\t\t:execute {/system reset}\r\
    \n\t\t:log info \"Erro IP2\"\r\
    \n\t} else={\r\
    \n\t\t\t\t:log info \"IP2 ok\"\r\
    \n\t\t}\r\
    \n\r\
    \n#HOTSPOT\r\
    \n:local hotspot [/ip hotspot find interface=\"Wifimaxx\"]\r\
    \n\t:if ([:len \$hotspot] = 0) do={\r\
    \n\t\t:execute {/system reset}\r\
    \n\t\t:log info \"Erro hotspot\"\r\
    \n\t} else={\r\
    \n\t\t\t\t:log info \"hotspot ok\"\r\
    \n\t\t}\r\
    \n\r\
    \n#DHCP-1\r\
    \n:local dhcp [/ip dhcp-server find interface=\"Wifimaxx\"]\r\
    \n\t:if ([:len \$dhcp] = 0) do={\r\
    \n\t\t:execute {/system reset}\r\
    \n\t\t:log info \"Erro dhcp1\"\r\
    \n\t} else={\r\
    \n\t\t\t\t:log info \"dhcp1 ok\"\r\
    \n\t\t}"
add dont-require-permissions=no name=serial owner=admin policy=\
    read,write,policy,test source=":local serial [/system routerboard get seri\
    al-number]\r\
    \n:local identity [/system identity get name]\r\
    \n:local date [/system clock get date]\r\
    \n:local time [/system clock get time]\r\
    \n:local uptime [/system resource get uptime]\r\
    \n\r\
    \n:log info \"Identity: \$identity - SN: \$serial - Date: \$date - Time: \
    \$time - Uptime: \$uptime\""
add dont-require-permissions=no name=online owner=admin policy=\
    read,write,policy,test source=":local serial [/system routerboard get seri\
    al-number]\r\
    \n:local identity [/system identity get name]\r\
    \n:local date [/system clock get date]\r\
    \n:local time [/system clock get time]\r\
    \n:local cloud [/ip cloud get dns-name]\r\
    \n\r\
    \n:log info \"Identity: \$identity - SN: \$serial - Date: \$date - Time: \
    \$time - Cloud: $cloud - ONLINE\""
/ip cloud set ddns-enabled=yes
/user set 0 password="MicropassM4xx"
