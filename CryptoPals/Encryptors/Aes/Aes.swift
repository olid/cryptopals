//
//  Aes.swift
//  CryptoPals
//
//  Created by olid on 27/07/2022.
//

import Foundation

// AES encryption step-by-step: https://www.kavaliro.com/wp-content/uploads/2014/03/AES.pdf
// Key schedule: https://en.wikipedia.org/wiki/AES_key_schedule
// SBox reference: https://en.wikipedia.org/wiki/Rijndael_S-box
// Mix columns algo: https://en.wikipedia.org/wiki/Rijndael_MixColumns

struct Aes {
    static func decrypt(input: ByteArray, key: ByteArray) -> ByteArray {
        let state = AesState(byteArray: input)
        let keys = RoundKey(byteArray: key)
            .buildKeys()
            .map { key in key.toState }
        
        return (1...10)
            .reduce(state.add(key: keys[0])) { state, round in state.applyRound(key: keys[round], roundNumber: round) }
            .bytes
    }
}



