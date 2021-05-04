import Foundation

extension Dictionary {

	@inlinable public func hp_mergingReplacingOldValues(_ other: [Key: Value]) -> [Key: Value] {
		merging(other) { (_, newValue) in newValue }
	}

	@inlinable public func hp_mergingKeepingOldValues(_ other: [Key: Value]) -> [Key: Value] {
		merging(other) { (oldValue, _) in oldValue }
	}

}
