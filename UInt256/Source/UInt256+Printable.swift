//
//  UInt256+Printable.swift
//  UInt256
//
//  Created by Sjors Provoost on 06-07-14.
//

extension UInt256 {
    
    public var description: String { return toDecimalString }

    public var toDecimalString: String {
        if self == 0 {
            return 0.description
        }
        return BaseConverter.hexToDec(toHexString)
    }

    public var toHexString: String {
        return toHexStringOfLength(nil)
    }

    public func toHexStringOfLength(_ length: Int?) -> String {
        var result: String = ""

        for int in self {
            var paddedHexString = BaseConverter.decToHex(int.description)
            if paddedHexString.count < 8 {
                for _ in 1 ... (8 - paddedHexString.count) {
                    paddedHexString = "0" + paddedHexString
                }
            }

            result += paddedHexString
        }

        // Remove 0 padding
        var unpaddedResult = ""
        var didEncounterFirstNonZeroDigit = false

        for digit in result {
            if digit != "0" {
                didEncounterFirstNonZeroDigit = true
            }
            if didEncounterFirstNonZeroDigit {
                unpaddedResult.append(digit)
            }
        }

        if unpaddedResult == "" {
            unpaddedResult = "0"
        }

        if length != nil {
            let resultLength = unpaddedResult.count
            if resultLength < length! {
                for _ in 0 ..< (length! - resultLength) {
                    unpaddedResult = "0" + unpaddedResult
                }
            }
        }

        return unpaddedResult
    }
    
}
