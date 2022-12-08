cat << EOF > /etc/openvpn/server.conf
mode server 
tls-server 
port 1194
proto tcp 
duplicate-cn
dev tun
keepalive 1 180
resolv-retry infinite 
max-clients 9000
ca /etc/openvpn/keys/ca.crt 
cert /etc/openvpn/keys/server.crt 
key /etc/openvpn/keys/server.key 
dh /etc/openvpn/keys/dh2048.pem 
client-cert-not-required 
username-as-common-name 
auth-user-pass-verify /etc/openvpn/script/login.sh via-env
tmp-dir "/etc/openvpn/" # 
server 172.20.0.0 255.255.0.0
push "redirect-gateway def1" 
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "sndbuf 393216"
push "rcvbuf 393216"
tun-mtu 1400 
mssfix 1360
verb 3
script-security 3
cipher AES-128-CBC
tcp-nodelay
up /etc/openvpn/update-resolv-conf                                                                                      
down /etc/openvpn/update-resolv-conf
EOF
service openvpn restart
echo "upgrade complete"
