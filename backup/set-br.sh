#!/bin/bash
# My Telegram : https://t.me/kdevn9
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl -sS https://raw.githubusercontent.com/castleUI/ipvps/main/ipvps | awk '{print $4}' | grep $MYIP )
if [[ $MYIP = $IZIN ]]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
fi

curl https://rclone.org/install.sh | bash
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/KDevN9/scvps/main/backup/rclone.conf"
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
cd /usr/bin
wget -O autobackup "https://raw.githubusercontent.com/KDevN9/scvps/main/backup/autobackup.sh"
wget -O backup "https://raw.githubusercontent.com/KDevN9/scvps/main/backup/backup.sh"
wget -O restore "https://raw.githubusercontent.com/KDevN9/scvps/main/backup/restore.sh"
wget -O strt "https://raw.githubusercontent.com/KDevN9/scvps/main/backup/strt.sh"
wget -O limitspeed "https://raw.githubusercontent.com/KDevN9/scvps/main/backup/limitspeed.sh"
chmod +x autobackup
chmod +x backup
chmod +x restore
chmod +x strt
chmod +x limitspeed
cd
rm -f /root/set-br.sh