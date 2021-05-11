This repo can be used to test the backend storage migration from Consul to Raft.

# How to use the script

-run script:

`$./migration.sh`

- perform the migration:
 
`$ vault operator migrate -config=migrate.hcl`

- run script to start and unseal the vault server with raft:

`$./postmigration.sh`
