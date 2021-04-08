import XCTest
@testable import HPKeychain

final class HPKeychainTests: XCTestCase {

	private let genericCredentials = Credentials(username: "hpanhans", password: "someTestingPassword", credentialType: .generic(service: "com.henrikpanhans.HPKeychain"))
//
//	override class func setUp() {
//		super.setUp()
//		do {
//			try KeychainManager.shared.deleteCredentials(for: .generic(service: "com.henrikpanhans.HPKeychain"))
//		} catch let error {
//			XCTFail(error.localizedDescription)
//		}
//	}

	func testAAddingKeychainItem() {
		XCTAssertNoThrow(try KeychainManager.shared.storeCredentials(genericCredentials))
	}

	func testBFetching() throws {
		let storedCredentials: Credentials = try KeychainManager.shared.fetchCredentials(for: genericCredentials.credentialType)

		XCTAssertEqual(storedCredentials.username, genericCredentials.username)
		XCTAssertEqual(storedCredentials.password, genericCredentials.password)
		XCTAssertEqual(storedCredentials.credentialType, genericCredentials.credentialType)
	}

	func testCUpdating() throws {
		let updatedCredentials = genericCredentials.makeUpdatedCredentials(username: "anotherUser")

		XCTAssertNotEqual(updatedCredentials.username, genericCredentials.username)

		try KeychainManager.shared.updateCredentials(updatedCredentials)
		let storedCredentials: Credentials = try KeychainManager.shared.fetchCredentials(for: genericCredentials.credentialType)

		XCTAssertEqual(storedCredentials.username, updatedCredentials.username)
		XCTAssertEqual(storedCredentials.password, updatedCredentials.password)
		XCTAssertEqual(storedCredentials.credentialType, updatedCredentials.credentialType)
	}

	func testDDeleting() throws {
		try KeychainManager.shared.deleteCredentials(for: genericCredentials.credentialType)
	}

}
