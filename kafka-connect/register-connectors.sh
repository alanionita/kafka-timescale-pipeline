#!/bin/bash
# CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

echo "[kafka-connect]: Registering connectors ...."

# Wait for Connect API
while [[ "$(curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors)" -ne 200 ]]; do
  sleep 5
done

for config in ./connector-configs/*.json; do
  # Extract connector name using grep/sed
  connector_name=$(grep '"name":' "$config" | sed -n 's/.*"name": "\([^"]*\)".*/\1/p')
  
  if [ -n "$connector_name" ]; then
    echo "Registering connector: $connector_name"
    curl -X POST -H "Content-Type: application/json" \
      -d @"$config" http://localhost:8083/connectors
  else
    echo "Warning: No connector name found in $config"
  fi
done

wait