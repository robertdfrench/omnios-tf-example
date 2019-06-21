curl -4 -q ifconfig.co/json | jq -r '{ip: .ip}'
