#!/bin/bash
# Specify colors utilized in the terminal
normal='tput sgr0'              # White
red='tput setaf 1'              # Red
green='tput setaf 2'            # Green
yellow='tput setaf 3'           # Yellow
blue='tput setaf 4'             # Blue
violet='tput setaf 5'           # Violet
cyan='tput setaf 6'             # Cyan
white='tput setaf 7'            # White
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold Red
bldgrn=${txtbld}$(tput setaf 2) # Bold Green
bldblu=${txtbld}$(tput setaf 4) # Bold Blue
bldylw=${txtbld}$(tput setaf 3) # Bold Yellow
bldvlt=${txtbld}$(tput setaf 5) # Bold Violet
bldcya=${txtbld}$(tput setaf 6) # Bold Cyan
bldwht=${txtbld}$(tput setaf 7) # Bold White

clear

tput setaf 3
	sleep 1
	echo
	echo Updating Package Lists...
	echo
	sleep 3
tput setaf 2
	time sudo apt-get update
tput setaf 3
	echo
	echo Installing necessary dependencies...
	echo
	sleep 3
tput setaf 2
	time sudo apt-get -y install git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev \
	squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev pngcrush ccache \
	schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib \
	python-networkx lib32z1-dev lib32ncurses5-dev gcc-multilib xsltproc unzip pngquant
tput setaf 3
	echo
	echo Setting up USB Ports...
	echo
	sleep 3
tput setaf 2
	sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules
	sudo chmod 644   /etc/udev/rules.d/51-android.rules
	sudo chown root /etc/udev/rules.d/51-android.rules
	sudo service udev restart
	adb kill-server
	sudo killall adb
tput setaf 3
	echo Downloading repo tool, if already present will update to the latest version...
tput setaf 2
	cd ..
	echo
	sleep 2
	mkdir -p ~/bin
	PATH=~/bin:$PATH
	curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
	chmod a+x ~/bin/repo
clear
tput setaf 3
	echo
	echo -e "${bldblu}Your computer is now ready for building! "
	echo
	sleep 5
tput setaf 2
clear
	sleep 2
tput setaf 3
	echo -e "${bldblu}Enter the path where source code should be downloaded in full format.\nDefault is ${HOME}/projects/N"
	read brokenpath
tput setaf 2
	mkdir -p ~/projects/nougat
	cd ~/projects/nougat
	echo
	repo init -u git://github.com/BrokenROM/platform_manifest.git -b n7.1
	time repo sync --force-broken --force-sync --no-clone-bundle --quiet
	echo
	echo -e "${bldblu}Please remember to run ccache -M 40 to set 40gb of ccache, before you start your first build :D"
	echo -e "${bldblu}This value can be shifted up/down a bit to your liking"
	cd ~/projects/nougat
exit
