#!/bin/bash

csv_file="./zimbra.csv"

while IFS=',' read -r email base64hash; do
    
    username="${email%@*}"
    
    decoded_hash=$(echo "$base64hash" | base64 -d)
    
    hash_part=${decoded_hash:0:64}
    salt_part=${decoded_hash:64}
    
    hash_hex=$(echo -n "$hash_part" | base64)
    salt_hex=$(echo -n "$salt_part" | base64)

    sudo useradd -ms /bin/bash $username 
    sudo usermod -p "\$6\$$salt_hex\$$hash_hex"
    echo "User $username added with specified password hash."

done < "$csv_file"