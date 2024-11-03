# User info extraction 

After creating 10 user account (includind admin account) a bash command was written to extract the username and passwords from the zimbra server in csv format

Switch to zimbra user
```
su zimbra
```

to get all user accounts server
```
zmprov -l gaa
```

to extract info of single user
```
zmprov -l raghav@mail.fossee-application.com
```

will yeild the output
```
# name raghav@mail.fossee-application.com
cn: Raghav Rana
displayName: Raghav Rana
givenName: Raghav
mail: raghav@mail.fossee-application.com
objectClass: inetOrgPerson
objectClass: zimbraAccount
objectClass: amavisAccount
sn: Rana
uid: raghav
userPassword: {SSHA512}/99K3gpVippX3LDsLYs4jdPz7QL2HlmLtb3yIGf4Y3nXsvbx19Nh7Zk1zhwfw2R430QgMFYPSrZ79RDnnjAhiSrsa3RPtoMR
zimbraAccountStatus: active
zimbraAdminAuthTokenLifetime: 12h
zimbraAllowAnyFromAddress: FALSE
zimbraAppSpecificPasswordDuration: 0
zimbraArchiveAccountDateTemplate: yyyyMMdd
zimbraArchiveAccountNameTemplate: ${USER}-${DATE}@${DOMAIN}.archive
.
.
.
zimbraZimletAvailableZimlets: +com_zimbra_ymemoticons
zimbraZimletAvailableZimlets: !com_zimbra_date
zimbraZimletAvailableZimlets: !com_zimbra_attachcontacts
zimbraZimletLoadSynchronously: FALSE
zimbraZimletUserPropertiesMaxNumEntries: 150
```

this can be cleaned up using **awk** (see [licence]())
```
zmprov -l gaa | awk '{system("zmprov -l ga "$1" userPassword")}' | awk -F' ' '/name/{email=$3} /userPassword:/{gsub("{SSHA512}","",$2); print email "," $2}' > /tmp/zimbra.csv
```

the output file is of this format:
```
admin@mail.fossee-application.com,xnCx7T/CXYkg+oWNI99HHKel8ajC50dbKuug1H+KI3a9HC3N5bHgMp7cGoes5I4bu1cG/gJzdQemXD3v20SW/srxE/fsXtRn
spam.9o8ifnnuim@mail.fossee-application.com,jYkw0uKDOS0Ye9ZJewJrTqrvN4thJf5XXeGEclgIFJx3RKWoh8UkQwLoqx/fOj4VkaASKj4tIrE0mDT4Ry4ZsyANGfs2usnv
ham.1gk09kjq@mail.fossee-application.com,LwKu8xltihhFg74DTFKjydoRrB0tvF9ON7GBG5QlvDSOQvGZUzSJgb9ifsIkzMuMAZjcJZMggF5RFY+x9K0Vj/1Ze4N9us47
virus-quarantine.lfzobsut@mail.fossee-application.com,/+N7W8Rsa2Qyh5SL67b7oATsrsCwZD9fz4MsOAgWp3E/SBnVjQU7801x36IIzg8I4AMar2p6y6/yF5D9OaxaxJB6MCLSCeY7
raghav@mail.fossee-application.com,/99K3gpVippX3LDsLYs4jdPz7QL2HlmLtb3yIGf4Y3nXsvbx19Nh7Zk1zhwfw2R430QgMFYPSrZ79RDnnjAhiSrsa3RPtoMR
huehue@mail.fossee-application.com,CKFNKJfTLa4zmt6xLzgrFZIP8T5JIArAyZ/p4C4gS2nmuGjf5jyNpeWB4tb9iVagxK7BUeDbRq21ftkPo6F43P+7goHzfHzb
thanos@mail.fossee-application.com,PAZ0keRUnxGtmN3Zjf494MQXXGzAyz8s6ksqCCuftqNwQiw8M+S91TDL+gJA3Dl1gcDS4MKwvHiDSu70tT0aGx9+Sg1BhSQd
captain@mail.fossee-application.com,BsTDu0zoDjsx5aNG8KHzfLeHBN7awZYS44dbHQz1vWiX1Mwh2xNutm73DsPehvWug55qWQrzQnWNWS2ZpYMLNGhqpsqMD3JO
tony@mail.fossee-application.com,gHdyhGnkjRM07gBwVfnmvjH+LFhVvkGEZEfYFHVrQ+MYev9JtkhuC2w5BJGcOD88zKAME4FiDWPhD3EPDDhPs0UNEjj7nZJa
bruce@mail.fossee-application.com,VYvqBCsbKxPAkcFnNkWzjqiUgoCbLJvaAaTZ9y6AOCRCI9FD4hqCAYd9K4fWsZCjC2b9y+FF9BFcP1zdSujr+YzrpAzUW/DX
black@mail.fossee-application.com,FbSOdY05ukVKH6nAYqUKwUncZV0KqaYybmHZwJq5iO8iMTF9og+kWuZo2zyUmH/SHGcz7n9hiWZ2B5EsLKIEu4HgaS7DOvau
dilraj@mail.fossee-application.com,7nifIpby2npxrGMtMXv7iQ5ek1oh6I8AaPDda8jmr+Tk53QcKMuG0GkLVHz5Pqn8OTESkplA/drIY2fAmDuEsh6FU46jeGww
ekuspreet@mail.fossee-application.com,YenrccTyf+7tXG1KX7IkXcnPsJWzpy49uHiCBwbMo4lNfAyKGdw+j4jZMNed65oBXQoD3s43MSk8xuk5Ttl8L5E4xEbgeSys
```

## Conclusion
A script (using zmprov and awk) was written to extract user information (username and passwordhash) form zimbra server and store it in a .csv file. The passwords are hashed so the process is secure as instructed in the task. Therefor this step is complete.