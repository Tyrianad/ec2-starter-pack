#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "1.CREATING FOLDER" &&
echo -e "----------------------------${NC}" &&
echo "" &&

if ! [ -d "projects" ]; then
  mkdir -p projects
fi

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "2.UPDATING AND REMOVING OLD VERSIONS" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo apt-get remove docker docker-engine docker.io
sudo apt-get update &&
sudo apt-get upgrade -y &&

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "3a.INSTALLING UTILITIES,NPM" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo apt-get install zip unzip php-zip php-mbstring php-xml -y &&
sudo apt-get install npm -y &&

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "3b.INSTALLING AND CONFIGURING DOCKER" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo apt-get install docker.io docker-compose -y &&
sudo systemctl start docker &&
sudo systemctl enable docker &&
sudo usermod -aG docker $USER

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "4.CREATING SWAP" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo fallocate -l 1G /swapfile &&
sudo chmod 600 /swapfile &&
sudo mkswap /swapfile &&
sudo swapon /swapfile &&
sudo cp /etc/fstab /etc/fstab.bak &&
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab &&

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "5.INSTALLING COMPOSER" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo apt-get install composer -y

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "6.VISUAL STUDIO CODE CONFIGURATIONS" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo echo 'fs.inotify.max_user_watches=524288' >> /proc/sys/fs/inotify/max_user_watches

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "7.CLEANING" &&
echo -e "----------------------------${NC}" &&
echo "" &&

sudo apt-get autoclean -y
sudo apt-get autoremove -y

echo "" &&
echo -e "${GREEN}----------------------------" &&
echo "DONE, REBOOTING IN 10 SECONDS" &&
echo -e "----------------------------${NC}" &&
echo ""

for pc in $(seq 1 10); do
    echo -ne "${RED}."
    sleep 1
done

sudo reboot

