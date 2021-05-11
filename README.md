This repo can be used to test the backend storage migration from Consul to Raft.

# How to use the script

`$ chmod +x migration.sh`

`$./migration.sh`

- perform the migration:
 
`$ vault operator migrate -config=migrate.hcl`

Example Output:

```

2021-05-11T15:55:11.808+0200 [WARN]  appending trailing forward slash to path
2021-05-11T15:55:12.111+0200 [INFO]  initial configuration: index=1 servers="[{Suffrage:Voter ID:node_1 Address:127.0.0.1:8201}]"
2021-05-11T15:55:12.111+0200 [INFO]  entering follower state: follower="Node at node_1 [Follower]" leader=
2021-05-11T15:55:18.642+0200 [WARN]  heartbeat timeout reached, starting election: last-leader=
2021-05-11T15:55:18.642+0200 [INFO]  entering candidate state: node="Node at node_1 [Candidate]" term=2
2021-05-11T15:55:18.773+0200 [INFO]  election won: tally=1
2021-05-11T15:55:18.773+0200 [INFO]  entering leader state: leader="Node at node_1 [Leader]"
2021-05-11T15:55:18.959+0200 [INFO]  copied key: path=core/audit
2021-05-11T15:55:19.046+0200 [INFO]  copied key: path=core/auth
2021-05-11T15:55:19.135+0200 [INFO]  copied key: path=core/cluster/feature-flags
2021-05-11T15:55:19.222+0200 [INFO]  copied key: path=core/cluster/local/info
2021-05-11T15:55:19.347+0200 [INFO]  copied key: path=core/hsm/barrier-unseal-keys
2021-05-11T15:55:19.438+0200 [INFO]  copied key: path=core/keyring
2021-05-11T15:55:19.548+0200 [INFO]  copied key: path=core/leader/60483e15-b3b6-33e9-8069-3b3844272ce6
2021-05-11T15:55:19.656+0200 [INFO]  copied key: path=core/local-audit
2021-05-11T15:55:19.745+0200 [INFO]  copied key: path=core/local-auth
2021-05-11T15:55:19.833+0200 [INFO]  copied key: path=core/local-mounts
2021-05-11T15:55:19.921+0200 [INFO]  copied key: path=core/master
2021-05-11T15:55:20.007+0200 [INFO]  copied key: path=core/mounts
2021-05-11T15:55:20.094+0200 [INFO]  copied key: path=core/seal-config
2021-05-11T15:55:20.182+0200 [INFO]  copied key: path=core/shamir-kek
2021-05-11T15:55:20.271+0200 [INFO]  copied key: path=core/wrapping/jwtkey
2021-05-11T15:55:20.357+0200 [INFO]  copied key: path=logical/6e101feb-9fc0-403f-e4a6-4d3e3e29915f/catalina
2021-05-11T15:55:20.447+0200 [INFO]  copied key: path=logical/d7640d9b-5a68-182e-20b2-eb8a225fe97c/casesensitivity
2021-05-11T15:55:20.536+0200 [INFO]  copied key: path=sys/counters/requests/2021/05
2021-05-11T15:55:20.625+0200 [INFO]  copied key: path=sys/policy/control-group
2021-05-11T15:55:20.712+0200 [INFO]  copied key: path=sys/policy/default
2021-05-11T15:55:20.800+0200 [INFO]  copied key: path=sys/policy/response-wrapping
2021-05-11T15:55:20.888+0200 [INFO]  copied key: path=sys/token/accessor/b5fdbadd999c786c840d8cea76fdb465f1635894
2021-05-11T15:55:20.976+0200 [INFO]  copied key: path=sys/token/id/hac32abea320fd87ad32045d4ef58946c02fa2a8471e07535e612b42ad3511eb4
2021-05-11T15:55:21.062+0200 [INFO]  copied key: path=sys/token/salt
Success! All of the keys have been migrated.

```

- run script to start and unseal the vault server with raft:
`$ chmod postmigration.sh`
`$./postmigration.sh`
