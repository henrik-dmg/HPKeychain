import Foundation

// MARK: - Nested Types

public enum CredentialType: Equatable {

	case generic(service: String)
	case internetPassword(server: String)

	func makeQuery() -> [String: Any] {
		switch self {
		case .generic(let service):
			return [
				kSecClass as String: kSecClassGenericPassword,
				kSecAttrService as String: service,
			]
		case .internetPassword(let server):
			return [
				kSecClass as String: kSecClassInternetPassword,
				kSecAttrServer as String: server,
			]
		}
	}

}

public protocol CredentialPayloadable {

	func makePayload() -> [String: Any]

}

public struct Credentials: KeychainCredentials {

	// MARK: - Properties

	public let username: String
	public let password: String
	public let credentialType: CredentialType
	public let additionalPayload: CredentialPayloadable?

	// MARK: - Init

	public init(username: String, password: String, credentialType: CredentialType, additionalPayload: CredentialPayloadable? = nil) {
		self.username = username
		self.password = password
		self.credentialType = credentialType
		self.additionalPayload = additionalPayload
	}

	// MARK: - KeychainCredentials

	public func makeAttributes() throws -> [String : Any] {
		guard let passwordData = password.data(using: .utf8) else {
			throw KeychainError.unableToCreatePasswordData
		}

		let attributes: [String: Any] = [
			kSecAttrAccount as String: username,
			kSecValueData as String: passwordData
		]

		if let payload = additionalPayload?.makePayload() {
			return attributes.hp_mergingKeepingOldValues(payload)
		} else {
			return attributes
		}
	}

	public func makeUpdatedCredentials(username: String? = nil, password: String? = nil, credentialType: CredentialType? = nil, additionalPayload: CredentialPayloadable? = nil) -> Credentials {
		Credentials(
			username: username ?? self.username,
			password: password ?? self.password,
			credentialType: credentialType ?? self.credentialType,
			additionalPayload: additionalPayload ?? self.additionalPayload
		)
	}

}