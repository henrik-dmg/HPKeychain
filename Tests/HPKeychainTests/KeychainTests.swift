import Foundation
import Testing

@testable import HPKeychain

struct KeychainTests {

    let credential = UsernamePasswordCredential(username: "hpanhans", password: "someTestingPassword".data(using: .utf8)!)

    // Testing creates a new instance for each test, so every test gets its own keychain item.
    // This lets the tests run in parallel on the real keychain without interference.
    let query = GenericPasswordQuery(serviceIdentifier: "dev.panhans.HPKeychain.tests.\(UUID().uuidString)")

    @Test
    func addingKeychainItem() throws {
        try Keychain.deleteAll(matching: query)
        defer { try? Keychain.deleteAll(matching: query) }

        try Keychain.save(credential, for: query)
    }

    @Test
    func fetching() throws {
        try Keychain.deleteAll(matching: query)
        defer { try? Keychain.deleteAll(matching: query) }
        try Keychain.save(credential, for: query)

        let storedCredentials = try Keychain.credentials(for: query)

        #expect(storedCredentials.count == 1)

        let firstItem = try #require(storedCredentials.first)
        #expect(firstItem.username == credential.username)
        #expect(firstItem.password == credential.password)
    }

    @Test
    func updating() throws {
        try Keychain.deleteAll(matching: query)
        defer { try? Keychain.deleteAll(matching: query) }
        try Keychain.save(credential, for: query)

        let updatedCredentials = UsernamePasswordCredential(username: "aNewUsername", password: "someTestingPassword".data(using: .utf8)!)

        try Keychain.update(updatedCredentials, for: query)
        let storedCredentials = try Keychain.credentials(for: query)

        #expect(storedCredentials.count == 1)

        let firstItem = try #require(storedCredentials.first)
        #expect(firstItem.username == updatedCredentials.username)
        #expect(firstItem.password == updatedCredentials.password)
    }

    @Test
    func deleting() throws {
        try Keychain.deleteAll(matching: query)
        try Keychain.save(credential, for: query)

        try Keychain.deleteAll(matching: query)

        #expect(try Keychain.credentials(for: query).isEmpty)
    }

}
