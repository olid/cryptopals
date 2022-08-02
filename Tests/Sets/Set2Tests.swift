//
//  Set1.swift
//  Tests
//
//  Created by olid on 25/07/2022.
//

import XCTest

final class Set2Tests: XCTestCase {
    func testPart1() throws {
        let input = "YELLOW SUBMARINE".utf8Bytes
        let padded = PKCS7.pad(bytes: input, length: 20)
        
        XCTAssertEqual(padded.description, "YELLOW SUBMARINE\\x04\\x04\\x04\\x04")
    }
    
    func testPart2() throws {
        let cypherText = _set2Challenge2.parseAsBase64String
        let key = "YELLOW SUBMARINE".utf8Bytes
        let iv = ByteArray([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        
        let decrypted = Aes.Cbc.decrypt(input: cypherText, key: key, iv: iv)
        
        XCTAssertTrue(decrypted.description.starts(with: "I'm back and I'm ringin' the bell"))
    }
}
