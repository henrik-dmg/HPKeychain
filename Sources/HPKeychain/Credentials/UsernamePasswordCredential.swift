import Foundation

public struct UsernamePasswordCredential: Credential {

    public let username: String
    public let password: Data

    public init(username: String, password: Data) {
        self.username = username
        self.password = password
    }

    // MARK: - KeychainCredential

    public func attributes() throws -> Attributes {
        [
            kSecAttrAccount as String: username as NSString,
            kSecValueData as String: password as NSData,
        ]
    }

}
