#!/bin/bash

echo -n "Geting Frida libs from the repo... "
wget -qO - https://github.com/frida/frida/releases/latest | grep -o "\/frida\/frida\/releases\/download\/.*\/frida-gadget-.*-android-.*\.so\.xz" | sed 's/\/frida\/frida/https:\/\/github\.com\/frida\/frida/g' | sed 's/%0A/\n/g' > list.txt
wget -q -i list.txt
echo "DONE"
unxz *.xz


mkdir frida_libs
mkdir frida_libs/arm64 frida_libs/arm64-v8a frida_libs/armeabi frida_libs/armeabi-v7a frida_libs/x86 frida_libs/x86_64
mv *.so frida_libs/
cd frida_libs/

cp *-arm64.so arm64
mv arm64/*.so arm64/libfrida-gadget.so
cp *-arm64.so arm64-v8a
mv arm64-v8a/*.so arm64-v8a/libfrida-gadget.so
cp *-arm.so armeabi
mv armeabi/*.so armeabi/libfrida-gadget.so
cp *-arm.so armeabi-v7a
mv armeabi-v7a/*.so armeabi-v7a/libfrida-gadget.so
cp *-i386.so x86
mv x86/*.so x86/libfrida-gadget.so
cp *-x86_64.so x86_64
mv x86_64/*.so x86_64/libfrida-gadget.so
rm -rf *.so
cd ..


find . -name ".DS_*" -type f -delete
find . -name "*~*" -type f -delete
rm -rf list.txt
