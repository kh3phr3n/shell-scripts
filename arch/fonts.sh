#!/bin/bash

# Resolution
QHD=true

if [ "${QHD}" == true ]
then
    DPI='109' # Xft dpi
    MSF='12'  # Monospace fonts
    SSF='13'  # Sans serif fonts
    ULS='0'   # URxvt letter spacing
    AWP='3'   # Alacritty window padding
    AOX='0'   # Alacritty font offset x
    AOY='0'   # Alacritty font offset y
    VZL='1.3' # VSCode zoom level
else
    DPI='96'
    MSF='13'
    SSF='13'
    ULS='-1'
    AWP='3'
    AOX='0'
    AOY='0'
    VZL='1.5'
fi

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
    "1:letter:0:$ULS:$HOME/.config/xrdb/urxvt/config"

    # Alacritty
    "1:size:11:$MSF:$HOME/.config/alacritty/alacritty.yml"

    # Gtk*
    "1:font:11:$SSF:$HOME/.gtkrc-2.0"
    "1:font:11:$SSF:$HOME/.config/gtk-3.0/settings.ini"

    # VSCode
    "1:zoom:0.6:$VZL:$HOME/.config/vscode/settings.json"
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
    [[ ${file} =~ 'alacritty' ]] && sed -i "8,9s/2/${AWP}/;17s/1/${AOX}/;18s/0/${AOY}/" ${file}

    if [ ${diff} -ne 0 ]
    then
        # Inspect current update
        git diff ${file}_ ${file}
        # Clean backup file
        rm ${file}_ && echo -e "\n:: ..."; read
    fi
done

