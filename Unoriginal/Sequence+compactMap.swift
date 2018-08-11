// Sequence+compactMap.swift

import Foundation

/// Backwards compatibility for Swift 4.1 down to Swift 4.0

extension Sequence {
    
    public func compactMap<ElementOfResult>(_ transform: (Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        return try flatMap(transform)
    }
    
}
