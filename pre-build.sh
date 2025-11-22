# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/



set -e  # Выходим при ошибке

# Путь к исходникам Padavan-ng (адаптируй под workflow, если нужно)
PADAVAN_DIR="$(pwd)/trunk"  # Или $GITHUB_WORKSPACE/source/trunk — проверь в логе Actions
NFQWS_DIR="$PADAVAN_DIR/user/nfqws"

echo "=== Начинаем обновление zapret до v72.2 в $NFQWS_DIR ==="

# Переходим в временную директорию для скачивания
cd /tmp
rm -rf zapret-v72.2* 2>/dev/null || true

# Скачиваем и распаковываем v72.2
wget -q https://github.com/bol-van/zapret/archive/refs/tags/v72.2.tar.gz
tar -xzf v72.2.tar.gz

# Полная замена исходников nfqws на v72.2
rm -rf "$NFQWS_DIR"/* 2>/dev/null || true
cp -a zapret-v72.2/nfq/* zapret-v72.2/shared/* "$NFQWS_DIR/"

# Копируем скрипты и стратегии (blockcheck.sh, ipset, scripts)
mkdir -p "$NFQWS_DIR/zapret"
cp -a zapret-v72.2/blockcheck.sh zapret-v72.2/ipset zapret-v72.2/scripts "$NFQWS_DIR/zapret/" 2>/dev/null || true

# Самый свежий zapret.sh из main (обновления чаще, чем в тегах)
wget -qO "$NFQWS_DIR/zapret/zapret.sh" https://raw.githubusercontent.com/bol-van/zapret/main/zapret.sh
chmod +x "$NFQWS_DIR/zapret/zapret.sh"

# Обновляем Makefile: оригинал Padavan-ng + версия v72.2 + romfs для стратегий
cat > "$NFQWS_DIR/Makefile" <<'EOF'
# Makefile для nfqws (Padavan-ng, обновлено до zapret v72.2)

ifeq ($(CONFIG_FIRMWARE_INCLUDE_NFQWS),y)
TARGETS += nfqws
NFQWS_OBJ = nfqws.o ws.o opt.o util.o ipq.o list.o
$(obj)/nfqws: $(addprefix $(obj)/,$(NFQWS_OBJ))
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) -lnetfilter_queue -lnfnetlink -lmnl

romfs:
	$(ROMFSINST) $(obj)/nfqws /usr/sbin/nfqws
	$(ROMFSINST) -s /usr/sbin/nfqws /tmp/zapret
	$(ROMFSINST) $(NFQWS_DIR)/zapret /etc/storage/zapret
endif

# Версия zapret
CFLAGS += -DNFQWS_VERSION=\"v72.2\"
EOF

# Принудительная пересборка: трогаем все файлы (touch)
find "$NFQWS_DIR" -exec touch {} \; 2>/dev/null || true

# Очистка
rm -rf /tmp/zapret-v72.2*

echo "=== Zapret успешно обновлён до v72.2 + свежий zapret.sh. Makefile обновлён. Готово к сборке! ==="
echo "Проверь логи: версия в CFLAGS теперь 'v72.2'."
