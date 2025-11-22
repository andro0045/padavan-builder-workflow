# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/


TRUNK="$(pwd)/trunk"
TMP="/tmp/zapret-v72.2"

rm -rf "$TRUNK/user/nfqws"
git clone --depth 1 --branch v72.2 https://github.com/bol-van/zapret.git "$TMP"
cp -r "$TMP/nfqws" "$TRUNK/user/"
rm -rf "$TMP"
