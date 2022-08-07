//
//  AesTests.swift
//  Tests
//
//  Created by olid on 27/07/2022.
//

import XCTest

final class AesCbcTests: XCTestCase {
    func testEncryptDecrypt() throws {
        let plainText = "This is a longer string that spans a few blocks".utf8Bytes
        let key = "Thats my Kung Fu".utf8Bytes
        
        let encrypted = Aes.Cbc().encrypt(input: plainText, key: key, iv: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        let decrypted = Aes.Cbc().decrypt(input: encrypted, key: key, iv: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        
        XCTAssertEqual(decrypted, plainText + [0x1])
    }
}

