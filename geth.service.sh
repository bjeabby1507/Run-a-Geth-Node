[Unit]
Description=Go Ethereum Client - Geth (Goerli)
After=network.target
Wants=network.target

[Service]
#User=goeth
#Group=goeth
Type=simple
Restart=always
RestartSec=5
TimeoutStopSec=180
ExecStart=geth \
    --goerli \
    --http \
    --http.api eth,net,web3,txpool,engine,admin \
    --datadir /home/bjeab/.ethereum/goerli/ \
    --metrics \
    --metrics.expensive \
    --pprof \
    --authrpc.jwtsecret=/home/bjeab/.ethereum/goerli/consensus/lighthouse/jwttoken

[Install]
WantedBy=default.target