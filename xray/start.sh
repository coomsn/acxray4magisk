#!/system/bin/sh
MODDIR="/data/adb/modules/xray-module"
SCRIPTS_DIR="/data/adb/xray"

  export PATH="/data/adb/magisk:/data/adb/ksu/bin:$PATH:/system/bin"

cd ${0%/*}
source ./xray.service

inot_gid=24520

if [ ! -f ${MODDIR}/disable ]; then
	run_proxy
fi

if pgrep inotifyd > /dev/null 2>&1 ; then
  pkill -g ${inot_gid}
fi

  busybox setuidgid 0:${inot_gid} inotifyd "${SCRIPTS_DIR}/xray.inotify" "${MODDIR}" > /dev/null 2>&1 &

