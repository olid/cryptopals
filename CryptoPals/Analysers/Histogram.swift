//
//  CharacterHistogram.swift
//  CryptoPals
//
//  Created by olid on 25/07/2022.
//

import Foundation

struct Histogram {
    let counts: [Int]
    let frequencies: [Double]
    
    static let english = Histogram(frequencies: LetterFrequencies.english)
    
    init(frequencies: [Double]) {
        guard frequencies.count == 256 else { fatalError("Invalid frequency count") }
        
        self.frequencies = frequencies
        self.counts = frequencies.map { frequency in Int(frequency * 100) }
    }
    
    init(analysing bytes: ByteArray) {
        var histogram = Array(repeating: 0, count: 256)
        
        for byte in bytes {
            histogram[Int(byte)] += 1
        }
        
        let total = histogram.reduce(0) { total, count in total + count }
        
        self.counts = histogram
        self.frequencies = histogram.map { count in total > 0 ? Double(count * 100 / total) : 0 }
    }
    
    func error(versus other: Histogram) -> Double {
        return frequencies
            .enumerated()
            .map { index, frequency in frequency - other.frequencies[index] }
            .reduce(0) { total, error in total + error * error }
    }
}
