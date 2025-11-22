# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/


NFQWS_DIR="$PADAVAN_BUILD_PATH/trunk/user/nfqws"
cd /tmp
rm -rf zapret-v72.2
wget -q https://github.com/bol-van/zapret/archive/refs/tags/v72.2.tar.gz
tar -xzf v72.2.tar.gz
cd zapret-v72.2
rm -rf "$NFQWS_DIR"/*
cp -a nfq/* "$NFQWS_DIR/"
cp -a shared/* "$NFQWS_DIR/"
cp -a zapret-72.2.tar.gz "$NFQWS_DIR/"
echo "zapret nfqws updated to v72.2"
