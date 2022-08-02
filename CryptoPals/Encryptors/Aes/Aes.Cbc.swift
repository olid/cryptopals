//
//  Aes.swift
//  CryptoPals
//
//  Created by olid on 27/07/2022.
//

import Foundation

private struct DecryptionState {
    let decryptedBlocks: ByteArrayCollection
    let lastBlock: ByteArray?
    
    init() {
        decryptedBlocks = []
        lastBlock = nil
    }
    
    private init(decrypted: ByteArrayCollection, lastBlock: ByteArray?) {
        self.decryptedBlocks = decrypted
        self.lastBlock = lastBlock
    }
    
    func add(cypherBlock: ByteArray, decrypted: ByteArray) -> DecryptionState {
        return DecryptionState(decrypted: decryptedBlocks + [decrypted], lastBlock: cypherBlock)
    }
}

extension Aes {
    struct Cbc {
        static func encrypt(input: ByteArray, key: ByteArray, iv: ByteArray) -> ByteArray {
            let paddedInput = PKCS7.pad(bytes: input)
            let keys = AesInitialKey(byteArray: key)
                .buildKeys()
            
            return paddedInput
                .chunked(by: 16)
                .reduce(ByteArrayCollection()) { encryptedBlocks, block in
                    let iv = InitVector(byteArray: encryptedBlocks.last ?? iv)
                    return encryptedBlocks + [encrypt(block: block, keys: keys, iv: iv)]
                }
                .flatMap { $0 }
        }
        
        private static func encrypt(block: ByteArray, keys: [AesKey], iv: InitVector) -> ByteArray {
            let state = AesEncryptionState(byteArray: block).apply(iv: iv)
            
            return (1...10)
                .reduce(state.apply(key: keys[0])) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
                .bytes
        }
        
        static func decrypt(input: ByteArray, key: ByteArray, iv: ByteArray) -> ByteArray {
            let paddedInput = PKCS7.pad(bytes: input)
            let keys = Array(AesInitialKey(byteArray: key)
                .buildKeys()
                .reversed())
            
            return paddedInput
                .chunked(by: 16)
                .reduce(DecryptionState()) { state, block in
                    let iv = InitVector(byteArray: state.lastBlock ?? iv)
                    return state.add(cypherBlock: block, decrypted: decrypt(block: block, keys: keys, iv: iv))
                }
                .decryptedBlocks
                .flatMap { $0 }
        }
        
        private static func decrypt(block: ByteArray, keys: [AesKey], iv: InitVector) -> ByteArray {
            let state = AesDecryptionState(byteArray: block)
            
            return (0...9)
                .reduce(state) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
                .apply(key: keys[10])
                .apply(iv: iv)
                .bytes
        }
    }
}
