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
            let keys = AesInitialKey(byteArray: key)
                .buildKeys()
            
            return input
                .chunked(by: 16)
                .map { block in encrypt(block: block, keys: keys) }
                .flatMap { $0 }
        }
        
        private static func encrypt(block: ByteArray, keys: [AesKey]) -> ByteArray {
            let state = AesEncryptionState(byteArray: block)
            
            return (1...10)
                .reduce(state.apply(key: keys[0])) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
                .bytes
        }
        
        static func decrypt(input: ByteArray, key: ByteArray) -> ByteArray {
            let keys = Array(AesInitialKey(byteArray: key)
                .buildKeys()
                .reversed())
            
            return input
                .chunked(by: 16)
                .map { block in decrypt(block: block, keys: keys) }
                .flatMap { $0 }
        }
        
        private static func decrypt(block: ByteArray, keys: [AesKey]) -> ByteArray {
            let state = AesDecryptionState(byteArray: block)
            
            return (0...9)
                .reduce(state) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
                .apply(key: keys[10])
                .bytes
        }
    }
}
