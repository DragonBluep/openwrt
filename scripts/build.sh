#!/bin/bash

thread=$(cat /proc/cpuinfo| grep "processor"| wc -l)

# All Target List
TARGET_ALL=(ath79-generic ath79-nand ramips-mt7620 ramips-mt7621 ramips-mt76x8)

Targets=""
case "$1" in
ath79_generic)
	Targets=( ath79_generic )
	;;
ath79_nand)
	Targets=( ath79_nand )
	;;
ipq40xx_generic)
	Targets=( ipq40xx_generic )
	;;
ramips_mt7620)
	Targets=( ramips_mt7620 )
	;;
ramips_mt7621)
	Targets=( ramips_mt7621 )
	;;
ramips_mt76x8)
	Targets=( ramips_mt76x8 )
	;;
all)
	Targets=${TARGET_ALL[@]}
	;;
*)
	echo "Usage: ./build.sh [Target]"
	echo -e "Support Target:"
	echo -e "all\nath79_generic\nath79_nand"
	echo -e "ramips_mt7620\nramips_mt7621\nramips_mt76x8"
	exit
	;;
esac

for Target in ${Targets[@]}
do
	echo "Build Target: ${Target}"
	cp templates/"${Target}"_defconfig .config
	cat templates/packages-default_defconfig >> .config
	make defconfig
	# make clean
	make -j ${thread}
done
