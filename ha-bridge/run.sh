#!/bin/bash

CONFIG_PATH=/data/options.json
SERVERIP=$(jq --raw-output ".serverip" $CONFIG_PATH)
SERVERPORT=$(jq --raw-output ".serverport" $CONFIG_PATH)
VERSION=$(jq --raw-output ".version" $CONFIG_PATH)

if [ "$SERVERIP" == "" ]; then
  echo "[ERROR] serverip must be specified!"
  exit 1
fi

# Create /share/habridge/data folder
if [ ! -d /share/habridge/data ]; then
  echo "[INFO] Creating /share/habridge folder"
  mkdir -p /share/habridge/data
fi

# Migrate existing config files to handle upgrades from previous version
if [ -e /data/habridge.config ] && [ ! -e /share/habridge/data/habridge.config ]; then
  # Migrate existing habridge.config file
  echo "[INFO] Migrating existing habridge.config from /data to /share/habridge/data"
  mv -f /data/habridge.config /share/habridge/data
fi

# Migrate existing backup files
find /data -name '*.cfgbk' \
  -exec echo "[INFO] Moving existing {} to /share/habridge" \; \
  -exec mv -f {} /share/habridge \;

cd /share/habridge
if [ ! -z $VERSION ] && [ ! "$VERSION" == "" ] && [ ! "$VERSION" == "null" ] && [ ! "$VERSION" == "latest" ]; then
  echo "Manual version override:" $VERSION
else
  #Check the latest version on github
  VERSION="$(curl -sX GET https://api.github.com/repos/bwssytems/ha-bridge/releases/latest | grep 'tag_name' | cut -d\" -f4)"
  VERSION=${VERSION:1}
  echo "Latest version on bwssystems github repo is" $VERSION
fi

# Download jar
if [ ! -f /share/habridge/ha-bridge-"$VERSION".jar ]; then
  echo "Installing version '$VERSION'"
  wget https://github.com/bwssytems/ha-bridge/releases/download/v"$VERSION"/ha-bridge-"$VERSION".jar -O /share/habridge/ha-bridge-"$VERSION".jar
else
  echo "Using existing version '$VERSION'"
fi
echo "Setting correct permissions"
chown -R nobody:users /share/habridge

ADDPARAM="-Dupnp.config.address=$SERVERIP -Dserver.port=$SERVERPORT -Djava.net.preferIPv4Stack=true"
echo -e "Parameters used:\n  Server IP : $SERVERIP\n  Server Port : $SERVERPORT\n  preferIPv4Stack : true"

echo "Starting Home Automation Bridge"
java -jar $ADDPARAM /share/habridge/ha-bridge-"$VERSION".jar 2>&1 | tee /share/habridge/ha-bridge.log
