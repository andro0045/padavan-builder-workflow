# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/

set -e
cd padavan-ng/trunk/user
rm -rf nfqws
git clone https://github.com/bol-van/zapret.git nfqws
cd nfqws
git checkout v72.2
rm -rf .git .github tools
