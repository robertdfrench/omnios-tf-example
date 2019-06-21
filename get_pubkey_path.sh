bash -c 'echo $HOME/.ssh/id_rsa.pub' | jq -R '{pubkey: .}'
