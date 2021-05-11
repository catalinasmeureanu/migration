#!/bin/bash -x
set -aex

pkill -TERM  -F /tmp/vault.pid || true
pkill -TERM  -F /tmp/vault2.pid || true
pkill -TERM  -F /tmp/consul.pid || true

consul agent -dev -pid-file=/tmp/consul.pid -log-level=TRACE 2>consul.log 1>consul.log &
sleep 1

cat > vault-server.hcl <<EOF
ui = true
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
}
storage "consul" {
  address = "127.0.0.1:8500"
  path    = "consul_data"
}
api_addr="http://127.0.0.1:8200"
cluster_addr="http://127.0.0.1:8201"
log_level="Trace"
pid_file="/tmp/vault.pid"
EOF

vault server -config=vault-server.hcl > vault.log 2>&1 &

sleep 1

export VAULT_ADDR='http://127.0.0.1:8200'

initResult=$(vault operator init -format=json -key-shares=1 -key-threshold=1)

echo $initResult  > data.json

unsealKey1=$(echo -n $initResult | jq -r '.unseal_keys_b64[0]')
echo $unsealKey1

rootToken1=$(echo -n $initResult | jq -r '.root_token')
echo $rootToken1 > rootToken

echo $(cat data.json | jq -r '.unseal_keys_b64[0]')| xargs -I % vault operator unseal %

export VAULT_TOKEN=${rootToken1}

vault secrets enable kv 
vault kv put kv/catalina my-value=secret
vault kv get kv/catalina

cat > migrate.hcl <<EOF
storage_source "consul" {
address = "127.0.0.1:8500"
path    = "consul_data"
}

storage_destination "raft" {
  path = "./data"
  node_id = "node_1"
}
cluster_addr="http://127.0.0.1:8201"
EOF

mkdir data
