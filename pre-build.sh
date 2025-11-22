# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/


set -e

git clone https://github.com/bol-van/zapret.git padavan-ng/trunk/user/nfqws-new
LATEST_TAG=$(git ls-remote --tags https://github.com/bol-van/zapret.git | awk -F'/' '{print $3}' | grep -E '^v[0-9]+' | sort -V | tail -n1)
git -C padavan-ng/trunk/user/nfqws-new checkout "$LATEST_TAG"
rm -rf padavan-ng/trunk/user/nfqws-new/.git padavan-ng/trunk/user/nfqws-new/.github padavan-ng/trunk/user/nfqws-new/tools
cp -f padavan-ng/trunk/user/nfqws/Makefile padavan-ng/trunk/user/nfqws-new/Makefile 2>/dev/null || true
cp -f padavan-ng/trunk/user/nfqws/zapret.sh padavan-ng/trunk/user/nfqws-new/zapret.sh 2>/dev/null || true
rm -rf padavan-ng/trunk/user/nfqws
mv padavan-ng/trunk/user/nfqws-new padavan-ng/trunk/user/nfqws
find padavan-ng/trunk/user/nfqws -name Makefile -exec sed -i 's/-flto[^ ]*//g' {} +
echo ">>> nfqws обновлён до $LATEST_TAG и LTO отключен"
