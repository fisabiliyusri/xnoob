#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo "Checking VPS"
# EDIT IZIN
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS  https://raw.githubusercontent.com/castleUI/ipvps/main/ipvps > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f  /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f  /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/castleUI/ipvps/main/ipvps | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/castleUI/ipvps/main/ipvps | awk '{print $4}' | grep $MYIP )
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted !"
else
red "Permission Denied !"
rm setup.sh > /dev/null 2>&1
sleep 10
exit 0
fi
clear
source /var/lib/kdevn9/ipvps.conf
domain=$(cat /etc/v2ray/domain)
tls="$(cat /etc/xray/vlesstls.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')"
none="$(cat /etc/xray/vlessnone.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')"
uuid=$(cat /proc/sys/kernel/random/uuid)
user=dev-`</dev/urandom tr -dc X-Z0-9 | head -c4`
exp=1
read -p "SNI (bug) : " sni
read -p "Subdomain (EXP : kdevn9.xyz. / Press Enter If Only Using Hosts) : " sub
dom=$sub$domain
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vlesstls.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vlessnone.json
vtls="vless://${uuid}@${dom}:$tls?path=/xray&security=tls&encryption=none&type=tcp&sni=$sni#${user}"
vnone="vless://${uuid}@${dom}:$none?path=/xray&encryption=none&type=tcp&sni=$sni#${user}"
systemctl restart xr-vl-ntls
systemctl restart xr-vl-tls
clear
echo -e "================================="
echo -e "            XRAY VLESS          "
echo -e "================================="
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Subdomain      : ${dom}"
echo -e "port TCP       : $tls"
echo -e "port none TCP  : $none"
echo -e "id             : ${uuid}"
echo -e "Encryption     : none"
echo -e "network        : tcp"
echo -e "path           : /xray"
echo -e "================================="
echo -e "link TLS       : ${vtls}"
echo -e "================================="
echo -e "link TCP       : ${vnone}"
echo -e "================================="
echo -e "Expired On     : $exp"