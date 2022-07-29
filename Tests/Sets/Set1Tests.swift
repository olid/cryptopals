//
//  Set1.swift
//  Tests
//
//  Created by olid on 25/07/2022.
//

import XCTest

final class Set1Tests: XCTestCase {
    func testPart1() throws {
        let input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
        let output = Base64.encode(bytes: input.parseAsByteArray)
        
        XCTAssertEqual(output, "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t")
    }
    
    func testPart2() throws {
        let a = "1c0111001f010100061a024b53535009181c".parseAsByteArray
        let b = "686974207468652062756c6c277320657965".parseAsByteArray
        
        XCTAssertEqual(Xor.encrypt(input: a, key: b), "746865206b696420646f6e277420706c6179".parseAsByteArray)
    }
    
    func testPart3() throws {
        let coded = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736".parseAsByteArray
        
        let best = XorDecryptor.decryptSingleByteKey(input: coded)
        
        XCTAssertEqual(best.decrypted.toString, "Cooking MC's like a pound of bacon")
    }
    
    func testPart4() throws {
        let candidates = _set1Challenge4.components(separatedBy: .newlines)
        
        let best = candidates
            .map { candidate in XorDecryptor.decryptSingleByteKey(input: candidate.parseAsByteArray) }
            .sorted { a, b in a.score > b.score }
            .first!
        
        XCTAssertEqual(best.decrypted.toString, "Now that the party is jumping\n")
    }
    
    func testPart5() throws {
        let key = "ICE".utf8Bytes
        let input = """
            Burning 'em, if you ain't quick and nimble
            I go crazy when I hear a cymbal
            """
        
        let encoded = Xor.encrypt(input: input.utf8Bytes, key: key)
        
        XCTAssertEqual(encoded.toHexString, "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f")
    }
    
    func testPart6() throws {
        let cypherText = _set1Challenge6.parseAsBase64String
        
        let decrypted = XorDecryptor.decryptMultiByteKey(input: cypherText)
        
        XCTAssertEqual(decrypted.key.toString, "Terminator X: Bring the noise")
    }
}
