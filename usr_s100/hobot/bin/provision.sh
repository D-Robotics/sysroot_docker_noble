#!/bin/zsh

provision_mode="debug"
provision_step=""

function burn_efuse ()
{
	if [ ! -f /userdata/efuse_map.bin.enc ];then
		echo "/userdata/efuse_map.bin.enc is not exist"
		exit 1
	fi
	echo "set ${provision_mode} mode"
	provision_tool --prov-set-mode ${provision_mode}
	provision_tool --get-lifecycle
	echo "prov-efusemap"
	provision_tool --prov-efusemap /userdata/efuse_map.bin.enc
	rm /userdata/efuse_map.bin.enc
	sync
	if [[ x"${provision_mode}" == x"debug" ]];then
		echo "keep-autosense-reset"
		provision_tool --keep-autosense-reset
	fi
}

function recypt_imgs()
{
	rmmod hobot_vspi_debug > /dev/null 2>&1
	modprobe hobot_vspi
	echo "set ${provision_mode} mode"
	provision_tool --prov-set-mode ${provision_mode}
	echo "prov-finish"
	provision_tool --prov-finish
	echo "prov-imgs"
	provision_tool --prov-imgs
	echo "prov-finish"
	provision_tool --prov-finish

	for i in $(seq 0 9); do [ -S /opt/storage_socket ] && break; sleep 1; done; [ -S /opt/storage_socket ];

	if [[ x"${provision_mode}" == x"debug" ]];then
		echo "keep-autosense-reset"
		provision_tool --keep-autosense-reset
	fi
}

if [[ x"$1" == x"release" ]];then
	provision_mode="release"
fi

provision_step=$2
if [[ x"${provision_step}" != x"burn_efuse" && x"${provision_step}" != x"recypt_imgs" ]];then
	echo "invalid provision step"
	exit 1
fi

if [[ x"${provision_mode}" == x"release" ]];then
	echo 1 > /sys/bus/platform/devices/scmi_ext_notify/scmi_ext_notify
fi

if [[ x"${provision_step}" == x"burn_efuse" ]];then
	burn_efuse
else
	recypt_imgs
fi

if [[ x"${provision_mode}" == x"release" ]];then
	echo 0 > /sys/bus/platform/devices/scmi_ext_notify/scmi_ext_notify
fi

reboot
