//
//  Aes.Random.swift
//  CryptoPals
//
//  Created by Oliver Donald on 04/08/2022.
//

import Foundation

typealias AesRandomResult = (cypherText: ByteArray, mode: AesMode)

extension Aes {
    struct Random {        
        static func randomEcbCbcEncrypt(plainText: ByteArray) -> AesRandomResult {
            let mode: AesMode = .random
            let key: ByteArray = .random(length: 16)
            let iv: ByteArray = .random(length: 16)
            
            let padded = .random(length: .random(in: (5...10))) + plainText + .random(length: .random(in: (5...10)))
            
            switch mode {
                case .cbc: return (cypherText: Aes.Cbc().encrypt(input: padded, key: key, iv: iv), mode: .cbc)
                case .ecb: return (cypherText: Aes.Ecb().encrypt(input: padded, key: key), mode: .ecb)
            }
        }
    }
}
