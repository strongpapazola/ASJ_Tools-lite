s="service"
t="restart"

$s isc-dhcp-server $t
$s ssh $t
$s proftpd $t
$s samba $t
$s apache2 $t
$s bind9 $t
$s postfix $t
$s courier-imap $t
