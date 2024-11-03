# Creating Linux account from extracted data

The extracted user information in the Step 3 can be used to create a user account in linux.

The extracted hash is a 96 (576 bits) character base64 encoded string. It is also specified that the the hash is SSHA512, 
SSHA512 hash is 64 bytes in length (512 bits).

The base64 string is decoded, then  first 64 bytes are extracted from the string as hash, and remaining bits are assumed as salt.

now a user can be created and the password of the user can be set with
``` 
usermod -p $6$salt$hash
```

But this will not work as the zimbra string hash was computed using only 1 round of SSHA. To make linux also use only 1 round (instead of default 5000) we can do the following

In **/etc/login.dgfs**
```
SHA_CRYPT_MAX_ROUNDS 1
```

which can be done using the this [bash script](../Scripts/)