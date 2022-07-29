//
//  SingleXorDecryptor.swift
//  CryptoPals
//
//  Created by Oliver Donald on 26/07/2022.
//

import Foundation
import Algorithms

typealias XorDecryptorResult = (decrypted: ByteArray, key: [Byte], score: Double)

struct XorDecryptor {
    static func decryptSingleByteKey(input: ByteArray) -> (decrypted: ByteArray, key: Byte, score: Double) {
        let best = (0...0xff)
            .map { key in (key: Byte(key), decoded: Xor.encrypt(input: input, key: key)) }
            .map { candidate in (key: candidate.key, score: EnglishScorer.score(bytes: candidate.decoded), decoded: candidate.decoded) }
            .sorted { a, b in a.score > b.score }
            .first!
        
        return (best.decoded, best.key, best.score)
    }
    
    static func decryptMultiByteKey(input: ByteArray, maxKeyLength: Int = 40) -> XorDecryptorResult {
        let keySize = estimateKeySize(for: input, maxKeyLength: maxKeyLength)
        
        let key = input.chunked(by: keySize)
            .transpose()
            .map { block in decryptSingleByteKey(input: block).key }
        
        let decrypted = Xor.encrypt(input: input, key: key)
        
        return (decrypted, key, 0)
    }
    
    private static func estimateKeySize(for cypherText: ByteArray, maxKeyLength: Int) -> Int {
        return (1...maxKeyLength)
            .map { keyLength in (length: keyLength, distance: getKeyLengthError(for: cypherText, keyLength: keyLength)) }
            .sorted { a, b in a.distance < b.distance }
            .first!
            .length
    }
    
    private static func getKeyLengthError(for cypherText: ByteArray, keyLength: Int) -> Double {
        let reciprocal = 1.0 / Double(keyLength)
        let blocks = cypherText.chunked(by: keyLength)
        
        let totalDistance = zip(blocks, blocks[1...])
            .map { pair in Double(pair.0.hammingDistance(to: pair.1)) * reciprocal }
            .reduce(0.0, +)
                
        return totalDistance / Double(blocks.count)
    }
}
