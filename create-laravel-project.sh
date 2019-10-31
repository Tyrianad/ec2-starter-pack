#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
PROJECTS_FOLDER='projects/'
USER_PASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
ROOT_PASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

if [ -z "$1" ]
  then
	echo -e "${RED}Please provide a folder name${NC}"
else
  echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "1.CREATING FOLDERS" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

	mkdir $PROJECTS_FOLDER$1 &&
	cp -r defaults/. $PROJECTS_FOLDER$1 &&
	cd $PROJECTS_FOLDER$1 &&

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "2.GENERATING USER AND ROOT PASSWORD" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

	sed -i 's/{dbpassword}/'$USER_PASS'/g' .env &&
  sed -i 's/{dbpassword}/'$USER_PASS'/g' docker-compose.yml &&
	sed -i 's/{rootpassword}/'$ROOT_PASS'/g' docker-compose.yml &&

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "3.COMPOSING LARAVEL PROJECT" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

  mkdir site &&
  cd site &&
	composer create-project --prefer-dist laravel/laravel . &&
	cp ../.env .env &&

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "4.ADDING IDE_HELPER" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

	composer require --dev barryvdh/laravel-ide-helper laravel/ui

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "5.GENERATING ARTISAN KEY" &&
  echo -e "----------------------------${NC}" &&
  echo "" &&

	php artisan key:generate

	echo "" &&
  echo -e "${GREEN}----------------------------" &&
  echo "DONE" &&
  echo -e "----------------------------${NC}" &&
  echo ""

fi
