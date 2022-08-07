//
//  AesEcbDecryptor.swift
//  CryptoPals
//
//  Created by Oliver Donald on 04/08/2022.
//

import Foundation

struct AesEcbDecryptor {
    let padding: ByteArray
    let keySize: Int
    let dictionary: [ByteArray: ByteArray]
    let randomKey: ByteArray
    
    init(keySize: Int) {
        self.keySize = keySize
        
        let randomKey = ByteArray.random(length: keySize)
        let pairs = (0...0xff).map { index in
            let byte = Byte(index)
            let key = ByteArray(repeating: 0, count: keySize - 1) + [byte]
            let encrypted = Aes.Ecb().encrypt(input: key, key: randomKey)
            return (key, encrypted)
        }
        
        self.padding = ByteArray(repeating: 0, count: keySize - 1)
        self.randomKey = randomKey
        self.dictionary = Dictionary(uniqueKeysWithValues: pairs)
    }
    
    func decrypt(unknownText: ByteArray) -> ByteArray {
        return (0..<unknownText.count).map { index in
            decryptByteIn(unknownText: unknownText, atIndex: index)
        }
    }
    
    func decryptByteIn(unknownText: ByteArray, atIndex: Int) -> Byte {
        let input = padding + [unknownText[atIndex]]
        
        for index in (0...0xff) {
            let byte = Byte(index)
            let encrypted = Aes.Ecb().encrypt(input: input, key: randomKey)
            let key = ByteArray(repeating: 0, count: keySize - 1) + [byte]
            
            if encrypted == dictionary[key] {
                return byte
            }
        }
        
        fatalError("No matching dictionary entry")
    }
}


