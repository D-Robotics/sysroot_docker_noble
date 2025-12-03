#!/bin/bash


usage () {
	echo "Usage:"
	echo "    net_reg_dump.sh <eth0 | eth1> [logfile]"
	echo "    eg:net_reg_dump.sh eth1 /userdata/eth1_regs.log"
}

#print_reg print eth reg value
#$1 base reg, $2 reg offset, $3 reg count
print_regs () {
	#echo "$1 $2 $3"
	for ((i=0; i<$3; i++))
	do
		reg=$(($1 + $2 + ($i * 4)))
		printf "0x%x = 0x%08x\n" $reg `devmem $reg` | tee -a $logfile
	done
}

print_eths () {
	echo MAC REGS: | tee $logfile
	print_regs $eth 0 12
	print_regs $eth 0x50 6
	print_regs $eth 0x70 4
	print_regs $eth 0x90 11
	print_regs $eth 0xc0 2
	print_regs $eth 0xd0 11
	print_regs $eth 0x110 2
	print_regs $eth 0x11c 4
	print_regs $eth 0x140 5
	print_regs $eth 0x200 5
	print_regs $eth 0x230 3
	print_regs $eth 0x240 2
	print_regs $eth 0x300 2
	print_regs $eth 0x700 5
	print_regs $eth 0x900 2
	print_regs $eth 0x910 4
	print_regs $eth 0xb00 9
	print_regs $eth 0xb30 2
	print_regs $eth 0xb40 1
	print_regs $eth 0xb48 11
	print_regs $eth 0xb80 21
	echo MTL REGS: | tee -a $logfile
	print_regs $eth 0xc00 1
	print_regs $eth 0xc08 3
	print_regs $eth 0xc20 1
	print_regs $eth 0xc30 2
	print_regs $eth 0xc40 1
	print_regs $eth 0xc50 1
	print_regs $eth 0xc58 1
	print_regs $eth 0xc60 3
	print_regs $eth 0xc70 1
	print_regs $eth 0xc80 2
	print_regs $eth 0xc90 2
	print_regs $eth 0xca0 6
	print_regs $eth 0xcc0 7
	print_regs $eth 0xce0 1
	print_regs $eth 0xd00 3
	print_regs $eth 0xd14 2
	print_regs $eth 0xd2c 1
	print_regs $eth 0xd30 4
	echo MTL Q REGS: | tee -a $logfile
	print_regs $eth 0xd00 56
	echo DMA REGS: | tee -a $logfile
	print_regs $eth 0x1000 6
	print_regs $eth 0x1020 3
	print_regs $eth 0x1040 1
	print_regs $eth 0x1050 1
	print_regs $eth 0x1080 3
	echo DMA CH0 REGS: | tee -a $logfile
	print_regs $eth 0x1100 28
	echo DMA CH1 REGS: | tee -a $logfile
	print_regs $eth 0x1180 28
	echo DMA CH2 REGS: | tee -a $logfile
	print_regs $eth 0x1200 28
	echo DMA CH3 REGS: | tee -a $logfile
	print_regs $eth 0x1280 28
}







logfile=$2
#echo "$1, $logfile"

case $1 in
	"eth0")
		eth=0x330f0000
		print_eths
	;;
	"eth1")
		eth=0x33100000
		print_eths
	;;
	*)
		usage
	;;
esac

