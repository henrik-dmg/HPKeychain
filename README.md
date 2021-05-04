# HPKeychain

A lightweight Swift library for convenient keychain access

## Accessing the keychain

To fetch a credential from the keychain, all you have to do is call `try Keychain.shared.fetchCredential(for:)`.
`credentialType` specifies what kind of item you’re looking for. Currently there are two supported credential types. `.generic(service: String)` and `.internetPassword(server: String)`.

### Example

```swift
let credential = try KeychainManager.shared.fetchCredential(for: .internetPassword(server: "https://github.com"))
```

## Adding to the keychain

To store a new item in the keychain, simply create a `Credential` instance and pass it to the `KeychainManager`.

### Example

```swift
let credential = Credential(username: "admin", password: "admin", credentialType: .internetPassword(server: "https://github.com"))
try KeychainManager.shared.storeCredential(credential)
```

## Updating a keychain item

Updating items is almost as easy adding them in the first place. Either create a new set of credential or update an existing instance by calling `credential.makeUpdatedCredential(username:password:)`. After that you can call `try KeychainManager.shared.updateCredential(_:)`.

### Example

```swift
let updatedCredential = existingCredential.makeUpdatedCredential(password: "someMoreSecurePassword")
try KeychainManager.shared.updateCredential(updatedCredential)
```

## Deleting a keychain item

To delete a keychain item, simply call `try KeychainManager.shared.deleteCredential(for:)`

### Example

```swift
let credentialType = CredentialType.internetPassword(server: "https://github.com")
try KeychainManager.shared.deleteCredential(for: credentialType)
```
