# Node-RED Hass.io Add-On
---------

[Hass.io](https://home-assistant.io/hassio/) add-on for [Node-RED](https://nodered.org/).

## Installation

1. Add my [Hass.io](https://home-assistant.io/hassio/) add-on [repository](https://github.com/notoriousbdg/hassio-addons)
2. Install the "Node-RED" add-on
3. (Optional) To enable SSL support, set SSL to true
    ```json
    {
      "ssl": true,
      "certfile": "fullchain.pem",
      "keyfile": "privkey.pem",
      "users": [
        {
          "username": "admin",
          "password": "password",
          "permissions": "*"
        }
      ],
      "http_node_user": [
        {
          "username": "admin",
          "password": "password"
        }
      ]
    }
    ```
4. (Optional) Disable IDE authentication by removing all users from users array
    ```json
    {
      "ssl": true,
      "certfile": "fullchain.pem",
      "keyfile": "privkey.pem",
      "users": [
      ]
    }
    ```
5. (Optional) Disable HTTP Node (Dashboard UI) authentication by removing the user from http_node_user
    ```json
    {
      "ssl": true,
      "certfile": "fullchain.pem",
      "keyfile": "privkey.pem",
      "http_node_user": [
      ]
    }
    ```
6. (Optional) Add additional IDE users to users array.  Use permission of `read` to grant read-only permissions to additional users.
    ```json
    {
      "ssl": true,
      "certfile": "fullchain.pem",
      "keyfile": "privkey.pem",
      "users": [
        {
          "username": "admin",
          "password": "password",
          "permissions": "*"
        },
        {
          "username": "user2",
          "password": "password2",
          "permissions": "read"
        }
      ]
    }
    ```
7. Start the "Node-RED" add-on
8. (Optional) Configure [panel_iframe](https://home-assistant.io/components/panel_iframe/) component to embed Node-RED UI into Home Assistant UI using this example:

    ```yaml
    panel_iframe:
      nodered_flows:
        title: 'Node-RED Flows'
        url: 'http://hassio.local:1880'
        icon: mdi:nodejs
    ```

9. (Optional) If you install [Node-RED Dashboard](https://github.com/node-red/node-red-dashboard) in Node-RED, you can expose the dashboard in the [Hass.io](https://home-assistant.io/hassio/) UI using this example to your [panel_iframe](https://home-assistant.io/components/panel_iframe/) section:

    ```yaml
    panel_iframe:
      nodered_ui:
        title: 'Node-RED Dashboard'
        url: 'http://hassio.local:1880/ui'
        icon: mdi:nodejs
    ```

## Support

Please use [this thread](https://community.home-assistant.io/t/repository-notoriousbdg-add-ons-node-red-and-ha-bridge/23247) for feedback.

## Changelog

### 0.1.0 (2017-07-31)
#### Initial Release

### 0.1.1 (2017-08-10)
#### Added
- Option to enable SSL

### 0.1.2 (2017-09-15)
#### Changed
- Changed to use host network to allow Node-RED to listen on arbitrary ports

### 0.1.3 (2017-10-10)
#### Added
- Updated to support new hass.io build system

### 0.1.4 (2017-10-24)
#### Changed
- Updated webui links in config.json to support ssl when enabled in the addons

### 0.1.5 (2017-11-25)
#### Changed
- Moved data dir to /share/node-red
#### Added
- Added authentication for editor and admin API

### 0.1.6 (2017-12-13)
#### Changed
- node-red-admin no longer re-installs on every restart of the addon
#### Added
- Added authentication for HTTP nodes (Dashboard UI)
