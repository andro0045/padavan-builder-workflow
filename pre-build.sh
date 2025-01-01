# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/

# Отключение log wireguard debug
sed -i 's/func_enable_kernel_param "CONFIG_WIREGUARD_DEBUG"/func_disable_kernel_param "CONFIG_WIREGUARD_DEBUG"/' padavan-ng/trunk/build_firmware.sh
