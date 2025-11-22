# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/



set -e  # Выходим при любой ошибке

# Пути
PADAVAN_DIR="${GITHUB_WORKSPACE:-$(pwd)}/trunk"
NFQWS_DIR="$PADAVAN_DIR/user/nfqws"

echo "=== Обновление zapret до v72.2 в $NFQWS_DIR ==="

# Создаем временную директорию
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Скачиваем zapret v72.2
wget -q https://github.com/bol-van/zapret/archive/refs/tags/v72.2.tar.gz
tar -xzf v72.2.tar.gz

# Сохраняем локальные патчи и конфиги (если есть)
PATCHES_DIR="$NFQWS_DIR/patches"
CONFIG_DIR="$NFQWS_DIR/config"
[ -d "$PATCHES_DIR" ] && cp -a "$PATCHES_DIR" "$TMP_DIR/"
[ -d "$CONFIG_DIR" ] && cp -a "$CONFIG_DIR" "$TMP_DIR/"

# Обновляем исходники nfqws
rm -rf "$NFQWS_DIR"/*
cp -a zapret-v72.2/nfq/* zapret-v72.2/shared/* "$NFQWS_DIR/"

# Восстанавливаем локальные патчи и конфиги
[ -d "$TMP_DIR/patches" ] && cp -a "$TMP_DIR/patches" "$NFQWS_DIR/"
[ -d "$TMP_DIR/config" ] && cp -a "$TMP_DIR/config" "$NFQWS_DIR/"

# Копируем скрипты и стратегии
mkdir -p "$NFQWS_DIR/zapret"
cp -a zapret-v72.2/blockcheck.sh zapret-v72.2/ipset zapret-v72.2/scripts "$NFQWS_DIR/zapret/" 2>/dev/null || true

# Самый свежий zapret.sh из main
wget -qO "$NFQWS_DIR/zapret/zapret.sh" https://raw.githubusercontent.com/bol-van/zapret/main/zapret.sh
chmod +x "$NFQWS_DIR/zapret/zapret.sh"

# Обновляем Makefile
cat > "$NFQWS_DIR/Makefile" <<'EOF'
ifeq ($(CONFIG_FIRMWARE_INCLUDE_NFQWS),y)
TARGETS += nfqws
NFQWS_OBJ = nfqws.o ws.o opt.o util.o ipq.o list.o
$(obj)/nfqws: $(addprefix $(obj)/,$(NFQWS_OBJ))
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) -lnetfilter_queue -lnfnetlink -lmnl

romfs:
	$(ROMFSINST) $(obj)/nfqws /usr/sbin/nfqws
	$(ROMFSINST) $(NFQWS_DIR)/zapret /etc/storage/zapret
endif

# Версия zapret
CFLAGS += -DNFQWS_VERSION=\"v72.2\"
EOF

# Принудительная пересборка nfqws
find "$NFQWS_DIR" -type f -exec touch {} \;

# Очистка временной директории
rm -rf "$TMP_DIR"

echo "=== Zapret обновлен до v72.2 с сохранением патчей и конфигов. Готово к сборке! ==="
