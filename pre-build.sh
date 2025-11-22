# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/



set -e

cd /tmp
rm -rf zapret-v72.2* 2>/dev/null
wget -q https://github.com/bol-van/zapret/archive/refs/tags/v72.2.tar.gz
tar -xzf v72.2.tar.gz

NFQWS_DIR="$PADAVAN_BUILD_PATH/trunk/user/nfqws"

# Полная замена на v72.2
rm -rf "$NFQWS_DIR"/*
cp -a zapret-v72.2/nfq/* zapret-v72.2/shared/* "$NFQWS_DIR/"

# Свежий zapret.sh + стратегии
mkdir -p "$NFQWS_DIR/zapret"
cp -a zapret-v72.2/blockcheck.sh zapret-v72.2/ipset zapret-v72.2/scripts "$NFQWS_DIR/zapret/" 2>/dev/null || true
wget -qO "$NFQWS_DIR/zapret/zapret.sh" https://raw.githubusercontent.com/bol-van/zapret/main/zapret.sh
chmod +x "$NFQWS_DIR/zapret/zapret.sh"

# Makefile — оригинальный Padavan-ng + версия v72.2 + romfs для стратегий
cat > "$NFQWS_DIR/Makefile" <<'EOF'
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

CFLAGS += -DNFQWS_VERSION=\"v72.2\"
EOF

# Принудительно пересобираем
find "$NFQWS_DIR" -exec touch {} \;

echo "zapret обновлён до v72.2 + свежий zapret.sh"
