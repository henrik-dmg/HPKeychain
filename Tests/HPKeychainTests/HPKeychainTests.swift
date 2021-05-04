import XCTest
@testable import HPKeychain

final class HPKeychainTests: XCTestCase {

	private let genericCredentials = Credential(username: "hpanhans", password: "someTestingPassword", credentialType: .generic(service: "com.henrikpanhans.HPKeychain"))

	func testAAddingKeychainItem() {
		XCTAssertNoThrow(try KeychainManager.shared.storeCredential(genericCredentials))
	}

	func testBFetching() throws {
		let storedCredentials: Credential = try KeychainManager.shared.fetchCredential(for: genericCredentials.credentialType)

		XCTAssertEqual(storedCredentials.username, genericCredentials.username)
		XCTAssertEqual(storedCredentials.password, genericCredentials.password)
		XCTAssertEqual(storedCredentials.credentialType, genericCredentials.credentialType)
	}

	func testCUpdating() throws {
		let updatedCredentials = genericCredentials.makeUpdatedCredentials(username: "anotherUser")

		XCTAssertNotEqual(updatedCredentials.username, genericCredentials.username)

		try KeychainManager.shared.updateCredential(updatedCredentials)
		let storedCredentials: Credential = try KeychainManager.shared.fetchCredential(for: genericCredentials.credentialType)

		XCTAssertEqual(storedCredentials.username, updatedCredentials.username)
		XCTAssertEqual(storedCredentials.password, updatedCredentials.password)
		XCTAssertEqual(storedCredentials.credentialType, updatedCredentials.credentialType)
	}

	func testDDeleting() throws {
		try KeychainManager.shared.deleteCredential(for: genericCredentials.credentialType)
	}

}
