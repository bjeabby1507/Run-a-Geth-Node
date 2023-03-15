# Run-a-Geth-Node

Guide to setup your machine to join the Goerli/Prater merge testnet

## Tech stack

- Ubuntu 20.04

## Prerequisites

### Update the Software

```bash
# Install prerequisites commonly available.
sudo apt -y install software-properties-common wget curl
# Add the Ethereum PPA and install the Geth package.
sudo sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum
```

## Installing Geth

### Execution node

[See : Installing Geth](https://geth.ethereum.org/docs/getting-started)

```bash
sudo apt-get update
sudo apt-get install ethereum
#Check installation
geth –-help
```

<!-- ### Security

[See : Networking security](https://geth.ethereum.org/docs/fundamentals/security)

```bash
sudo apt install ufw
sudo su
ufw default deny incoming
ufw default allow outgoing
ufw allow 30303  comment 'allow P2P traffic goerli'
ufw allow 8551  comment 'execution node'
ufw enable
ufw status
```

Open ports, allow traffic on: SSH(22) ; 8545(HTTP based JSON RPC API) 8546(WebSocket based JSON RPC API) ; 30303(The P2P protocol running the network) ; 30304(The P2P protocol's new peer discovery overlay) ; http ; https ... -->

### Beacon node : Connecting to Consensus Clients

"Geth is an execution client, Historically, an execution client alone was enough to run a full Ethereum node. However, ever since Ethereum swapped from proof-of-work (PoW) to proof-of-stake (PoS) based consensus, Geth has needed to be coupled to another piece of software called a "consensus client"."

[See : Connecting to Consensus Clients](https://geth.ethereum.org/docs/getting-started/consensus-clients)

#### Install

Client : [Lighthouse](https://lighthouse-book.sigmaprime.io/)

```bash
#datadir
cd ~/.ethereum/goerli
mkdir consensus
cd consensus
mkdir lighthouse && cd lighthouse
# Install lighthouse
wget https://github.com/sigp/lighthouse/releases/download/v3.5.1/lighthouse-v3.5.1-x86_64-unknown-linux-gnu.tar.gz
tar xvf lighthouse-v3.5.1-x86_64-unknown-linux-gnu.tar.gz
rm lighthouse-v3.5.1-x86_64-unknown-linux-gnu.tar.gz
#Test the binary
./lighthouse --version
# Generate JWT token file
openssl rand -hex 32 | tr -d "\n" > jwttoken
sudo chmod +r jwttoken
```

### Configuring Geth

[See : Configuring Geth](https://geth.ethereum.org/docs/getting-started/consensus-clients)

#### Users

Create a 'goeth' user, assign the proper permissions, and where the geth will run

```bash
sudo useradd --no-create-home --shell /bin/false goeth
```

Add admin to the 'goeth' group with read-only privileges

```bash
sudo adduser admin goeth
```

```bash
sudo reboot
```

Create a bitcoin directory

The owner will be 'bitcoin'

```bash
sudo chown -R bitcoin:bitcoin /mnt/ext/
```

Create the directory

```bash
sudo su - goeth
cd /mnt/ext
mkdir bitcoin
ls -la
```

Quit the 'goeth' session

```bash
exit

Create a systemd service config file to configure the Geth node service

```bash
 sudo nano /etc/systemd/system/geth.service
```

### Running Geth

```bash
# Run Nodes on the terminal
# Run the execution client
geth --goerli --datadir /home/bjeab/.ethereum/goerli/ --http --http.api eth,net,web3,txpool,engine,admin --authrpc.jwtsecret /home/bjeab/.ethereum/goerli/consensus/lighthouse/jwttoken -authrpc.addr localhost --authrpc.port 8551 --authrpc.vhosts localhost --metrics --metrics.expensive

geth --goerli --http --http --metrics --metrics.expensive --pprof --authrpc.jwtsecret=/home/bjeab/.ethereum/goerli/consensus/lighthouse/jwttoken
# Run the beacon node using lighthouse
cd ~/.ethereum/goerli/consensus/lighthouse

./lighthouse bn --network goerli --execution-endpoint http://localhost:8551 --metrics --validator-monitor-auto --checkpoint-sync-url https://checkpoint-sync.goerli.ethpandaops.io --execution-jwt /home/bjeab/.ethereum/goerli/consensus/lighthouse/jwttoken --http --disable-deposit-contract-sync --purge-db
```

Execution node sync status

```bash
geth version
geth --goerli attach
eth.syncing
eth.getBlock('latest').number
```

## Documentation

- [Quicknode installation](https://www.quicknode.com/guides/infrastructure/node-setup/how-to-install-and-run-a-geth-node/)
- [Getting started with Geth](https://geth.ethereum.org/docs/getting-started)
- [Tuto](https://github.com/eth-educators/ethstaker-guides/blob/main/merge-goerli-prater.md)
- [Set up Firewall](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04-fr)
- [go-ethereum](https://github.com/ethereum/go-ethereum)
- [Ethereum public endpoints](https://eth-clients.github.io/checkpoint-sync-endpoints/)
<!-- - <https://geth.ethereum.org/docs/fundamentals/command-line-options>
- <https://consensys.net/blog/teku/teku-and-infura-team-up-to-make-the-fastest-ethereum-2-0-client-sync/>
-<https://ethereum.stackexchange.com/questions/142870/how-do-i-expose-and-beacon-chain-api-securely-over-http-and-test-my-api-works>
- [Tuto Besu/Teku](https://github.com/eth-educators/ethstaker-guides/blob/main/merge-goerli-prater-alt.md)
- <https://ethereum.org/en/staking/pools/>
- <https://lighthouse-book.sigmaprime.io/faq.html>
- <https://geth.ethereum.org/docs/fundamentals/peer-to-peer>

-<https://www.quicknode.com/guides/infrastructure/node-setup/how-to-run-a-hyperledger-besu-node/>

- <https://aubay.udemy.com/course/blockchain-developer/learn/lecture/8798024#overview>
- <https://geth.ethereum.org/docs/getting-started>
- <https://www.alchemy.com/overviews/what-is-a-geth-node-and-how-to-run-one>
- <https://cryptomarketpool.com/getting-started-with-geth-to-run-an-ethereum-node/>
- <https://medium.com/@cvcassano/setting-up-a-full-ethereum-node-with-rpc-and-debug-support-geth-316517a1fdc>
- <https://rpcfast.com/blog/how-to-install-and-run-geth-node>
- <https://dev.to/yongchanghe/tutorial-play-with-geth-go-ethereum-4gic>
- <https://www.youtube.com/watch?v=ftS-SlzCCn4>
- <https://www.youtube.com/watch?v=3H-KmO7Ce4I>
- <https://www.youtube.com/watch?v=DLfSNcs2aW8>
- <https://www.quicknode.com/guides/infrastructure/node-setup/how-to-install-and-run-a-geth-node/>
- <https://github.com/bjeabby1507/Running_a_Bitcoin_node/blob/main/README.md>
- <https://github.com/redek-zelton/TD3---Running-a-GETH-node>
- <https://lighthouse-book.sigmaprime.io/run_a_node.html>
- <https://www.google.com/search?client=firefox-b-d&q=INFO+UPnP+not+available++++++++++++++++++++++error%3A+IO+error%3A+Resource+temporarily+unavailable+%28os+error+11%29%2C+service%3A+UPnP>
- -->
