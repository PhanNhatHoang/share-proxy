#!/bin/sh
random() {
	tr </dev/urandom -dc A-Za-z0-9 | head -c5
	echo
}
random_number(){
  tr </dev/urandom -dc 1-9 | head -c2
  echo
}
array=(1 2 3 4 5 6 7 8 9 0 a b c d e f)
main_interface=$(ip route get 8.8.8.8 | awk -- '{printf $5}')

gen64() {
}
install_3proxy() {
}

gen_3proxy() {
}

gen_proxy_file_for_user() {
}

upload_proxy() {
}
gen_data() {
}

gen_iptables() {
}

gen_ifconfig() {
}
echo "installing apps"


echo "nhap ipv6 range "
read IPV6_RANGE

# error
yum -y update >/dev/null
yum -y install wget >/dev/null
yum -y install gcc net-tools bsdtar zip make >/dev/null

install_3proxy

echo "working folder = /home/proxy-installer"
WORKDIR="/home/proxy-installer"
WORKDATA="${WORKDIR}/data.txt"
mkdir $WORKDIR && cd $_




echo "da tao ipv6"

IP4=$(curl -4 -s icanhazip.com)
IP6=$(echo "${IPV6_RANGE}" | cut -f1-4 -d':')
#SUBNET=$(echo "${IPV6_RANGE}" | cut -f6-7 -d':')

echo "Internal ip = ${IP4}. Exteranl sub for ip6 = ${IP6}"


COUNT=1000

FIRST_PORT=10000
LAST_PORT=$(($FIRST_PORT + $COUNT - 1))

gen_data >$WORKDIR/data.txt

gen_ifconfig >$WORKDIR/boot_ifconfig.sh
echo NM_CONTROLLED="no" >> /etc/sysconfig/network-scripts/ifcfg-${main_interface}
chmod +x $WORKDIR/boot_*.sh /etc/rc.local

gen_3proxy >/usr/local/etc/3proxy/3proxy.cfg

cat >>/etc/rc.local <<EOF
bash ${WORKDIR}/boot_ifconfig.sh
ulimit -n 65535
/usr/local/etc/3proxy/bin/3proxy /usr/local/etc/3proxy/3proxy.cfg &
EOF

bash /etc/rc.local

gen_proxy_file_for_user

upload_proxy


#bash ${WORKDIR}/boot_ifconfig.sh
