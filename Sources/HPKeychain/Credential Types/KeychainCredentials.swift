import Foundation

public protocol KeychainCredentials {

	var credentialType: CredentialType { get }

	init(username: String, password: String, credentialType: CredentialType, additionalPayload: CredentialPayloadable?)

	func makeAttributes() throws -> [String: Any]
	func makeUpdatedCredentials(username: String?, password: String?, credentialType: CredentialType?, additionalPayload: CredentialPayloadable?) -> Self

}
