//
//  Xor.swift
//  CryptoPals
//
//  Created by olid on 27/07/2022.
//

import Foundation

struct Xor {
    static func encrypt(input: ByteArray, key: Byte) -> ByteArray {
        return input.map { byte in
            byte ^ key
        }
    }
    
    static func encrypt(input: ByteArray, key: ByteArray) -> ByteArray {
        let keyLength = key.count
        
        return input.enumerated().map { index, byte in
            byte ^ key[index % keyLength]
        }
    }
    
    static func decrypt(input: ByteArray, key: Byte) -> ByteArray {
        return input.map { byte in
            byte ^ key
        }
    }
    
    static func decrypt(input: ByteArray, key: ByteArray) -> ByteArray {
        let keyLength = key.count
        
        return input.enumerated().map { index, byte in
            byte ^ key[index % keyLength]
        }
    }
}
