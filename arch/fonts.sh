#!/bin/bash

DPI='96'  # Xft dpi
MSF='13'  # Monospace fonts
SSF='13'  # Sans serif fonts
ULS='0'   # URxvt letter spacing
AWP='3'   # Alacritty window padding
AOX='0'   # Alacritty font offset x
AOY='0'   # Alacritty font offset y
VLS='0.2' # VSCode letter spacing
VZL='1.5' # VSCode zoom level

# Format: diff:pattern:oldvalue:newvalue:file
UPDATES=(
    # Xft
    "1:dpi:166:$DPI:$HOME/.config/xrdb/xft/config"

    # i3wm
    "0:pango:11:$MSF:$HOME/.config/i3/config"
    "0:title:11:$MSF:$HOME/.config/i3/config"
    "1:dmenu:-11:-$MSF:$HOME/.config/i3/config"

    # URxvt
    "0:size:11:$MSF:$HOME/.config/xrdb/urxvt/config"
    "1:letter:1:$ULS:$HOME/.config/xrdb/urxvt/config"

    # Alacritty
    "1:size:11:$MSF:$HOME/.config/alacritty/alacritty.yml"

    # Gtk*
    "1:font:11:$SSF:$HOME/.gtkrc-2.0"
    "1:font:11:$SSF:$HOME/.config/gtk-3.0/settings.ini"

    # VSCode
    "0:zoom:0.7:$VZL:$HOME/.config/vscode/settings.json"
    # "1:letter:0.2:$VLS:$HOME/.config/vscode/settings.json"
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
    # Additional settings
    [[ ${file} =~ 'alacritty' ]] && sed -i "4,5s/2/${AWP}/;16s/1/${AOX}/;17s/0/${AOY}/" ${file}

    if [ ${diff} -ne 0 ]
    then
        # Inspect current update
        git diff ${file}_ ${file}
        # Clean backup file
        rm ${file}_ && echo -e "\n:: ..."; read
    fi
done

