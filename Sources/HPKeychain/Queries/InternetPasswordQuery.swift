import Foundation

public struct InternetPasswordQuery: CredentialQuery {

    // MARK: - Nested Types

    public typealias Credential = UsernamePasswordCredential

    // MARK: - Properties

    private let server: String

    // MARK: - Init

    public init(server: String) {
        self.server = server
    }

    // MARK: - CredentialQuery

    public func queryItems() throws -> [QueryItem] {
        InternetPasswordClass()
        Server(server)
    }

    public func credential(from attributes: NSDictionary) throws -> Credential? {
        guard
            let server = attributes[kSecAttrServer as String] as? String, server == self.server,
            let username = attributes[kSecAttrAccount as String] as? String,
            let passwordData = attributes[kSecValueData as String] as? Data
        else {
            return nil
        }
        return Credential(username: username, password: passwordData)
    }

}
