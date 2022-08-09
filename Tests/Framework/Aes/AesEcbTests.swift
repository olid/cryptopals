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
        
        let result = Aes.Ecb().encrypt(input: plainText, key: key)
        print(result.toHexString)
        XCTAssertEqual(result, [0x29, 0xc3, 0x50, 0x5f, 0x57, 0x14, 0x20, 0xf6, 0x40, 0x22, 0x99, 0xb3, 0x1a, 0x02, 0xd7, 0x3a,
                                0xb3, 0xe4, 0x6f, 0x11, 0xba, 0x8d, 0x2b, 0x97, 0xc1, 0x87, 0x69, 0x44, 0x9a, 0x89, 0xe8, 0x68])
    }
    
    func testEncryptDecrypt() throws {
        let plainText = "Two One Nine Two".utf8Bytes
        let key = "Thats my Kung Fu".utf8Bytes
        
        let encrypted = Aes.Ecb().encrypt(input: plainText, key: key)
        let decrypted = Aes.Ecb().decrypt(input: encrypted, key: key)
        
        XCTAssertEqual(plainText, decrypted)
    }
}


/*
 
 [41, 195, 80, 95, 87, 20, 32, 246, 64, 34, 153, 179, 26, 2, 215, 58, 179, 228, 111, 17, 186, 141, 43, 151, 193, 135, 105, 68, 154, 137, 232, 104]
 [41, 195, 80, 95, 87, 20, 32, 246, 64, 34, 153, 179, 26, 2, 215, 58]
 
 */
