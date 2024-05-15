## xray4magisk
### Inbounds needs to add a sub-item specifically designed to listen to port 53.
### Use NAT chain to forward port 53 to the listening port of DNS.
executeDnsRedirectRules() {\
  iptables -t nat -N DNS_EXTERNAL\
  iptables -t nat -N DNS_LOCAL\
  iptables -t nat -A DNS_EXTERNAL -p udp -m udp --dport 53 -j REDIRECT --to-port 65534\
  iptables -t nat -A DNS_EXTERNAL -p tcp -m tcp --dport 53 -j REDIRECT --to-port 65534\
  iptables -t nat -A DNS_EXTERNAL -d 198.18.0.1/16 -p icmp -j DNAT --to-destination 127.0.0.1\
  iptables -t nat -A DNS_LOCAL -m owner --gid-owner ${gid} -j RETURN\
  iptables -t nat -A DNS_LOCAL -p udp -m udp --dport 53 -j REDIRECT --to-port 65534\
  iptables -t nat -A DNS_LOCAL -p tcp -m tcp --dport 53 -j REDIRECT --to-port 65534\
  iptables -t nat -A DNS_LOCAL -d 198.18.0.1/16 -p icmp -j DNAT --to-destination 127.0.0.1\
  iptables -t nat -I PREROUTING -j DNS_EXTERNAL\
  iptables -t nat -I OUTPUT -j DNS_LOCAL\
  iptables -t nat -L -nv > ${0%/*}/iptables_nat_rules.list\
}\


