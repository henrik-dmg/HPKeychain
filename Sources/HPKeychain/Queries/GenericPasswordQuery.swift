import Foundation

public struct GenericPasswordQuery: CredentialQuery {

    // MARK: - Nested Types

    public typealias Credential = UsernamePasswordCredential

    // MARK: - Properties

    private let serviceIdentifier: String

    // MARK: - Init

    public init(serviceIdentifier: String) {
        self.serviceIdentifier = serviceIdentifier
    }

    // MARK: - CredentialQuery

    public func queryItems() throws -> [QueryItem] {
        GenericPasswordClass()
        Service(serviceIdentifier)
    }

    public func credential(from attributes: NSDictionary) throws -> Credential {
        guard
            let serviceIdentifier = attributes[kSecAttrService as String] as? String, serviceIdentifier == self.serviceIdentifier,
            let username = attributes[kSecAttrAccount as String] as? String,
            let passwordData = attributes[kSecValueData as String] as? Data
        else {
            throw KeychainError.invalidItem
        }
        return Credential(username: username, password: passwordData)
    }

}
