# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/


set -e
cd padavan-ng/trunk/user
git clone https://github.com/bol-van/zapret.git nfqws-new
cd nfqws-new
LATEST_TAG=$(git ls-remote --tags https://github.com/bol-van/zapret.git | awk -F'/' '{print $3}' | grep -E '^v[0-9]+' | sort -V | tail -n1)
git checkout "$LATEST_TAG"
rm -rf .git .github tools
cp -f ../nfqws/Makefile ./Makefile 2>/dev/null || true
cp -f ../nfqws/zapret.sh ./zapret.sh 2>/dev/null || true
cd ..
rm -rf nfqws
mv nfqws-new nfqws
echo ">>> nfqws обновлён до $LATEST_TAG"
