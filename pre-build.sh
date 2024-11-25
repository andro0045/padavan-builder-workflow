cp padavan_logo.png padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp loading_bg.png padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp itoggle.png padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp glyphicons-halflings-white.png padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp glyphicons-halflings.png padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp dark-bg.jpg padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp arrow-right.png padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp ajax-loader.gif padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/img
cp engage.itoggle.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css
cp main.css padavan-ng/trunk/user/www/n56u_ribbon_fixed/bootstrap/css

### Смена часового пояса
ln -snf /usr/share/zoneinfo/Europe/Kyiv /etc/localtime
apt update
DEBIAN_FRONTEND=noninteractive apt install tzdata -y
