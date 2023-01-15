import Foundation

public protocol QueryItem {

    var key: String { get }
    var value: AnyObject? { get }

}

public struct InternetPasswordClass: QueryItem {

    public var key: String {
        kSecClass as String
    }

    public var value: AnyObject? {
        kSecClassInternetPassword
    }

    public init() {}

}

public struct GenericPasswordClass: QueryItem {

    public var key: String {
        kSecClass as String
    }

    public var value: AnyObject? {
        kSecClassGenericPassword
    }

    public init() {}

}

public struct Server: QueryItem {

    public var key: String {
        kSecAttrServer as String
    }

    public var value: AnyObject? {
        server as NSString
    }

    private let server: String

    public init(_ server: String) {
        self.server = server
    }

}

public struct Service: QueryItem {

    public var key: String {
        kSecAttrService as String
    }

    public var value: AnyObject? {
        service as NSString
    }

    private let service: String

    public init(_ service: String) {
        self.service = service
    }

}
