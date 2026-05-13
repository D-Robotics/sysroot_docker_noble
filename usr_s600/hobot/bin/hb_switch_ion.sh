#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

log_error() {
    echo -e "${RED}[ERROR] $1${NC}" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN] $1${NC}" >&2
}

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

help_msg()
{
    log_info "Usage: $0 <bpu_first | cpu_first | balanced | default>"
    log_info "Example: $0 bpu_first"
    exit 1
}

if [ $# -ne 1 ]; then
    help_msg
fi

target=$1

# Check if dtc command exists
if ! command -v fdtput &> /dev/null; then
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
            if [[ "$boardid" == "0x5111110"  ]]; then
                echo "rdk-s600-mcb-v0p1.dtb"
            elif [[ "$boardid" == "0x5121210" ]]; then
                echo "rdk-s600-mcb-v0p2.dtb"
            else
                echo "Invalid"
            fi
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

if [ "$dtb_name" = "Invalid" ];then
    log_error "Cannot find valid dtb for current board!"
    exit 1
fi

INPUT_DTB="/boot/hobot/${dtb_name}"
ORIG_INPUT_DTB="${INPUT_DTB}.bak"
OUTPUT_DTB="${INPUT_DTB}"

function reset_dtb()
{
    log_info "Restoring to default..."
    if [ -f "${ORIG_INPUT_DTB}" ];then
        cp "${ORIG_INPUT_DTB}" "${OUTPUT_DTB}"
        rm "${ORIG_INPUT_DTB}"
    fi
}

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
        if [[ "${INPUT_DTB}" = *"-s600-"* ]];then #total size 24GiB
            # ion-pool 2048MiB
            ion_pool_reg_val=(0x40 0xC0000000 0x0 0x80000000)
            # ion-carveout 18360MiB
            ion_carveout_reg_val=(0x42 0x00000000 0x4 0x80000000)
            # ion-cam 2048MiB
            ion_cma_reg_val=(0x46 0x80000000 0x0 0x80000000)
            # ion-uncache 2048MiB
            ion_uncache_reg_val=(0x47 0x00000000 0x0 0x80000000)
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
            log_warn "CAUTION! Setting bpu_first on S100 might introduce random performance issue due to limited memory!"
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
        reset_dtb
        exit 0
    ;;
    *)
        log_error "Invalid option $target"
        help_msg
    ;;
esac

# Set ion region sizes according to input

usage=$(df -h /boot | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$usage" -ge 95 ]; then
    log_error "/boot partition is full(${usage} used), cannot update dtb!"
    log_info "Maybe you should run the following command to resize the filesystem:"
    log_info "    sudo resize2fs /dev/block/platform/by-name/boot_cur"
    exit 1
fi

if [ ! -f "${ORIG_INPUT_DTB}" ];then
    cp "${INPUT_DTB}" "${ORIG_INPUT_DTB}"
    log_info "Backup created:${ORIG_INPUT_DTB}"
else
    log_info "Backup(${ORIG_INPUT_DTB}) already exists, skip backup..."
fi

fdtput -t x "$INPUT_DTB" /reserved-memory/ion_reserved reg \
    "${ion_pool_reg_val[@]}" || {
    log_error "Update ion-pool reg failed!"
    reset_dtb
    exit 1
}

fdtput -t x "$INPUT_DTB" /reserved-memory/ion_carveout reg \
    "${ion_carveout_reg_val[@]}" || {
        log_error "Update ion_carveout reg failed!"
        reset_dtb
        exit 1;
}

fdtput -t x "$INPUT_DTB" /reserved-memory/ion_cma reg \
    "${ion_cma_reg_val[@]}" || {
        log_error "Update ion_cma reg failed!"
        reset_dtb
        exit 1
}

if [[ "${INPUT_DTB}" = *"-s600-"* ]];then
    fdtput -t x "$INPUT_DTB" /reserved-memory/ion_uncache reg \
        "${ion_uncache_reg_val[@]}" || {
            log_error "Update ion_uncache reg failed!"
            reset_dtb
            exit 1
    }
fi

log_info "ion_reserved reg = <$(fdtget -t x "$INPUT_DTB" /reserved-memory/ion_reserved reg)>"
log_info "ion_carveout reg = <$(fdtget -t x "$INPUT_DTB" /reserved-memory/ion_carveout reg)>"
log_info "ion_cma reg = <$(fdtget -t x "$INPUT_DTB" /reserved-memory/ion_cma reg)>"
if [[ "${INPUT_DTB}" = *"-s600-"* ]];then
log_info "ion_uncache reg = <$(fdtget -t x "$INPUT_DTB" /reserved-memory/ion_uncache reg)>"
fi

log_info "Update ${INPUT_DTB} for $target Done!"
log_info "The change will take effect AFTER reboot!"
