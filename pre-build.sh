# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/



#!/bin/bash
set -e

BASE=padavan-ng/trunk/user
git clone https://github.com/bol-van/zapret.git "$BASE/nfqws-new"
TAG=$(git ls-remote --tags https://github.com/bol-van/zapret.git | awk -F'/' '{print $3}' | grep -E '^v[0-9]+' | sort -V | tail -n1)
git -C "$BASE/nfqws-new" checkout "$TAG"
rm -rf "$BASE/nfqws-new/.git" "$BASE/nfqws-new/.github" "$BASE/nfqws-new/tools"
cp -f "$BASE/nfqws/Makefile" "$BASE/nfqws-new/Makefile" 2>/dev/null || true
cp -f "$BASE/nfqws/zapret.sh" "$BASE/nfqws-new/zapret.sh" 2>/dev/null || true
rm -rf "$BASE/nfqws"
mv "$BASE/nfqws-new" "$BASE/nfqws"
find "$BASE/nfqws" -type f -name Makefile -exec sed -i 's/-flto[^ ]*//g' {} +
export CFLAGS="${CFLAGS//-flto/}"
export CXXFLAGS="${CXXFLAGS//-flto/}"
echo ">>> nfqws обновлён до $TAG, LTO отключен"
