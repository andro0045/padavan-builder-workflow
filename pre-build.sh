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

# отключаем LTO во всех zapret и nfqws исходниках
for dir in padavan-ng/trunk/user/zapret* padavan-ng/trunk/user/nfqws/zapret-*; do
  [ -d "$dir" ] || continue
  find "$dir" -type f -exec sed -i 's/-flto[^ ]*//g' {} +
  find "$dir" -type f -exec sed -i 's/-fuse-linker-plugin//g' {} +
done

# убрать LTO из переменных окружения
export CFLAGS="${CFLAGS/-flto*/}"
export CXXFLAGS="${CXXFLAGS/-flto*/}"
export LDFLAGS="${LDFLAGS/-flto*/}"
