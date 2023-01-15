import XCTest
@testable import HPKeychain

final class HPKeychainTests: XCTestCase {

    let credential = UsernamePasswordCredential(username: "hpanhans", password: "someTestingPassword".data(using: .utf8)!)
    let query = GenericPasswordQuery(serviceIdentifier: "dev.panhans.HPKeychain")

	func testAAddingKeychainItem() {
        XCTAssertNoThrow(try KeychainManager.shared.save(credential, for: query))
	}

	func testBFetching() throws {
        let storedCredentials = try KeychainManager.shared.credentials(for: query)

        XCTAssertEqual(storedCredentials.count, 1)

        let firstItem = try XCTUnwrap(storedCredentials.first)
		XCTAssertEqual(firstItem.username, credential.username)
		XCTAssertEqual(firstItem.password, credential.password)
	}

	func testCUpdating() throws {
		let updatedCredentials = UsernamePasswordCredential(username: "aNewUsername", password: "someTestingPassword".data(using: .utf8)!)

		try KeychainManager.shared.update(updatedCredentials, for: query)
		let storedCredentials = try KeychainManager.shared.credentials(for: query)

        XCTAssertEqual(storedCredentials.count, 1)

        let firstItem = try XCTUnwrap(storedCredentials.first)
		XCTAssertEqual(firstItem.username, updatedCredentials.username)
		XCTAssertEqual(firstItem.password, updatedCredentials.password)
	}

	func testDDeleting() throws {
		try KeychainManager.shared.deleteCredential(with: query)
	}

}
