import Foundation

public struct Credentials {

    public let username: String
    public let password: String
    public let domain: String

}

final class KeychainError: NSError {

    static let noItem = KeychainError(description: "No keychain item found for the specified domain")
    static let invalidItem = KeychainError(description: "Invalid keychain item found for the specified domain")
    static let incompleteCredentials = KeychainError(description: "Incomplete credentials entered")

    static func errorWithOSStatus(_ status: OSStatus) -> KeychainError {
        guard let errorMessage = SecCopyErrorMessageString(status, nil) else {
            return KeychainError(code: Int(status), description: "Unhandled keychain error")
        }
        return KeychainError(code: Int(status), description: errorMessage as String)
    }

}
