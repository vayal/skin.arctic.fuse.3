#!/bin/bash
# Trigger generator via Kodi JSON-RPC
curl -s -X POST -H "Content-Type: application/json" -d '{
  "jsonrpc": "2.0",
  "method": "Addons.ExecuteAddon",
  "params": { "addonid": "script.skinvariables", "params": ["action=build"] },
  "id": 1
}' http://kodi:kodi@127.0.0.1:8080/jsonrpc

sleep 3 # Wait for generation

# Force Reload
flatpak run --command=kodi-send tv.kodi.Kodi --host=127.0.0.1 --action="ReloadSkin()" > /dev/null 2>&1

echo "--- GENERATOR OUTPUT STATUS ---"
git status --short 1080i/