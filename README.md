# HPKeychain
A lightweight Swift library for convenient keychain access

## Accessing the keychain
To fetch a credential from the keychain, all you have to do is call `try Keychain.shared.fetchCredentials(for:)`.
`credentialType` specifies what kind of item you’re looking for. Currently there are two supported credential types. `.generic(service: String)` and `.internetPassword(server: String)`.

### Example
```swift
let credentials = try KeychainManager.shared.fetchCredentials(for: .internetPassword(server: "https://github.com"))
```

## Adding to the keychain
To store a new item in the keychain, simply create a `Credentials` instance and pass it to the `KeychainManager`.

### Example
```swift
let credentials = Credentials(username: "admin", password: "admin", credentialType: .internetPassword(server: "https://github.com"))
try KeychainManager.shared.storeCredentials(credentials)
```

## Updating a keychain item
Updating items is almost as easy adding them in the first place. Either create a new set of credentials or update an existing instance by calling `credentials.makeUpdatedCredentials(username:password:)`. After that you can call `try KeychainManager.shared.updateCredentials(_:)`.

### Example
```swift
let updatedCredentials = existingCredentials.makeUpdatedCredentials(password: "someMoreSecurePassword")
try KeychainManager.shared.updateCredentials(updatedCredentials)
```

## Deleting a keychain item
To delete a keychain item, simply call `try KeychainManager.shared.deleteCredentials(for:)`

### Example
```swift
let credentialsType = CredentialsType.internetPassword(server: "https://github.com")
try KeychainManager.shared.deleteCredentials(for: credentialsType)
```

