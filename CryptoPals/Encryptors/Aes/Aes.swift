//
//  Aes.swift
//  CryptoPals
//
//  Created by olid on 27/07/2022.
//

import Foundation


struct Aes {
    static func encrypt(input: ByteArray, key: ByteArray) -> ByteArray {
        let state = AesState(byteArray: input)
        let keys = RoundKey(byteArray: key).buildKeys().map { key in key.toState }
        
        let round0State = state.add(key: keys[0])
        
        let done = round0State.applyRound(key: keys[1], roundNumber: 1)
                
        return []
    }
}



