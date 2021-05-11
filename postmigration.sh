cat > config-raft.hcl<<EOF

storage "raft" {
  path = "./data"
  node_id = "node_1"
}

listener "tcp" {
  address = "0.0.0.0:8210"
  tls_disable = "true"
}

api_addr = "http://127.0.0.1:8210"
cluster_addr = "http://127.0.0.1:8211"
disable_mlock = true
ui=true
pid_file="/tmp/vault2.pid"
EOF

vault server -config=config-raft.hcl  > vault2.log 2>&1 &

export VAULT_ADDR='http://127.0.0.1:8210'

echo $(cat data.json | jq -r '.unseal_keys_b64[0]')| xargs -I % vault operator unseal %
vault login $(cat rootToken)
vault kv get kv/catalina
