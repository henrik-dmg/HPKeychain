import Foundation

enum KeychainError: Error {

    case noItem, invalidItem, incompleteCredentials, unableToCreatePasswordData
    case ossStatus(code: Int, description: String)

}

extension KeychainError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .noItem:
            return "No keychain item found for the specified domain"
        case .invalidItem:
            return "Invalid keychain item found for the specified domain"
        case .incompleteCredentials:
            return "Incomplete credentials entered"
        case .unableToCreatePasswordData:
            return "Unable to create Data from password"
        case .ossStatus(_, let description):
            return description
        }
    }

    static func errorWithOSStatus(_ status: OSStatus) -> KeychainError {
        guard let errorMessage = SecCopyErrorMessageString(status, nil) else {
            return .ossStatus(code: Int(status), description: "Unhandled keychain error")
        }
        return .ossStatus(code: Int(status), description: errorMessage as String)
    }

}
