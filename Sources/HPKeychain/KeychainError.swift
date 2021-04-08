import Foundation

final class KeychainError: NSError {

	static let noItem = KeychainError(code: 2, description: "No keychain item found for the specified domain")
	static let invalidItem = KeychainError(code: 3, description: "Invalid keychain item found for the specified domain")
	static let incompleteCredentials = KeychainError(code: 4, description: "Incomplete credentials entered")
	static let unableToCreatePasswordData = KeychainError(code: 5, description: "Unable to create Data from password")

	static func errorWithOSStatus(_ status: OSStatus) -> KeychainError {
		guard let errorMessage = SecCopyErrorMessageString(status, nil) else {
			return KeychainError(code: Int(status), description: "Unhandled keychain error")
		}
		return KeychainError(code: Int(status), description: errorMessage as String)
	}

}
