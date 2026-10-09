# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

HPKeychain is a small Swift package (swift-tools-version 6.4, no dependencies) that wraps the Security framework keychain API. It supports iOS 15, tvOS 15, macOS 12, watchOS 9 and visionOS 1.

## Commands

```bash
swift build
swift test
swift test --filter HPKeychainTests/fetching   # single test
```

The tests use the Testing framework and the real keychain. Each test uses its own random service identifier and removes its item at the end, so the tests are independent and run in parallel. Keep this isolation when you add a test.

Formatting uses `.swift-format` (4 spaces, line length 160).

## Architecture

The "Big rewrite" commit replaced the old API. The README still documents the old one (`fetchCredential`, `CredentialType`, `storeCredential`). The current API is described below.

The design separates two concerns: what a credential contains, and how to find it in the keychain.

- `Credential` (protocol, `Credentials/`): turns itself into keychain attributes through `attributes()`. `UsernamePasswordCredential` is the only implementation (`kSecAttrAccount` plus `kSecValueData`).
- `CredentialQuery` (protocol, `Queries/`): has a primary associated type `Credential`. It builds the lookup attributes through `queryItems()` and maps a keychain result back to a credential through `credential(from:)`. `GenericPasswordQuery` (service identifier) and `InternetPasswordQuery` (server) are the implementations.
- `QueryItem` (`Queries/QueryItem.swift`): one keychain key and value pair, for example `Service`, `Server`, `GenericPasswordClass`. `@QueryItemBuilder` is a result builder that lets `queryItems()` list these items declaratively.
- `Keychain`: the only entry point. `save`, `update` and `deleteCredential` take a query. `save` and `update` also take a credential. `credentials(for:)` returns `[C]` for the query's credential type. It returns an empty array, not an error, when nothing matches.

To support a new keychain item type, add a `Credential` and a `CredentialQuery`. Add new `QueryItem` types only when you need a new `kSecAttr*` key. Do not change `Keychain`.

`KeychainError` is internal (not `public`), so callers cannot match its cases. `update` maps `errSecItemNotFound` to `.noItem`. `deleteCredential` treats a missing item as success.

## CI

`.github/workflows/swift.yml` builds and tests. `documentation.yml` publishes documentation.
