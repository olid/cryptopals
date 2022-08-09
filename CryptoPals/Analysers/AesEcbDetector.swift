//
//  AesEcbDetector.swift
//  CryptoPals
//
//  Created by Oliver Donald on 02/08/2022.
//

import Foundation

typealias AesEcbDetecionResult = (cypherText: ByteArray, error: Int)

struct AesEcbDetector {
    static func detect(candidates: ByteArrayCollection) -> [AesEcbDetecionResult] {
        return candidates
            .map { candidate in score(cypherText: candidate) }
            .sorted { a, b in a.error < b.error }
    }
    
    private static func score(cypherText: ByteArray) -> AesEcbDetecionResult {
        let blocks = cypherText.chunked(by: 16)
        
        let error = blocks
            .flatMap { block in blocks.map { other in block == other ? 1 : 0 } }
            .reduce(0) { total, error in total + error }
        
        return (cypherText: cypherText, error: error)
    }
}
