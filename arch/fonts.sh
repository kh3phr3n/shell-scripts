#!/bin/bash

# Resolution
QHD=true

if [ "${QHD}" == true ]
then
    DPI='109'  # Xft dpi
    MSF='11'   # Monospace fonts
    SSF='11'   # Sans serif fonts
    ULS='0'    # URxvt letter spacing
    AWP='3'    # Alacritty window padding
    AOX='0'    # Alacritty font offset x
    AOY='0'    # Alacritty font offset y
    VFS='13'   # VS Code font sizes
    VZL='0.8'  # VS Code zoom level
    VHFS='10'  # VS Code hints font size
    VELH='17'  # VS Code editor line height
    VELS='0.2' # VS Code editor letter spacing
    VTLH='1'   # VS Code terminal line height
    VTLS='1'   # VS Code terminal letter spacing
else
    DPI='96'
    MSF='11'
    SSF='11'
    ULS='0'
    AWP='3'
    AOX='0'
    AOY='0'
    VFS='13'
    VZL='0.8'
    VHFS='10'
    VELH='17'
    VELS='0.1'
    VTLH='1'
    VTLS='1'
fi

# Format: diff:pattern:oldvalue:newvalue:file
UPDATES=(
    # Xft
    "1:dpi:158:${DPI}:${HOME}/.config/xrdb/xft/config"

    # i3wm
    "0:pango:10:${MSF}:${HOME}/.config/i3/config"
    "0:title:10:${MSF}:${HOME}/.config/i3/config"
    "1:dmenu:-10:-${MSF}:${HOME}/.config/i3/config"

    # URxvt
    "0:size:10:${MSF}:${HOME}/.config/xrdb/urxvt/config"
    "1:letter:0:${ULS}:${HOME}/.config/xrdb/urxvt/config"

    # Alacritty
    "1:size:10:${MSF}:${HOME}/.config/alacritty/alacritty.toml"

    # Gtk*
    "1:font:10:${SSF}:${HOME}/.gtkrc-2.0"
    "1:font:10:${SSF}:${HOME}/.config/gtk-3.0/settings.ini"

    # VS Code
    "0:zoom:0:${VZL}:${HOME}/.config/vscode/settings.json"
    "0:fontSize:13:${VFS}:${HOME}/.config/vscode/settings.json"
    "0:editor.inlayHints:10:${VHFS}:${HOME}/.config/vscode/settings.json"
    "0:editor.lineHeight:17:${VELH}:${HOME}/.config/vscode/settings.json"
    "0:integrated.lineHeight:1:${VTLH}:${HOME}/.config/vscode/settings.json"
    "0:editor.letterSpacing:0.5:${VELS}:${HOME}/.config/vscode/settings.json"
    "1:integrated.letterSpacing:1:${VTLS}:${HOME}/.config/vscode/settings.json"
)

# Let's update files
for update in ${UPDATES[@]}
do
    diff=$(echo ${update} | cut -d: -f1)
    patn=$(echo ${update} | cut -d: -f2)
    oldv=$(echo ${update} | cut -d: -f3)
    newv=$(echo ${update} | cut -d: -f4)
    file=$(echo ${update} | cut -d: -f5)

    clear
    # Create backup file
    test ! -e ${file}_ && cp ${file} ${file}_
    # Update current file
    sed -i "/${patn}/s/${oldv}/${newv}/g" ${file}
    # Additional settings
    [[ ${file} =~ 'alacritty' ]] && sed -i "5,6s/2/${AWP}/;12s/0/${AOX}/;13s/0/${AOY}/" ${file}

    if [ ${diff} -ne 0 ]
    then
        # Inspect current update
        git diff ${file}_ ${file}
        # Clean backup file
        rm ${file}_ && echo -e "\n:: ..."; read
    fi
done

