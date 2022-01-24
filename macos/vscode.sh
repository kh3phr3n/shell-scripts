#!/bin/zsh

# Settings file location
SFL='~/Library/Application\ Support/Code/User/settings.json'

# Font family
FF='SFMonoPowerline-Regular'
# Font sizes
FS='14'

# Zoom level
ZL='0'

# Editor line height
ELH='0'
# Editor letter spacing
ELS='0.3'

# Terminal line height
TLH='1.2'
# Terminal letter spacing
TLS='1'

clear
sed -i_ "/zoom/s/0/$ZL/g" $SFL
sed -i_ "/fontSize/s/13/$FS/g" $SFL
sed -i_ "/editor.lineHeight/s/17/$ELH/g" $SFL
sed -i_ "/integrated.lineHeight/s/1/$TLH/g" $SFL
sed -i_ "/editor.letterSpacing/s/0.5/$ELS/g" $SFL
sed -i_ "/integrated.letterSpacing/s/1/$TLS/g" $SFL
sed -i_ "/editor.fontFamily/s/'Iosevka Term Semibold'/$FF/g" $SFL

# Inspect new settings
git diff ${SFL}_ ${SFL} && rm ${SFL}_

