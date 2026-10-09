import Foundation
import Testing

@testable import HPKeychain

struct HPKeychainTests {

    let credential = UsernamePasswordCredential(username: "hpanhans", password: "someTestingPassword".data(using: .utf8)!)

    // Testing creates a new instance for each test, so every test gets its own keychain item.
    // This lets the tests run in parallel on the real keychain without interference.
    let query = GenericPasswordQuery(serviceIdentifier: "dev.panhans.HPKeychain.tests.\(UUID().uuidString)")

    @Test
    func addingKeychainItem() throws {
        try KeychainManager.shared.deleteCredential(with: query)
        defer { try? KeychainManager.shared.deleteCredential(with: query) }

        try KeychainManager.shared.save(credential, for: query)
    }

    @Test
    func fetching() throws {
        try KeychainManager.shared.deleteCredential(with: query)
        defer { try? KeychainManager.shared.deleteCredential(with: query) }
        try KeychainManager.shared.save(credential, for: query)

        let storedCredentials = try KeychainManager.shared.credentials(for: query)

        #expect(storedCredentials.count == 1)

        let firstItem = try #require(storedCredentials.first)
        #expect(firstItem.username == credential.username)
        #expect(firstItem.password == credential.password)
    }

    @Test
    func updating() throws {
        try KeychainManager.shared.deleteCredential(with: query)
        defer { try? KeychainManager.shared.deleteCredential(with: query) }
        try KeychainManager.shared.save(credential, for: query)

        let updatedCredentials = UsernamePasswordCredential(username: "aNewUsername", password: "someTestingPassword".data(using: .utf8)!)

        try KeychainManager.shared.update(updatedCredentials, for: query)
        let storedCredentials = try KeychainManager.shared.credentials(for: query)

        #expect(storedCredentials.count == 1)

        let firstItem = try #require(storedCredentials.first)
        #expect(firstItem.username == updatedCredentials.username)
        #expect(firstItem.password == updatedCredentials.password)
    }

    @Test
    func deleting() throws {
        try KeychainManager.shared.deleteCredential(with: query)
        try KeychainManager.shared.save(credential, for: query)

        try KeychainManager.shared.deleteCredential(with: query)

        #expect(try KeychainManager.shared.credentials(for: query).isEmpty)
    }

}
