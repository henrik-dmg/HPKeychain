import Foundation

public protocol Credential {

    typealias Attributes = [String: AnyObject]

    func attributes() throws -> Attributes

}
