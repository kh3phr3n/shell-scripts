#!/bin/bash

# Resolution
QHD=true

if [ "${QHD}" == true ]
then
    DPI='109'   # Xft dpi
    MSF='11'    # Monospace fonts
    SSF='11'    # Sans serif fonts
    AWP='3'     # Alacritty window padding
    AOX='0'     # Alacritty font offset x
    AOY='0'     # Alacritty font offset y
    VFS='13'    # VS Code font sizes
    VZL='0.8'   # VS Code zoom level
    VHFS='10'   # VS Code hints font size
    VELH='20'   # VS Code editor line height
    VELS='-0.2' # VS Code editor letter spacing
    VTLH='1'    # VS Code terminal line height
    VTLS='0'    # VS Code terminal letter spacing
    NVXP='3'    # Neovide x-axis padding
    NVFS='11'   # Neovide font size
    NVWD='0'    # Neovide width relative offset
else
    DPI='96'
    MSF='11'
    SSF='11'
    AWP='3'
    AOX='0'
    AOY='0'
    VFS='13'
    VZL='0.8'
    VHFS='10'
    VELH='20'
    VELS='0'
    VTLH='1.05'
    VTLS='0'
    NVXP='3'
    NVFS='11'
    NVWD='0.15'
fi

# Format: diff:pattern:oldvalue:newvalue:file
UPDATES=(
    # Xft
    "1:dpi:158:${DPI}:${HOME}/.config/xrdb/xft/config"

    # i3wm
    "0:pango:9:${MSF}:${HOME}/.config/i3/config"
    "0:title:9:${MSF}:${HOME}/.config/i3/config"
    "1:dmenu:-9:-${MSF}:${HOME}/.config/i3/config"

    # Gtk*
    "1:font:9:${SSF}:${HOME}/.gtkrc-2.0"
    "1:font:9:${SSF}:${HOME}/.config/gtk-3.0/settings.ini"

    # Alacritty
    "1:size:9:${MSF}:${HOME}/.config/alacritty/alacritty.toml"

    # Neovide
    "0:padding:4:${NVXP}:${HOME}/.config/nvim/lua/core/options.lua"
    "0:guifont:9:${NVFS}:${HOME}/.config/nvim/lua/core/options.lua"
    "1:guifont:0.12:${NVWD}:${HOME}/.config/nvim/lua/core/options.lua"

    # VS Code
    "0:zoom:-0.2:${VZL}:${HOME}/.config/vscode/settings.json"
    "0:fontSize:13:${VFS}:${HOME}/.config/vscode/settings.json"
    "0:editor.inlayHints:10:${VHFS}:${HOME}/.config/vscode/settings.json"
    "0:editor.lineHeight:20:${VELH}:${HOME}/.config/vscode/settings.json"
    "0:integrated.lineHeight:1:${VTLH}:${HOME}/.config/vscode/settings.json"
    "0:editor.letterSpacing:-0.2:${VELS}:${HOME}/.config/vscode/settings.json"
    "1:integrated.letterSpacing:0:${VTLS}:${HOME}/.config/vscode/settings.json"
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

