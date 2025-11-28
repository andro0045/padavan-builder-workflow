# -----------------------------
# Копирование изображений
# -----------------------------
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# -----------------------------
# Копирование CSS файлов
# -----------------------------
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/

# -----------------------------
# Обновление nfqws 
# -----------------------------
rm -rf padavan-ng/trunk/user/nfqws
mkdir -p padavan-ng/trunk/user/nfqws
unzip -o nfqws.zip -d padavan-ng/trunk/user/nfqws
