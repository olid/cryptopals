//
//  Base64.swift
//  CryptoPals
//
//  Created by Oliver Donald on 25/07/2022.
//

import Foundation

struct Base64 {
    private static func sextetToSymbol(sextet: Byte) -> String {
        switch sextet {
            case 0...25: return String(format: "%c", sextet + 65)
            case 26...51: return String(format: "%c", sextet + 97 - 26)
            case 52...61: return String(format: "%c", sextet + 48 - 52)
            case 62: return "+"
            case 63: return "/"
            default: fatalError("Sextet '\(sextet)' out of range")
        }
    }
    
    private static func symbolToSextet(symbol: Byte) -> Byte {
        switch symbol {
            case 65...90: return symbol - 65
            case 97...122: return symbol - 97 + 26
            case 48...57: return symbol - 48 + 52
            case 43: return 62
            case 47: return 63
            case 61: return 0
            default: fatalError("Symbol '\(symbol)' out of range")
        }
    }
    
    static func encode(bytes: ByteArray) -> String {
        let octetCount = bytes.count
        let sextetCount = (octetCount * 8 + 5) / 6
        let paddedBytes = bytes + [0x00]
        
        let sextets = (0..<sextetCount).map { index in
            let octetIndex = index * 6 / 8
            
            switch index % 4 {
                case 0: return paddedBytes[octetIndex] >> 2
                case 1: return ((paddedBytes[octetIndex] & 0x3) << 4) + (paddedBytes[octetIndex + 1] >> 4)
                case 2: return ((paddedBytes[octetIndex] & 0xf) << 2) + (paddedBytes[octetIndex + 1] >> 6)
                case 3: return (paddedBytes[octetIndex] << 2) >> 2
                default: fatalError()
            }
        }
        
        switch sextets.count % 4 {
            case 3: return sextets.map { sextet in sextetToSymbol(sextet: sextet) }.joined() + "="
            case 2: return sextets.map { sextet in sextetToSymbol(sextet: sextet) }.joined() + "=="
            default: return sextets.map { sextet in sextetToSymbol(sextet: sextet) }.joined()
        }
    }
    
    static func decode(string: String) -> ByteArray {
        let utf8Bytes = string.utf8Bytes.filter { byte in byte != 10 }
        let bytes = utf8Bytes.map { byte in symbolToSextet(symbol: byte) }
        let sextetCount = utf8Bytes.filter { byte in byte != 61 }.count
        let octetCount = sextetCount * 6 / 8
        
        let octets = (0..<octetCount).map { index in
            let sextetIndex = index * 8 / 6
            
            switch index % 3 {
                case 0: return (bytes[sextetIndex] << 2) + (bytes[sextetIndex + 1] >> 4)
                case 1: return (bytes[sextetIndex] << 4) + (bytes[sextetIndex + 1] >> 2)
                case 2: return (bytes[sextetIndex] << 6) + (bytes[sextetIndex + 1])
                default: fatalError()
            }
        }
        
        return octets
    }
}
