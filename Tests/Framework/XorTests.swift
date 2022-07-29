//
//  XorTests.swift
//  Tests
//
//  Created by Oliver Donald on 27/07/2022.
//

import XCTest

final class XorTests: XCTestCase {
    func testXor() throws {
        let a = "1c0111001f010100061a024b53535009181c".parseAsByteArray
        let b = "686974207468652062756c6c277320657965".parseAsByteArray
        
        XCTAssertEqual(Xor.encrypt(input: a, key: b), "746865206b696420646f6e277420706c6179".parseAsByteArray)
    }
    
    func testSingleXor() throws {
        let a = "This should remain intact".utf8Bytes
        let b = Byte(0x36)
        
        XCTAssertEqual(Xor.encrypt(input: Xor.encrypt(input: a, key: b), key: b).toString, "This should remain intact")
    }
}




