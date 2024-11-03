#!/bin/bash

# csv of accounts
csvfile="accounts.csv"

counter=0

tail -n +2 "$csvfile" | while IFS=',' read -r username email displayname password; do
  
    create_command="zmprov ca ${email} ${password} sn '${username}' displayName '${displayname}' zimbraMailHost mail.fossee-application zimbraPasswordMustChange TRUE"
    
    eval "$create_command"
    
    ((counter++))
    
    sleep 5
done

echo "$counter accounts were added"
