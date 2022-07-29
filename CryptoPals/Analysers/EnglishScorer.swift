//
//  Analysers.swift
//  CryptoPals
//
//  Created by Oliver Donald on 25/07/2022.
//

import Foundation

struct EnglishScorer {
    static func score(bytes: ByteArray) -> Double {
        return bytes.reduce(0) { total, byte in total + LetterFrequencies.english[Int(byte)] }
    }
}
