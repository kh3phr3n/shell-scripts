#!/bin/bash

XD='96'
MS='15'
UI='14'
ZL='2.0'

# Format: diff:pattern:oldvalue:newvalue:file
UPDATES=(
    # Xft dpi
    "1:dpi:166:$XD:$HOME/.config/xrdb/xft/config"
    # Pango font size
    "0:pango:12:$MS:$HOME/.config/i3/config"
    # Title font size
    "0:title:12:$MS:$HOME/.config/i3/config"
    # Dmenu font size
    "1:dmenu:-12:-$MS:$HOME/.config/i3/config"
    # Termite font size
    "1:font:12:$MS:$HOME/.config/termite/config"
    # URxvt font size
    "1:size:12:$MS:$HOME/.config/xrdb/urxvt/config"
    # Gtk* font size
    "1:font:11:$UI:$HOME/.gtkrc-2.0"
    "1:font:11:$UI:$HOME/.config/gtk-3.0/settings.ini"
    # VSCode zoom level
    "1:zoom:0.8:$ZL:$HOME/.config/vscode/settings.json"
)

# Let's update files
for update in ${UPDATES[@]}
do
    diff=$(echo $update | cut -d: -f1)
    patn=$(echo $update | cut -d: -f2)
    oldv=$(echo $update | cut -d: -f3)
    newv=$(echo $update | cut -d: -f4)
    file=$(echo $update | cut -d: -f5)

    clear
    # Create backup file
    test ! -e ${file}_ && cp ${file} ${file}_
    # Update current file
    sed -i "/${patn}/s/${oldv}/${newv}/g" ${file}

    if [ ${diff} -ne 0 ]
    then
        # Inspect current update
        git diff ${file}_ ${file}
        # Clean backup file
        rm ${file}_ && echo -e "\n:: ..."; read
    fi
done

