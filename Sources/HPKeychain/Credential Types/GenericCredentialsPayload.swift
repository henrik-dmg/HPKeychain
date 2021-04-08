import Foundation

public struct GenericCredentialsPayload: CredentialPayloadable {

	//public let Access: String // macOS only
	public let accessControl: SecAccessControl?
	public let AccessGroup: String? // (iOS; also macOS if kSecAttrSynchronizable specified)
	public let Accessible: String? // (iOS; also macOS if kSecAttrSynchronizable specified)
	public let creationDate: Date?
	public let modificationDate: Date?
	public let description: String?
	public let comment: String?
	public let creator: CFNumber?
	public let itemType: CFNumber?
	public let label: String?
	public let isInvisible: Bool?
	public let isNegative: Bool?
	public let synchronizable: Bool

	public init(
		accessControl: SecAccessControl? = nil,
		AccessGroup: String? = nil,
		Accessible: String? = nil,
		creationDate: Date? = nil,
		modificationDate: Date? = nil,
		description: String? = nil,
		comment: String? = nil,
		creator: CFNumber? = nil,
		itemType: CFNumber? = nil,
		label: String? = nil,
		isInvisible: Bool? = nil,
		isNegative: Bool? = nil,
		synchronizable: Bool = false
	) {
		self.accessControl = accessControl
		self.AccessGroup = AccessGroup
		self.Accessible = Accessible
		self.creationDate = creationDate
		self.modificationDate = modificationDate
		self.description = description
		self.comment = comment
		self.creator = creator
		self.itemType = itemType
		self.label = label
		self.isInvisible = isInvisible
		self.isNegative = isNegative
		self.synchronizable = synchronizable
	}

	public func makePayload() -> [String : Any] {
		// TODO
		[:]
	}

}
