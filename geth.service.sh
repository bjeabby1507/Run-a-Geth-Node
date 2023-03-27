[Unit]
Description=Go Ethereum Client - Geth (Goerli)
After=network.target
Wants=network.target

[Service]
Type=simple
Restart=always
RestartSec=5
TimeoutStopSec=180
ExecStart=/usr/bin/geth \
    --goerli \
    --http \
    --http.api eth,net,web3,txpool,engine,admin \
    --datadir /home/bjeab/.ethereum/goerli/ \
    --metrics \
    --metrics.expensive \
    --pprof \
    --authrpc.jwtsecret=/home/bjeab/.ethereum/goerli/consensus/lighthouse/jwttoken
#ExecStart=/bin/bash /bin/bash /home/bjeab/run/geth.sh

[Install]
WantedBy=default.target