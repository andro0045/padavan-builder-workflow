#!/bin/bash

# Определяем директории назначения
IMG_DIR="padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img"
CSS_DIR="padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css"

# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png \
   glyphicons-halflings-{white,.png} dark-bg.jpg arrow-right.png ajax-loader.gif \
   "$IMG_DIR/"

# Копирование стилей CSS в директорию css
cp engage.itoggle.css main.css "$CSS_DIR/"
