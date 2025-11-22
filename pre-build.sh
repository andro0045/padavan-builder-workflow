# Копирование изображений в директорию img
cp padavan_logo.png loading_bg.png itoggle.png glyphicons-halflings-white.png \
   glyphicons-halflings.png dark-bg.jpg arrow-right.png ajax-loader.gif \
   padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img/

# Копирование CSS файлов в директорию css
cp engage.itoggle.css main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css/



set -e

cd /tmp
rm -rf zapret-v72.2*
wget -q https://github.com/bol-van/zapret/archive/refs/tags/v72.2.tar.gz
tar -xzf v72.2.tar.gz
cd zapret-v72.2

rm -rf "$PADAVAN_BUILD_PATH/trunk/user/nfqws"/*
cp -a nfq/* shared/* "$PADAVAN_BUILD_PATH/trunk/user/nfqws/"

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

echo "zapret → v72.2 готов"
