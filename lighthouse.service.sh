[Unit]
Description=Lighthouse Ethereum Client Beacon Node (Prater)
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
Restart=always
RestartSec=5
ExecStart=/home/bjeab/.ethereum/goerli/consensus/lighthouse/lighthouse bn \
    --network goerli \
    --datadir /home/bjeab/.ethereum/goerli/ \
    --http \
    --execution-endpoint http://localhost:8551 \
    --checkpoint-sync-url https://checkpoint-sync.goerli.ethpandaops.io \
    --execution-jwt /home/bjeab/.ethereum/goerli/consensus/lighthouse/jwttoken \
    --metrics \
    --validator-monitor-auto \
    --disable-deposit-contract-sync
#ExecStart=/bin/bash /bin/bash /home/bjeab/run/lighthouse.sh

[Install]
WantedBy=multi-user.target