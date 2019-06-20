alamatip1="192.168.16.1"
alamatip2="192.168.16.0"
alamatip3="192.168.16.255"

banner(){
clear
echo
sleep 1
echo " ______   ______ _____  _    ____    ______   ______ _____ _____ __  __ "
echo "/ ___\ \ / / ___|_   _|/ \  |  _ \  / ___\ \ / / ___|_   _| ____|  \/  |"
echo "\___ \\ V /\___ \ | | / _ \ | |_) | \___ \\ V /\___ \ | | |  _| | |\/| |"
echo " ___) || |  ___) || |/ ___ \|  _ <   ___) || |  ___) || | | |___| |  | |"
echo "|____/ |_| |____/ |_/_/   \_\_| \_\ |____/ |_| |____/ |_| |_____|_|  |_|"
echo
echo " Author : strongpapazola "
echo                                                                        
sleep 2
echo
echo "[*] Memulai Tools...!"
sleep 2
echo "1. Atur IP"
echo "2. Install Packet"
echo "3. Atur DHCP"
echo "4. Atur SSH"
echo "5. Atur FTP"
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
read -p "Masukan IP : " alamatip1
read -p "Masukan Network : " alamatip2
read -p "Masukan Broadcast : " alamatip3
clear
echo "========================================="
echo " IP        : "$alamatip1
echo " Netmask   : 255.255.255.0"
echo " Network   : "$alamatip2
echo " Broadcast : "$alamatip3
echo " Gateway   : "$alamatip1
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
	echo "        address $alamatip1" >> /etc/network/interfaces
	echo "        netmask 255.255.255.0" >> /etc/network/interfaces
	echo "        network $alamatip2" >> /etc/network/interfaces
	echo "        broadcast $alamatip3" >> /etc/network/interfaces
	echo "        gateway $alamatip1" >> /etc/network/interfaces
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
read -p "[Silahkan Cek Error]" ok
apt-get install openssh-server -y
read -p "[Silahkan Cek Paket]" ok
clear
echo "========================"
echo "Masukan DVD 2 Debian...!"
read -p "[Enter Jika Sudah]" ok
apt-cdrom ident
apt-cdrom ident
apt-cdrom add
apt-cdrom add
read -p "[Silahkan Cek Error]" ok
apt-get install isc-dhcp-server -y
apt-get install proftpd -y
read -p "[Silahkan Cek Paket]" ok
banner
}

dhcpsetting(){
clear
echo "[*] DHCP Setting...!"
read -p "Dari IP : " ipdhcp1
read -p "Sampai IP : " ipdhcp2
echo "[*] Memanipulasi /etc/dhcp/dhcpd.conf...!"
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd-def.conf
sed -i "s/#subnet 10.5.5.0 netmask 255.255.255.224 {/subnet $alamatip2 netmask 255.255.255.0 {/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  range 10.5.5.26 10.5.5.30;/  range $ipdhcp1 $ipdhcp2;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  option domain-name-servers ns1.internal.example.org;/  option domain-name-servers $alamatip1;/g" /etc/dhcp/dhcpd.conf
sed -i 's/#  option domain-name "internal.example.org";/  option domain-name "example.org";/g' /etc/dhcp/dhcpd.conf
sed -i "s/#  option routers 10.5.5.1;/  option routers $alamatip1;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  option broadcast-address 10.5.5.31;/  option broadcast-address $alamatip3;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  default-lease-time 600;/  default-lease-time 600;/g" /etc/dhcp/dhcpd.conf
sed -i "s/#  max-lease-time 7200;/  max-lease-time 7200;/g" /etc/dhcp/dhcpd.conf
sed -i 's/INTERFACES=""/INTERFACES="eth0"/g' /etc/default/isc-dhcp-server
clear
read -p "Hapus Pagar Pada Configurasi [Enter]" ok
nano /etc/dhcp/dhcpd.conf
read -p "Beres ? [Enter]" ok
/etc/init.d/isc-dhcp-server restart
/etc/init.d/isc-dhcp-server restart
banner
}

sshsetting(){
echo "[*] SSH Setting...!"
sed -i 's/#   Port 22/   Port 22/g' /etc/ssh/ssh_config
/etc/init.d/ssh restart
/etc/init.d/ssh restart
banner
}

ftpsetting(){
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

banner

