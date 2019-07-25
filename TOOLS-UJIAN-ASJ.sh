$ip1="192"
$ip2="168"
$ip3="16"
$ip4="5"

banner(){
clear
echo
sleep 0.5
echo ' ______   ______ _____  _    ____    ______   ______ _____ _____ __  __ '
sleep 0.3
echo '/ ___\ \ / / ___|_   _|/ \  |  _ \  / ___\ \ / / ___|_   _| ____|  \/  |'
sleep 0.3
echo '\___ \\ V /\___ \ | | / _ \ | |_) | \___ \\ V /\___ \ | | |  _| | |\/| |'
sleep 0.3
echo ' ___) || |  ___) || |/ ___ \|  _ <   ___) || |  ___) || | | |___| |  | |'
sleep 0.3
echo '|____/ |_| |____/ |_/_/   \_\_| \_\ |____/ |_| |____/ |_| |_____|_|  |_|'
sleep 0.3
echo
sleep 0.3
echo " Author : strongpapazola "
echo
sleep 0.5
echo
echo "[*] Memulai Tools...!"
sleep 0.3
echo "[*] Mengisialisai System...!"
sleep 0.3
echo "[*] System yang di setujui '#1 SMP Debian 3.2.65-1 i686 GNU/Linux' ...!"
sleep 0.3
echo
echo "1. Atur IP"
echo "2. Install Packet"
echo "3. Atur DHCP"
echo "4. Atur SSH"
echo "5. Atur FTP"
echo "6. Atur Samba"
echo "7. Atur Apache2"
echo "8. Atur Bind9"
echo
read -p "Masukan : " pilih
if [ $pilih = "1" ];then
	alamatip
elif [ $pilih = "2" ];then
	paketinstaller
elif [ $pilih = "3" ];then
	dhcpsetting
elif [ $pilih = "4" ];then
	sshsetting
elif [ $pilih = "5" ];then
	ftpsetting
elif [ $pilih = "6" ];then
	smbsetting
elif [ $pilih = "7" ];then
	apachesetting
elif [ $pilih = "8" ];then
	bindsetting
else
	echo Abort.
	exit
fi
}

alamatip(){
clear
echo "[*] Mengaktifkan Aturan IP...!"
echo "[*] Mengaktifkan Interfaces eth0...!"
ifconfig eth0 up
read -p "Masukan IP (Pisahkan Dengan Spasi): " ip1 ip2 ip3 ip4
read -p "[Enter]" ok
clear
echo "========================================="
echo " IP        : "$ip1.$ip2.$ip3.$ip4
echo " Netmask   : 255.255.255.0"
echo " Network   : "$ip1.$ip2.$ip3."0"
echo " Broadcast : "$ip1.$ip2.$ip3."255"
echo " Gateway   : "$ip1.$ip2.$ip3.$ip4
echo "========================================="
read -p "Apakah Sudah Benar...? [y/n] " ok
if [ $ok = "y" ];then
	clear
	echo "[*] Memanipulasi /etc/network/interfaces...!"
	cp /etc/network/interfaces /etc/network/interfaces-def
	sed -i 's/allow-hotplug eth0//g' /etc/network/interfaces
	sed -i 's/iface eth0 inet dhcp//g' /etc/network/interfaces
	echo "auto eth0" >> /etc/network/interfaces
	echo "iface eth0 inet static" >> /etc/network/interfaces
	echo "        address $ip1.$ip2.$ip3.$ip4" >> /etc/network/interfaces
	echo "        netmask 255.255.255.0" >> /etc/network/interfaces
	echo "        network $ip1.$ip2.$ip3.0" >> /etc/network/interfaces
	echo "        broadcast $ip1.$ip2.$ip3.255" >> /etc/network/interfaces
	echo "        gateway $ip1.$ip2.$ip3.$ip4" >> /etc/network/interfaces
	echo "nameserver $ip1.$ip2.$ip3.$ip4" > /etc/resolf.conf
	clear
	echo "[*] Menampilkan Settingan...!"
	echo "======================================"
	cat /etc/network/interfaces
	echo "======================================"
	read -p "[Enter Untuk Melanjutkan]" ok
	/etc/init.d/networking restart
	/etc/init.d/networking restart
	banner
else
	echo Abort.
	exit
fi
}

paketinstaller(){
clear
echo "[*] Memulai Instalasi Packet...!"
echo "========================"
echo "Masukan DVD 1 Debian...!"
read -p "[Enter Jika Sudah]" ok
apt-cdrom ident
apt-cdrom ident
apt-cdrom add
apt-cdrom add
read -p "[Silahkan Cek Error Pemasukan DVD]" ok
apt-get install openssh-server -y
read -p "[Silahkan Cek Paket Openssh-server]" ok
apt-get install samba -y
read -p "[Silahkan Cek Paket Samba]" ok
apt-get install apache2 -y
read -p "[Silahkan Cek Paket Apache2]" ok
apt-get install bind9 -y
read -p "[Silahkan Cek Paket Bind9]" ok
apt-get install zip -y
read -p "[Silahkan Cek Paket ZIP]" ok
clear
echo "========================"
echo "Masukan DVD 2 Debian...!"
read -p "[Enter Jika Sudah]" ok
apt-cdrom ident
apt-cdrom ident
apt-cdrom add
apt-cdrom add
read -p "[Silahkan Cek Error Pemasukan DVD]" ok
apt-get install isc-dhcp-server -y
read -p "[Silahkan Cek Paket DHCP]" ok
apt-get install proftpd -y
read -p "[Silahkan Cek Paket FTP]" ok
banner
}

dhcpsetting(){
clear
echo "[*] DHCP Setting...!"
read -p "Dari Host : " ipdhcp1
read -p "Sampai Host : " ipdhcp2
read -p "[Enter]" ok
echo "[*] Memanipulasi /etc/dhcp/dhcpd.conf...!"
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd-def.conf
sed -i "s/#subnet 10.5.5.0 netmask 255.255.255.224 {/subnet $ip1.$ip2.$ip3.0 netmask 255.255.255.0 {/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  range 10.5.5.26 10.5.5.30;/  range $ip1.$ip2.$ip3.$ipdhcp1 $ip1.$ip2.$ip3.$ipdhcp2;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  option domain-name-servers ns1.internal.example.org;/  option domain-name-servers $ip1.$ip2.$ip3.$ip4;/g" /etc/dhcp/dhcpd.conf
sed -i 's/#  option domain-name "internal.example.org";/  option domain-name "example.org";/g' /etc/dhcp/dhcpd.conf
sed -i "s/#  option routers 10.5.5.1;/  option routers $ip1.$ip2.$ip3.$ip4;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  option broadcast-address 10.5.5.31;/  option broadcast-address $ip1.$ip2.$ip3.255;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  default-lease-time 600;/  default-lease-time 600;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  max-lease-time 7200;/  max-lease-time 7200;/g" /etc/dhcp/dhcpd.conf
sed -i 's/INTERFACES=""/INTERFACES="eth0"/g' /etc/default/isc-dhcp-server
sed -i '58c\}' /etc/dhcp/dhcpd.conf
clear
read -p "Cek Configurasi [Enter]" ok
nano /etc/dhcp/dhcpd.conf
read -p "Beres ? [Enter]" ok
/etc/init.d/isc-dhcp-server restart
/etc/init.d/isc-dhcp-server restart
banner
}

sshsetting(){
clear
echo "[*] SSH Setting...!"
sed -i 's/#   Port 22/   Port 22/g' /etc/ssh/ssh_config
/etc/init.d/ssh restart
/etc/init.d/ssh restart
banner
}

ftpsetting(){
clear
echo "[*] Proftpd Setting...!"
read -p "Masukan Username : " uname
mkdir /home/$uname
sed -i 's/ServerName			"Debian"/ServerName			"example.org"/g' /etc/proftpd/proftpd.conf
sed -i "s/# DefaultRoot                   ~/DefaultRoot                   \/home\/$uname/g" /etc/proftpd/proftpd.conf
read -p "Ubah DefaultRoot Configurasi ke /home/$uname [Enter]" ok
nano /etc/proftpd/proftpd.conf
read -p "Beres ? [Enter]" ok
useradd $uname
passwd $uname
usermod -d /home/$uname/ $uname
/etc/init.d/proftpd restart
/etc/init.d/proftpd restart
banner
}


smbsetting(){
clear
echo "[*] Samba Setting...!"
read -p "Buat Direktori Dengan Nama : " dirsmb
mkdir -p /home/$dirsmb
chmod -R 777 /home/$dirsmb
read -p "Jalankan Useradd?[Y/n]" confirm
if [ $confirm = "y" ];then
	read -p "Nama User : " usersmb
	useradd $usersmb
	smbpasswd -a $usersmb
	confsmb="/etc/samba/smb.conf"
	echo "[$dirsmb]" >> $confsmb
	echo "path = /home/$dirsmb" >> $confsmb
	echo "valid user = $usersmb" >> $confsmb
	echo "browseable = yes" >> $confsmb
	echo "writeable = yes" >> $confsmb
	service samba restart
	service samba restart
else
	echo "Abort!"
	sleep 2
	banner
fi
banner
}

apachesetting(){
clear
echo "[*] Apache2 Setting...!"
read -p "Masukan Nama Lengkap : " namaweb
read -p "Masukan Kelas : " kelasweb
cp /var/www/index.html /var/www/index.html-default
echo "<h1>Nama : $namaweb</h1>" > /var/www/index.html
echo "<h1>Kelas : $kelasweb</h1>" >> /var/www/index.html
chmod -R 777 /var/www/
echo "[*] Sedang Merestart Service"
service apache2 restart
service apache2 restart
echo "[*] Service Telah Di Restart...!"
read -p "[Pause]" ok
sleep 1
banner
}

bindsetting(){
clear
echo "[*] Bind9 Setting...!"
read -p "Masukan Domain : " domaindns
read -p "Masukan SubDomain : " subdomaindns
read -p "Change /etc/bind/db.local To : " dnslocal
read -p "Change /etc/bind/db.127 To : " dns127
read -p "Masukan IP (Pisahkan Dengan spasi) : " ipdns1 ipdns2 ipdns3 ipdns4
echo ===========================================
echo "Domain : $subdomaindns.$domaindns"
echo "db.local To : $dnslocal"
echo "db.127 To : $dns127"
echo "Alamat IP : $ipdns1.$ipdns2.$ipdns3.$ipdns4"
echo ===========================================
read -p "[Enter]" ok
#zip -r /etc/bind.zip /etc/bind/
#unzip /etc/bind.zip -d /etc/bind/
dira="/etc/bind/named.conf.local"
dirb="/etc/bind/$dnslocal"
dirc="/etc/bind/$dns127"
echo "[*] Configure named.conf.local...!"
echo "zone '$domaindns' {" >> $dira
echo "type master;" >> $dira
echo "file '/etc/bind/$dnslocal';" >> $dira
echo "};" >> $dira
echo " ">> $dira
echo "zone '$ipdns3.$ipdns2.$ipdns1.in-addr.arpa' {" >> $dira
echo "type master;" >> $dira
echo "file '/etc/bind/$dns127';" >> $dira
echo "};" >> $dira
sed -i "s/'/*/g" $dira
sed -i 's/*/"/g' $dira
sleep 0.5

echo "[*] Configure $dnslocal ...!"
cp /etc/bind/db.local /etc/bind/$dnslocal
sed -i "5c\@ IN SOA $subdomaindns.$domaindns. root.localhost. (" $dirb
sed -i "12c\@ IN NS $subdomaindns.$domaindns." $dirb
sed -i "13c\ $subdomaindns IN A $ipdns1.$ipdns2.$ipdns3.$ipdns4" $dirb
sed -i "s/ $subdomaindns IN A $ipdns1.$ipdns2.$ipdns3.$ipdns4/$subdomaindns IN A $ipdns1.$ipdns2.$ipdns3.$ipdns4/g" $dirb
sed -i "14c\server IN A $ipdns1.$ipdns2.$ipdns3.$ipdns4" $dirb
sleep 0.5

echo "[*] Configure $dns127 ...!"
cp /etc/bind/db.127 /etc/bind/$dns127
sed -i "5c\@ IN SOA $subdomaindns.$domaindns. root.localhost. (" $dirc
sed -i "12c\@ IN NS $subdomaindns." $dirc
sed -i "13c\ $ipdns4 IN PTR $subdomaindns.$domaindns." $dirc
sed -i "s/ $ipdns4 IN PTR $subdomaindns.$domaindns./$ipdns4 IN PTR $subdomaindns.$domaindns./g" $dirc
sed -i "14c\ $ipdns4 IN PTR server.$domaindns" $dirc
sed -i "s/ $ipdns4 IN PTR server.$domaindns/$ipdns4 IN PTR server.$domaindns/g" $dirc
sleep 0.5

echo "[*] Configure resolv.conf ...!"
echo "nameserver $ipdns1.$ipdns2.$ipdns3.$ipdns4" > /etc/resolv.conf
echo "domain $domaindns" >> /etc/resolv.conf
echo "search $domaindns" >> /etc/resolv.conf
sleep 0.5
read -p "[Enter]" ok
banner
}

banner

