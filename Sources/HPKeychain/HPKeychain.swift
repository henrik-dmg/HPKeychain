import Foundation

/// Convenience wrapper for keychain access. Adapted from
/// [Apple's sample code](https://developer.apple.com/documentation/security/keychain_services/keychain_items)
public struct HPKeychain {

    public let domain: String

    public init(domain: String) {
        self.domain = domain
    }

    // MARK: - Keychain Management

    public func storeCredentialsInKeychain(with credentials: Credentials) throws {
        guard let passwordData = credentials.password.data(using: .utf8) else {
            throw NSError(description: "Could not convert password to bytes")
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: credentials.username,
            kSecAttrService as String: domain,
            kSecValueData as String: passwordData
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.errorWithOSStatus(status)
        }
    }

    public func updateCredentialsInKeychain(with credentials: Credentials) throws {
        guard let passwordData = credentials.password.data(using: .utf8) else {
            throw NSError(description: "Could not convert password to bytes")
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: domain
        ]

        let attributes: [String: Any] = [
            kSecAttrAccount as String: credentials.username,
            kSecValueData as String: passwordData
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            throw KeychainError.noItem
        }
        guard status == errSecSuccess else {
            throw KeychainError.errorWithOSStatus(status)
        }
    }

    public func deleteCredentialsFromKeychain() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: domain
        ]

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.errorWithOSStatus(status)
        }
    }

    public func fetchCredentialsFromKeychain() throws -> Credentials? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: domain,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]

        var item: CFTypeRef?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &item)

        guard status != errSecItemNotFound else {
            return nil
        }
        guard status == errSecSuccess else {
            throw KeychainError.errorWithOSStatus(status)
        }

        guard
            let existingItem = item as? [String: Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existingItem[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.invalidItem
        }
        return Credentials(username: account, password: password, domain: domain)
    }

}
