#!/bin/bash

echo -n "Geting Frida libs from the repo... "
wget -qO - https://github.com/frida/frida/releases/latest | grep -o "\/frida\/frida\/releases\/download\/.*\/frida-gadget-.*-android-.*\.so\.xz" | sed 's/\/frida\/frida/https:\/\/github\.com\/frida\/frida/g' | sed 's/%0A/\n/g' > list.txt
wget -q -i list.txt
echo "DONE"

echo -n "Unpacking libs and cleaning temp files... "
unxz *.xz

mkdir -p frida_libs/arm64 frida_libs/arm64-v8a frida_libs/armeabi frida_libs/armeabi-v7a frida_libs/x86 frida_libs/x86_64
mv *.so frida_libs/
cd frida_libs/

cp -f *-android-arm64.so arm64/libfrida-gadget.so
cp -f *-android-arm64.so arm64-v8a/libfrida-gadget.so
cp -f *-android-arm.so armeabi/libfrida-gadget.so
cp -f *-android-arm.so armeabi-v7a/libfrida-gadget.so
cp -f *-android-x86.so x86/libfrida-gadget.so
cp -f *-android-x86_64.so x86_64/libfrida-gadget.so
rm -rf *.so
cd ..


find . -name ".DS_*" -type f -delete
find . -name "*~*" -type f -delete
rm -rf list.txt
echo "Done"
