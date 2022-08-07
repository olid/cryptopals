//
//  Set1.swift
//  Tests
//
//  Created by olid on 25/07/2022.
//

import XCTest

final class Set2Tests: XCTestCase {
    func testPart9() throws {
        let input = "YELLOW SUBMARINE".utf8Bytes
        let padded = PKCS7.pad(bytes: input, length: 20)
        
        XCTAssertEqual(padded.description, "YELLOW SUBMARINE\\x04\\x04\\x04\\x04")
    }
    
    func testPart10() throws {
        let cypherText = _set2Challenge2.parseAsBase64String
        let key = "YELLOW SUBMARINE".utf8Bytes
        let iv = ByteArray([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        
        let decrypted = Aes.Cbc().decrypt(input: cypherText, key: key, iv: iv)
        
        XCTAssertTrue(decrypted.description.starts(with: "I'm back and I'm ringin' the bell"))
    }
    
    func testPart11() throws {
        let plainText = "0123456789abcdef0123456789abcdef0123456789abcdef".utf8Bytes
        
        let correct = (1...10).reduce(0) { count, _ in
            let (cypherText, actualMode) = Aes.Random.randomEcbCbcEncrypt(plainText: plainText)
            let estimatedMode = EcbCbcOracle.detectModeFor(cypherText: cypherText)
            
            return (estimatedMode == actualMode) ? count + 1 : 0
        }
        
        XCTAssertEqual(correct, 10)
    }
    
    func testPart12() throws {
        let unknownText = _set2Challenge3.parseAsBase64String
        
        let answer = AesEcbDecryptor(keySize: 16).decrypt(unknownText: unknownText)
        let expected = String(format: "Rollin' in my 5.0\u{0a}With my rag-top down so my hair can blow\u{0a}The girlies on standby waving just to say hi\u{0a}Did you stop? No, I just drove by\u{0a}")
        
        XCTAssertEqual(answer, expected.utf8Bytes)
    }
}


