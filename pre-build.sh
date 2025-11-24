# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/

NFQWS_DIR="padavan-ng/trunk/user/nfqws"
ZIP_FILE="nfqws.zip"

echo "==> Очистка каталога $NFQWS_DIR"
rm -rf "$NFQWS_DIR"
mkdir -p "$NFQWS_DIR"

echo "==> Распаковка $ZIP_FILE в $NFQWS_DIR"
unzip -jo "$ZIP_FILE" -d "$NFQWS_DIR"

echo "==> Готово"
