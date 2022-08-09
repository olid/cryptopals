//
//  Byte.swift
//  CryptoPals
//
//  Created by Oliver Donald on 04/08/2022.
//

import Foundation

typealias Byte = UInt8

extension Byte {
    static var random: Byte { Byte(arc4random_uniform(0xff)) }
    
    func repeating(_ times: Int) -> ByteArray {
        return Array(repeating: self, count: times)
    }
    
    var toHex: String { String(format: "%02x", self) }
    var toBinary: String { String(self, radix: 2) }
}
