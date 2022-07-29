//
//  StringExtensions.swift
//  CryptoPals
//
//  Created by olid on 25/07/2022.
//

import Foundation

extension String {
    var parseAsByteArray: ByteArray {
        return ByteArray.parse(string: self)
    }
    
    var parseAsBase64String: ByteArray {
        return Base64.decode(string: self)
    }
    
    var utf8Bytes: ByteArray {
        return Array(self.utf8)
    }
}
