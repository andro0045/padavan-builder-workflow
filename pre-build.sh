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

# Заменяем nfqws на v72.2
rm -rf "$PADAVAN_BUILD_PATH/trunk/user/nfqws"/*
cp -a zapret-v72.2/nfq/* zapret-v72.2/shared/* "$PADAVAN_BUILD_PATH/trunk/user/nfqws/"

# Обновляем стратегии и самый свежий zapret.sh
mkdir -p "$PADAVAN_BUILD_PATH/trunk/user/nfqws/zapret"
cp -a zapret-v72.2/blockcheck.sh zapret-v72.2/ipset zapret-v72.2/scripts "$PADAVAN_BUILD_PATH/trunk/user/nfqws/zapret/" 2>/dev/null || true
wget -qO "$PADAVAN_BUILD_PATH/trunk/user/nfqws/zapret/zapret.sh" https://raw.githubusercontent.com/bol-van/zapret/main/zapret.sh
chmod +x "$PADAVAN_BUILD_PATH/trunk/user/nfqws/zapret/zapret.sh"

# Правильный Makefile с табуляцией и версией v72.2
cat > "$PADAVAN_BUILD_PATH/trunk/user/nfqws/Makefile" <<'EOF'
ifeq ($(CONFIG_FIRMWARE_INCLUDE_NFQWS),y)

TARGETS += nfqws
NFQWS_OBJ = nfqws.o ws.o opt.o util.o ipq.o list.o

$(obj)/nfqws: $(addprefix $(obj)/,$(NFQWS_OBJ))
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) -lnetfilter_queue -lnfnetlink -lmnl

romfs:
	$(ROMFSINST) $(obj)/nfqws /usr/sbin/nfqws
	$(ROMFSINST) -s /usr/sbin/nfqws /tmp/zapret

endif

CFLAGS += -DNFQWS_VERSION=\"v72.2\"
EOF

echo "TL-WR841N v13 → zapret v72.2 + актуальный zapret.sh готово"
