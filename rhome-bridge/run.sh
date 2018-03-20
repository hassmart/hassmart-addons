#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

HASS_IP=$(jq --raw-output '.hass_ip // empty' $CONFIG_PATH)
HASS_PORT=$(jq --raw-output '.hass_port // empty' $CONFIG_PATH)
HASS_PASSWD=$(jq --raw-output '.hass_passwd // empty' $CONFIG_PATH)
RHOME_PORT=$(jq --raw-output '.rhome_port // empty' $CONFIG_PATH)

export HASS_IP={$HASS_IP}
export HASS_PORT={$HASS_PORT}
export HASS_PASSWD={$HASS_PASSWD}
export RHASS_PORT={$RHOME_PORT}

echo Start rhome-bridge.

exec rhass
