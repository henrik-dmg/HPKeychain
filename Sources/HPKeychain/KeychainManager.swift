import Foundation

/// Convenience wrapper for keychain access. Adapted from
/// [Apple's sample code](https://developer.apple.com/documentation/security/keychain_services/keychain_items)
public struct KeychainManager {

    public static let shared = KeychainManager()

    public func save(_ credential: Credential, for query: any CredentialQuery) throws {
        let attributes = try credential.attributes()
        var completeQuery = attributes

        for queryItem in try query.queryItems() {
            completeQuery[queryItem.key] = queryItem.value
        }

        let status = SecItemAdd(completeQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.errorWithOSStatus(status)
        }
    }

    public func update(_ credential: Credential, for query: any CredentialQuery) throws {
        let attributes = try credential.attributes()
        var completeQuery = [String: AnyObject]()

        for queryItem in try query.queryItems() {
            completeQuery[queryItem.key] = queryItem.value
        }

        let status = SecItemUpdate(completeQuery as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            throw KeychainError.noItem
        }
        guard status == errSecSuccess else {
            throw KeychainError.errorWithOSStatus(status)
        }
    }

    public func deleteCredential(with query: any CredentialQuery) throws {
        var completeQuery = [String: AnyObject]()

        for queryItem in try query.queryItems() {
            completeQuery[queryItem.key] = queryItem.value
        }

        let status = SecItemDelete(completeQuery as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.errorWithOSStatus(status)
        }
    }

    public func credentials<C: Credential>(for query: any CredentialQuery<C>) throws -> [C] {
        var completeQuery: [String: AnyObject] = [
            kSecReturnPersistentRef as String: kCFBooleanTrue,
            kSecReturnAttributes as String: kCFBooleanTrue,
            kSecReturnData as String: kCFBooleanTrue,
        ]

        for queryItem in try query.queryItems() {
            completeQuery[queryItem.key] = queryItem.value
        }

        var result: AnyObject?
        let resultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(completeQuery as CFDictionary, $0)
        }

        if resultCode == errSecItemNotFound {
            // Not finding any keychain items is not an error in this case. Return an empty array.
            return []
        }
        guard resultCode == errSecSuccess else {
            throw KeychainError.errorWithOSStatus(resultCode)
        }
        if let keychainItems = result as? [NSDictionary] {
            return try keychainItems.map { try query.credential(from: $0) }
        } else if let keychainItem = result as? NSDictionary {
            return [try query.credential(from: keychainItem)]
        } else {
            throw KeychainError.invalidItem
        }
    }

}
