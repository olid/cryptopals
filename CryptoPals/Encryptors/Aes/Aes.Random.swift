//
//  Aes.Random.swift
//  CryptoPals
//
//  Created by Oliver Donald on 04/08/2022.
//

import Foundation

extension Aes {
    struct Random {
        let mode: AesMode = .random
        
        private let key: ByteArray = .random(length: 16)
        private let iv: ByteArray = .random(length: 16)
        
        func encrypt(plainText: ByteArray) -> ByteArray {
            let padded = .random(length: .random(in: (5...10))) + plainText + .random(length: .random(in: (5...10)))
            
            switch mode {
                case .cbc: return Aes.Cbc.encrypt(input: padded, key: key, iv: iv)
                case .ecb: return Aes.Ecb.encrypt(input: padded, key: key)
            }
        }
    }
}
