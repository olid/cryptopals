//
//  PKCS7.swift
//  CryptoPals
//
//  Created by Oliver Donald on 02/08/2022.
//

import Foundation

struct PKCS7 {
    static func pad(bytes: ByteArray, length: Int = 16) -> ByteArray {
        let missing = length - (bytes.count % length)
        
        return bytes + Array(repeating: Byte(missing), count: missing)
    }
    
    static func unpad(bytes: ByteArray, length: Int = 16) -> ByteArray {
        let index = bytes.count - Int(bytes.last!)
        return ByteArray(bytes[..<index])
    }
}

extension ByteArray {
    func padded(length: Int = 16) -> ByteArray {
        return PKCS7.pad(bytes: self, length: length)
    }
    
    func unpadded(length: Int = 16) -> ByteArray {
        return PKCS7.unpad(bytes: self, length: length)
    }
}
