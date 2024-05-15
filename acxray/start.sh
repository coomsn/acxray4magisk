#!/system/bin/sh
MODDIR="/data/adb/modules/acxray-module"
SCRIPTS_DIR="/data/adb/acxray/xray.inotify"
busybox="/data/adb/magisk/busybox"
normal="\033[0m"
green="\033[0;32m"
red="\033[91m"

cd ${0%/*}

source ./xray.service

if [ ! -f ${MODDIR}/disable ]; then
	run
fi
if pgrep inotifyd > /dev/null 2>&1 ; then
  pkill -g 20000
fi
${busybox} setuidgid 0:20000 inotifyd "${SCRIPTS_DIR}" "${MODDIR}" > /dev/null 2>&1 &
echo -e "${green}now,xray.inotify is running with PID ${red}$(pgrep inotifyd)${green}.${normal}"
