import Foundation

public protocol CredentialQuery<Credential> {

    associatedtype Credential

    @QueryItemBuilder
    func queryItems() throws -> [QueryItem]

    func credential(from attributes: NSDictionary) throws -> Credential

}
