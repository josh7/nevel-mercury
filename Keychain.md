## Why we use Keychain Services ##
Keychain Services provides secure storage of passwords, keys, certificates, and notes for one or more users.
  * As a user, you can unlock a keychain with a single password.
  * As to an application,it can then use that keychain to store and retrieve passwords.

## How we use Keychain Services ##
Luckily, we have a super weapon - SFHFKeychainUtils

Basically, the SFHFKeychainUtils has three methods for us to store, get and delete certain password when needed.
  * STORE. Store username and password to keychain.
```
+ (BOOL) storeUsername:(NSString *)username 
           andPassword:(NSString *)password 
        forServiceName:(NSString *)serviceName 
        updateExisting:(BOOL)updateExisting 
                 error:(NSError **)error;
```
  * GET. Get password from keychain.
```
+ (NSString *) getPasswordForUsername:(NSString *)username 
                       andServiceName:(NSString *)serviceName 
                                error:(NSError **)error;
```
  * DELETE. Delete password of certain username in keychain.
```
+ (BOOL) deleteItemForUsername:(NSString *)username 
                andServiceName:(NSString *)serviceName 
                         error:(NSError **)error;
```