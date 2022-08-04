//
//  EcbCdcOracle.swift
//  CryptoPals
//
//  Created by Oliver Donald on 04/08/2022.
//

import Foundation

enum AesMode: CaseIterable {
    case ecb
    case cbc
    
    static var random: AesMode { self.allCases.randomElement()! }
}

struct EcbCbcOracle {
    static func detectModeFor(cypherText: ByteArray) -> AesMode {
        guard cypherText.count >= 64 else { fatalError("Requires at least 64 bytes for good result") }
        
        let chunks = cypherText.chunked(by: 16)
        
        return chunks[1] == chunks[2] ? .ecb : .cbc
    }
}
