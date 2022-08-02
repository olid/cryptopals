//
//  PKCS7.swift
//  CryptoPals
//
//  Created by Oliver Donald on 02/08/2022.
//

import Foundation

struct PKCS7 {
    static func pad(bytes: ByteArray, length: Int = 16) -> ByteArray {
        let error = bytes.count % length
        if error == 0 { return bytes }
        
        let missing = length - error
        
        return bytes + Array(repeating: Byte(missing), count: missing)
    }
}
