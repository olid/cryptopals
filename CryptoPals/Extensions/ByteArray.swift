//
//  ByteArrat.swift
//  CryptoPals
//
//  Created by olid on 25/07/2022.
//

import Foundation

typealias Byte = UInt8
typealias ByteArray = [Byte]

extension Byte {
    var toHex: String { String(format: "%02x", self) }
    var toBinary: String { String(self, radix: 2) }
}

extension ByteArray {
    static func parse(string: String) -> ByteArray {
        guard string.count.isEven else { fatalError("Cannot parse odd length array") }
        
        let segments = Array(string.utf8)
        
        return stride(from: 0, to: segments.count, by: 2).map { ix in
            UInt8(String(bytes: [segments[ix], segments[ix.advanced(by: 1)]], encoding: .utf8)!, radix: 16)!
        }
    }
    
    var toHexString: String {
        return self
            .map { byte in String(format: "%02x", byte) }
            .joined()
    }
    
    var toString: String {
        return self.map { byte in String(bytes: [byte], encoding: .utf8) ?? "" }.joined()
    }
    
    func chunked(by count: Int) -> [ByteArray] {
        return self.chunks(ofCount: count).filter { chunk in chunk.count == count }.map { chunk in Array(chunk) }
    }        
    
    func hammingDistance(to other: ByteArray) -> Int {
        guard self.count == other.count else { fatalError("Hamming distance must have two strings of equal length") }
        
        return zip(self, other)
            .reduce(0) { total, pair in
                let xor = Int(pair.0 ^ pair.1)
                return total + (0...7).reduce(0) { t, s in t + ((xor >> s) & 0x1) }
            }
    }
}


