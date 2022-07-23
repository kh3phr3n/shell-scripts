#!/bin/zsh

# Settings file location
SFL=~'/Library/Application Support/Code/User/settings.json'

# Font family
FF='SFMonoPowerline-Medium'
# Font sizes
FS='14'

# Zoom level
ZL='0.1'

# Editor line height
ELH='0'
# Editor letter spacing
ELS='0.2'

# Terminal line height
TLH='1.2'
# Terminal letter spacing
TLS='1'

clear
# Create backup file
test ! -e ${SFL}_ && cp ${SFL} ${SFL}_

# Remove unused settings
sed -i "" "/linuxExec/d;/custom_css/d" ${SFL}

# Update metric settings
sed -i "" "/zoom/s/0/${ZL}/g" ${SFL}
sed -i "" "/fontSize/s/13/${FS}/g" ${SFL}
sed -i "" "/editor.lineHeight/s/17/${ELH}/g" ${SFL}
sed -i "" "/integrated.lineHeight/s/1/${TLH}/g" ${SFL}
sed -i "" "/editor.letterSpacing/s/0.5/${ELS}/g" ${SFL}
sed -i "" "/integrated.letterSpacing/s/1/${TLS}/g" ${SFL}
sed -i "" "/editor.fontFamily/s/'Iosevka Term Semibold'/${FF}/g" ${SFL}

# Inspect new settings
git diff ${SFL}_ ${SFL}; rm ${SFL}_

