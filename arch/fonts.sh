#!/bin/bash

# Format: diff:pattern:oldvalue:newvalue:file
UPDATES=(
    # Xft dpi
    '1:dpi:166:96:~/.config/xrdb/xft/config'
    # Pango font size
    '0:pango:12:15:~/.config/i3/config'
    # Title font size
    '0:title:12:15:~/.config/i3/config'
    # Dmenu font size
    '1:dmenu:-12:-15:~/.config/i3/config'
    # Termite font size
    '1:font:12:15:~/.config/termite/config'
    # URxvt font size
    '1:size:12:15:~/.config/xrdb/urxvt/config'
    # Gtk* font size
    '1:font:12:15:~/.gtkrc-2.0'
    '1:font:12:15:~/.config/gtk-3.0/settings.ini'
    # VSCode zoom level
    '1:zoom:1.0:2.0:~/.config/Code/User/settings.json'
)

# Let's update files
for update in ${UPDATES[@]}
do
    local diff=$(echo $update | cut -d: -f1)
    local patn=$(echo $update | cut -d: -f2)
    local oldv=$(echo $update | cut -d: -f3)
    local newv=$(echo $update | cut -d: -f4)
    local file=$(echo $update | cut -d: -f5)

    # Create backup file
    test ! -e ${file}_ && cp ${file} ${file}_
    # Update current file
    sed -i "/${patn}/s/${oldv}/${newv}/g" ${file}
    # Inspect current update
    test ${diff} -ne 0 && git diff ${file}_ ${file}
    # Clean backup file
    rm ${file}_ && echo -e "\n:: Press any key to continue..."; read
done

