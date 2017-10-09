#!/bin/bash


eth="eth0"
for nw in {4..1}
do
  if [[ $(ip route | grep "eth$nw") ]]; then
    eth="eth$nw"
    break
  fi
done
echo "Adapter: $eth"

bind_addr=$(ip route | grep "$eth" | grep src | cut -d ' ' -f 6)
echo "Bind address: $bind_addr"

config="/consul/config/consul.json"
sed -i "s/\$bind_addr/$bind_addr/g" $config
if [[ $ENCRYPT ]]
then
  escaped_encrypt=$(echo $ENCRYPT | sed 's#/#\\/#g')
  sed -i "s/\$encrypt/$escaped_encrypt/g" $config
  echo "Encrypt key: $ENCRYPT"
else
  sed -i '/  "encrypt": "\$encrypt",/d' $config
  echo "No encrypt key"
fi

for ip in $(echo $bind_addr | cut -d . -f -3).{2..20}
do
  if nc -zv $ip 8301 2>&1 | grep -q 'open'; then
    consul=$ip
	echo "Found consul server: $consul"
    break
  fi
done

echo "Starting consul..."
if [[ $consul ]]
then
  echo "Join consul to $consul"
  consul.sh agent -ui -server -join $consul
else
  echo "New consul cluster"
  consul.sh agent -ui -server -bootstrap-expect 3
fi