# ASJ_Tools-lite

Fitur :
1. DHCP Server
2. SSH Server
3. FTP Server

Di Uji :
- Debian 7.8 (intel) offline

Instalasi (Root Access) :
1. apt update && apt upgrade
2. apt install git
3. git clone https://github.com/strongpapazola/ASJ_Tools-lite/
4. chmod -R +x ASJ_Tools-lite
5. cd ASJ_Tools-lite
6. ./TOOLS-UJIAN-ASJ.sh

Penggunaan :
1. Jalankan tools
2. Atur ip
3. Tambahkan nameserver ip pada resolv.conf jika error
4. Atur DVD 1
5. Instal ssh
6. Reboot
7. Atur DVD 2
8. Install dhcp dan proftpd
9. Hapus pagar pada konfigurasi dhcpd.conf
10. Tambahkan direktori di configurasi proftpd.conf
