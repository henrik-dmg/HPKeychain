import Foundation

struct GenericCredentialsPayload: CredentialPayloadable {

	//public let Access: String // macOS only
	let accessControl: SecAccessControl?
	let AccessGroup: String? // (iOS; also macOS if kSecAttrSynchronizable specified)
	let Accessible: String? // (iOS; also macOS if kSecAttrSynchronizable specified)
	let creationDate: Date?
	let modificationDate: Date?
	let description: String?
	let comment: String?
	let creator: CFNumber?
	let itemType: CFNumber?
	let label: String?
	let isInvisible: Bool?
	let isNegative: Bool?
	let synchronizable: Bool

	init(
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

	func makePayload() -> [String : Any] {
		// TODO
		[:]
	}

}
