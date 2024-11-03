# Creating user accounts

After loggin in mail.fossee-application.com as admin

![alt](../images/zimbra-login.avif)

following accounts were created

![alt](../images/accounts.avif)

## Automating the process

The process takes a lot of time if done manually. It can be automated by using this [bash script](../Scripts/createAccounts.sh).

This script reads from the csv with this format:
```
username,email,displayname,password
username,email,displayname,password
username,email,displayname,password
username,email,displayname,password
```

and creates account using **zmprov** command 

This bash script needs to be run as 'zimbra' user.

## Conclusion
10 user accounts were created on the installed zimbra server. A bash script was written to automate the process of adding users to zimbra account. Hence Step 2 can is done.