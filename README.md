# HPKeychain

A lightweight Swift library for convenient keychain access.

HPKeychain supports iOS 15, tvOS 15, macOS 12, watchOS 9, and visionOS 1.

## Installation

HPKeychain is available through the Swift Package Manager.

### In a Swift package

Add the package to the `dependencies` of your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/henrik-dmg/hpkeychain", from: "0.0.1")
]
```

Then add the product to the target that uses it:

```swift
.target(
    name: "MyTarget",
    dependencies: [
        .product(name: "HPKeychain", package: "hpkeychain")
    ]
)
```

### In an Xcode project

1. Open your project in Xcode.
2. Choose **File > Add Package Dependencies…**.
3. Enter the URL `https://github.com/henrik-dmg/hpkeychain`.
4. Click **Add Package**.
5. Select the target that uses HPKeychain.

## Concepts

HPKeychain separates two concerns. A credential describes what the keychain item contains. A query describes how to find the item in the keychain.

- `UsernamePasswordCredential` holds a username and a password (as `Data`).
- `GenericPasswordQuery` finds an item with a service identifier.
- `InternetPasswordQuery` finds an item with a server.

`Keychain` is the entry point. Each method takes a query. The methods that write an item also take a credential.

## Saving a credential

To store a new item, call `save(_:for:)` with a credential and a query.

```swift
let query = InternetPasswordQuery(server: "https://github.com")
let credential = UsernamePasswordCredential(username: "admin", password: Data("secret".utf8))

try Keychain.save(credential, for: query)
```

## Fetching credentials

To read items, call `credentials(for:)` with a query. The method returns an array of credentials for the type of the query. The array is empty when no item matches.

```swift
let query = GenericPasswordQuery(serviceIdentifier: "com.example.myapp")
let credentials = try Keychain.credentials(for: query)

if let credential = credentials.first {
    print(credential.username)
}
```

## Updating a credential

To change an existing item, call `update(_:for:)` with the new credential and the query that finds the item. The method throws an error when no item matches.

```swift
let query = InternetPasswordQuery(server: "https://github.com")
let updatedCredential = UsernamePasswordCredential(username: "admin", password: Data("someMoreSecurePassword".utf8))

try Keychain.update(updatedCredential, for: query)
```

## Deleting credentials

To delete items, call `deleteAll(matching:)` with a query. The method deletes all items that match. It does not throw an error when no item matches.

```swift
let query = InternetPasswordQuery(server: "https://github.com")

try Keychain.deleteAll(matching: query)
```

## Supporting a new item type

To support a new type of keychain item, add a type that conforms to `Credential` and a type that conforms to `CredentialQuery`. You do not change `Keychain`.
