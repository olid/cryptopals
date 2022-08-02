//
//  AesTests.swift
//  Tests
//
//  Created by olid on 27/07/2022.
//

import XCTest

final class AesEcbTests: XCTestCase {
    func testAesEbc() throws {
        let plainText = "Two One Nine Two".utf8Bytes
        let key = "Thats my Kung Fu".utf8Bytes
        
        let result = Aes.Ecb.encrypt(input: plainText, key: key)
        
        XCTAssertEqual(result, [0x29, 0xc3, 0x50, 0x5f, 0x57, 0x14, 0x20, 0xf6, 0x40, 0x22, 0x99, 0xb3, 0x1a, 0x02, 0xd7, 0x3a])
    }
    
    func testEncryptDecrypt() throws {
        let plainText = "Two One Nine Two".utf8Bytes
        let key = "Thats my Kung Fu".utf8Bytes
        
        let encrypted = Aes.Ecb.encrypt(input: plainText, key: key)
        let decrypted = Aes.Ecb.decrypt(input: encrypted, key: key)
        
        XCTAssertEqual(plainText, decrypted)
    }
}

