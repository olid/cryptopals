//
//  Aes.swift
//  CryptoPals
//
//  Created by olid on 27/07/2022.
//

import Foundation


struct Aes {
    static func decrypt(input: ByteArray, key: ByteArray) -> ByteArray {
        let state = AesState(byteArray: input)
        let keys = RoundKey(byteArray: key).buildKeys().map { key in key.toState }
        
        return (1...10)
            .reduce(state.add(key: keys[0])) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
            .bytes
    }
}



