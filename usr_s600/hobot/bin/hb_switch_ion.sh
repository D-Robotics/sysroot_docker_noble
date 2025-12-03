#!/bin/bash

help_msg()
{
    echo "Usage: $0 <bpu_first | cpu_first | balanced | default>"
    echo "Example: $0 bpu_first"
    exit 1
}

if [ $# -ne 1 ]; then
    help_msg
fi

target=$1

# Check if dtc command exists
if ! command -v dtc &> /dev/null; then
    apt update
    apt install device-tree-compiler -y
fi


function get_dtb()
{
    boardid_sys_path="/sys/class/boardinfo/adc_boardid"
    if [ -f "$boardid_sys_path" ]; then
        boardid="$(cat $boardid_sys_path)"

        # get chip
        if [[ "$boardid" =~ ^0x(51)[1234567][01234567][1234567][1234567].$ ]]; then
            # S600
            echo "rdk-s600-mcb-v0p1.dtb"
        else
            # S100
            case $boardid in
                *"64"*) ;&
                *"65"*)
                    chip_str="s100p"
                ;;
                *"6A"*) ;&
                *"6B"*)
                    chip_str="s100"
                ;;
            esac
            case $boardid in
                *"60")
                    hw_str="v1-21"
                ;;
                *"70")
                    hw_str="v1-20"
                ;;
                *"84")
                    hw_str="v0p5"
                ;;
                *"85")
                    hw_str="v0p6"
                ;;
                *"86")
                    hw_str="v1p0"
                ;;
            esac
            echo "rdk-${chip_str}-${hw_str}.dtb"
        fi
    else
        echo "Invalid"
    fi
}

dtb_name=$(get_dtb)
# echo "INFO: DTB name: $dtb_name"

if [ "$dtb_name" = "Invalid" ];then
    echo "ERROR: Cannot find valid dtb for current board!"
    exit 1
fi

INPUT_DTB="/boot/hobot/${dtb_name}"

case $target in
    "balanced")
        if [[ "${INPUT_DTB}" = *"-s600-"* ]];then #total size 16GiB
            # ion-pool 2048MiB
            ion_pool_reg_val=(0x40 0xC0000000 0x0 0x80000000)
            # ion-carveout 10480MiB
            ion_carveout_reg_val=(0x41 0x40000000 0x2 0x80000000)
            # ion-cam 2048MiB
            ion_cma_reg_val=(0x43 0xC0000000 0x0 0x80000000)
            # ion-uncache 2048MiB
            ion_uncache_reg_val=(0x44 0x40000000 0x0 0x80000000)
        elif [[ "${INPUT_DTB}" = *"-s100p-"* ]];then
            # ion-pool 7680MiB
            ion_pool_reg_val=(0x4 0x00000000 0x1 0xe0000000)
            # ion-carveout 128MiB
            ion_carveout_reg_val=(0x8 0x00000000 0x0 0x08000000)
            # ion-cam 128MiB
            ion_cma_reg_val=(0xc 0x80000000 0x0 0x08000000)
        else
            # ion-pool 3840MiB
            ion_pool_reg_val=(0x4 0x00000000 0x0 0xF0000000)
            # ion-carveout 1280MiB
            ion_carveout_reg_val=(0x8 0x00000000 0x0 0x50000000)
            # ion-cam 1GiB
            ion_cma_reg_val=(0xc 0x80000000 0x0 0x40000000)
        fi
    ;;
    "bpu_first")
        if [[ "${INPUT_DTB}" = *"-s600-"* ]];then #total size 28GiB
            # ion-pool 5120MiB
            ion_pool_reg_val=(0x40 0xC0000000 0x1 0x40000000)
            # ion-carveout 13312MiB
            ion_carveout_reg_val=(0x42 0x00000000 0x3 0x40000000)
            # ion-cma 5120MiB
            ion_cma_reg_val=(0x45 0x40000000 0x1 0x40000000)
            # ion-uncache 5120MiB
            ion_uncache_reg_val=(0x46 0x80000000 0x1 0x40000000)
        elif [[ "${INPUT_DTB}" = *"-s100p-"* ]];then
            # ion-pool 5120MiB
            ion_pool_reg_val=(0x4 0x00000000 0x1 0x40000000)
            # ion-carveout 5120MiB
            ion_carveout_reg_val=(0x8 0x00000000 0x1 0x40000000)
            # ion-cma 5120MiB
            ion_cma_reg_val=(0xc 0x80000000 0x1 0x40000000)
        else
            # ion-pool 3840MiB
            ion_pool_reg_val=(0x4 0x00000000 0x0 0xF0000000)
            # ion-carveout 3840MiB
            ion_carveout_reg_val=(0x8 0x00000000 0x0 0xF0000000)
            # ion-cma 1GiB
            ion_cma_reg_val=(0xc 0x80000000 0x0 0x40000000)
            echo "WARNING: CAUTION! Setting bpu_first on S100 might introduce random performance issue due to limited memory!"
        fi
    ;;
    "cpu_first")
        if [[ "${INPUT_DTB}" = *"-s600-"* ]];then #total size 7GiB
            # ion-pool 2048MiB
            ion_pool_reg_val=(0x40 0xC0000000 0x0 0x80000000)
            # ion-carveout 2048MiB
            ion_carveout_reg_val=(0x41 0x40000000 0x0 0x80000000)
            # ion-cma 1024MiB
            ion_cma_reg_val=(0x41 0xC0000000 0x0 0x40000000)
            # ion-uncache 2048MiB
            ion_uncache_reg_val=(0x42 0x00000000 0x0 0x80000000)
        else
            # ion-pool 1GiB
            ion_pool_reg_val=(0x4 0x00000000 0x0 0x40000000)
            # ion-carveout 512MiB
            ion_carveout_reg_val=(0x8 0x00000000 0x0 0x20000000)
            # ion-cma 512MiB
            ion_cma_reg_val=(0xc 0x80000000 0x0 0x20000000)
        fi
    ;;
    "default")
        echo "INFO: Restoring to default..."
        exit 0
    ;;
    *)
        echo "ERROR: Invalid option $target"
        help_msg
    ;;
esac

# Set ion region sizes according to input

fdtput -t x "$INPUT_DTB" /reserved-memory/ion_reserved reg "${ion_pool_reg_val[@]}" || { echo "ERROR: Update ion-pool reg failed!"; exit 1; }
fdtput -t x "$INPUT_DTB" /reserved-memory/ion_carveout reg "${ion_carveout_reg_val[@]}" || { echo "ERROR: Update ion_carveout reg failed!"; exit 1; }
fdtput -t x "$INPUT_DTB" /reserved-memory/ion_cma reg "${ion_cma_reg_val[@]}" || { echo "ERROR: Update ion_cma reg failed!"; exit 1; }
if [[ "${INPUT_DTB}" = *"-s600-"* ]];then
fdtput -t x "$INPUT_DTB" /reserved-memory/ion_uncache reg "${ion_uncache_reg_val[@]}" || { echo "ERROR: Update ion_uncache reg failed!"; exit 1; }
fi

echo "ion_reserved reg = <$(fdtget -t x $INPUT_DTB /reserved-memory/ion_reserved reg)>"
echo "ion_carveout reg = <$(fdtget -t x $INPUT_DTB /reserved-memory/ion_carveout reg)>"
echo "ion_cma reg = <$(fdtget -t x $INPUT_DTB /reserved-memory/ion_cma reg)>"
if [[ "${INPUT_DTB}" = *"-s600-"* ]];then
echo "ion_uncache reg = <$(fdtget -t x $INPUT_DTB /reserved-memory/ion_uncache reg)>"
fi

echo "INFO: Update ${INPUT_DTB} for $target Done!"
echo "INFO: The change will take effect AFTER reboot!"
