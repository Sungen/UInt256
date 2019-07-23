//
//  UInt256+Hashable.swift
//  UInt256
//
//  Created by Sjors Provoost on 06-07-14.
//

// TODO: Add tests for this.
extension UInt256: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(toHexString.hashValue)
    }
    
}
