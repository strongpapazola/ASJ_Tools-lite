# ASJ_Tools-lite

*Fitur :*
1. DHCP Server
2. SSH Server
3. FTP Server
4. File Server
5. Web Server
6. DNS Server
7. Mail Server (Manual Input)

*Di Uji :*
- Debian 7.8 (intel) offline

*Instalasi Online (Root Access) :*
1. apt update && apt upgrade
2. apt install git
3. git clone https://github.com/strongpapazola/ASJ_Tools-lite/
4. chmod -R +x ASJ_Tools-lite
5. cd ASJ_Tools-lite
6. ./TOOLS-UJIAN-ASJ.sh

*Instalasi Offline (Root Access) :*
1. Download https://github.com/strongpapazola/asj-tools-exam/archive/master.zip
2. Ekstrak dan Masukan asj-tools-exam.sh ke flashdisk
3. Masukan flashdisk Ke Virtual Box dan Mount flashdisk
4. cp /dev/sdb1/asj-tools-exam.sh /mnt/
5. cd /mnt
6. chmod +x asj-tools-exam.sh
7. Konfigurasi IP (nano asj-tools-exam.sh)
8. ./asj-tools-exam.sh
