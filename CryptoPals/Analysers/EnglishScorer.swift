//
//  Analysers.swift
//  CryptoPals
//
//  Created by olid on 25/07/2022.
//

import Foundation

struct EnglishScorer {
    static func score(bytes: ByteArray) -> Double {
        return bytes.reduce(0) { total, byte in total + LetterFrequencies.english[Int(byte)] }
    }
}
