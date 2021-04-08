import Foundation

/// Convenience wrapper for keychain access. Adapted from
/// [Apple's sample code](https://developer.apple.com/documentation/security/keychain_services/keychain_items)
public struct KeychainManager {

    public static let shared = KeychainManager()

	public func storeCredentials(_ credentials: Credentials) throws {
		let attributes = try credentials.makeAttributes()
		let query = credentials.credentialType.makeQuery()

		let completeQuery = query.hp_mergingKeepingOldValues(attributes)

		assert(completeQuery.keys.count == attributes.keys.count + query.keys.count)

		let status = SecItemAdd(completeQuery as CFDictionary, nil)
		guard status == errSecSuccess else {
			throw KeychainError.errorWithOSStatus(status)
		}
    }

    public func updateCredentials(_ credentials: Credentials) throws {
		let attributes = try credentials.makeAttributes()
		let query = credentials.credentialType.makeQuery()

		let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
		guard status != errSecItemNotFound else {
			throw KeychainError.noItem
		}
		guard status == errSecSuccess else {
			throw KeychainError.errorWithOSStatus(status)
		}
    }

    public func deleteCredentials(for credentialType: CredentialType) throws {
		let query = credentialType.makeQuery()

		let status = SecItemDelete(query as CFDictionary)
		guard status == errSecSuccess || status == errSecItemNotFound else {
			throw KeychainError.errorWithOSStatus(status)
		}
    }

	public func fetchCredentials(for credentialType: CredentialType) throws -> Credentials {
		let query: [String: Any] = [
			kSecMatchLimit as String: kSecMatchLimitOne,
			kSecReturnAttributes as String: true,
			kSecReturnData as String: true
		].hp_mergingKeepingOldValues(credentialType.makeQuery())

		var item: CFTypeRef?
		let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &item)

		guard status != errSecItemNotFound else {
			throw KeychainError.noItem
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
		return Credentials(username: account, password: password, credentialType: credentialType, additionalPayload: nil)
    }

}
