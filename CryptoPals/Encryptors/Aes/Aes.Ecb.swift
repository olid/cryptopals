//
//  Aes.swift
//  CryptoPals
//
//  Created by olid on 27/07/2022.
//

import Foundation


extension Aes {
    struct Ecb {
        static func encrypt(input: ByteArray, key: ByteArray) -> ByteArray {
            let state = AesEncryptionState(byteArray: input)
            let keys = AesInitialKey(byteArray: key)
                .buildKeys()
            
            return (1...10)
                .reduce(state.apply(key: keys[0])) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
                .bytes
        }
        
        static func decrypt(input: ByteArray, key: ByteArray) -> ByteArray {
            let keys = Array(AesInitialKey(byteArray: key)
                .buildKeys()
                .reversed())
            
            let parts = input.chunked(by: 16).map { chunk in decryptInternal(input: chunk, keys: keys) }
            
            return parts.flatMap { $0 }
        }
        
        static func decryptInternal(input: ByteArray, keys: [AesKey]) -> ByteArray {
            let state = AesDecryptionState(byteArray: input)
            
            return (0...9)
                .reduce(state) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
                .apply(key: keys[10])
                .bytes
        }
    }
}
