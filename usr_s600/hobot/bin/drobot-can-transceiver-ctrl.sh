#!/bin/bash

boardinfo_path=/sys/class/boardinfo/

soc_name_f="${boardinfo_path}/soc_name"
hw_version_f="${boardinfo_path}/hw_version"


soc_name=$(cat "${soc_name_f}")
hw_version=$(cat "${hw_version_f}")

MAIN_CAN_STB_GPIO_NUM=369

if [ "$soc_name" != "S600" ];then
	exit 0
fi

GPIO_DEBUGFS="/sys/class/gpio"
GPIO_DEBUGFS_PREFIX="${GPIO_DEBUGFS}/gpio"
MAIN_CAN_STB_GPIO_DIR="${GPIO_DEBUGFS_PREFIX}${MAIN_CAN_STB_GPIO_NUM}"


function check_gpio_present()
{
	gpio_num="$1"
	gpio_debugfs_path="${GPIO_DEBUGFS_PREFIX}${gpio_num}"
	if [ -d "${gpio_debugfs_path}" ];then
		echo "True"
	else
		echo "False"
	fi
}

case $1 in
    start)
		if [ "$(check_gpio_present $MAIN_CAN_STB_GPIO_NUM)" = "False" ];then
			echo $MAIN_CAN_STB_GPIO_NUM > ${GPIO_DEBUGFS}/export
		fi
		echo out > "${MAIN_CAN_STB_GPIO_DIR}/direction"
		echo 1 > "${MAIN_CAN_STB_GPIO_DIR}/value"
	;;
	stop)
		if [ "$(check_gpio_present $MAIN_CAN_STB_GPIO_NUM)" = "False" ];then
			echo $MAIN_CAN_STB_GPIO_NUM > ${GPIO_DEBUGFS}/export
		fi
		echo out > "${MAIN_CAN_STB_GPIO_DIR}/direction"
		echo 0 > "${MAIN_CAN_STB_GPIO_DIR}/value"
	;;
	restart)
		# Restart the daemon.
		$0 stop && sleep 1 && $0 start
		;;
	status)
		if [ "$(check_gpio_present $MAIN_CAN_STB_GPIO_NUM)" = "False" ];then
			echo "Disabled"
		else
			if [ "$(cat "${MAIN_CAN_STB_GPIO_DIR}/value")" -eq 1 ];then
				echo "Enabled"
			else
				echo "Disabled"
			fi
		fi
		;;
	*)
	# For invalid arguments, print the usage message.
	echo "Usage: $0 {start|stop|restart|status}"
	exit 2
	;;
esac
