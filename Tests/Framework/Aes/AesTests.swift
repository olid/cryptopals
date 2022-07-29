//
//  AesTests.swift
//  Tests
//
//  Created by olid on 27/07/2022.
//

import XCTest

final class AesTests: XCTestCase {
    func testSingleRound() throws {
        let plainText = "Two One Nine Two".utf8Bytes
        let key = "Thats my Kung Fu".utf8Bytes
        
        let keys = RoundKey(byteArray: key).buildKeys().map { key in key.toState }
        let state = AesState(byteArray: plainText).add(key: keys[0])
        
        let result = state.applyRound(key: keys[1])
                
        XCTAssertEqual(result.bytes, [0x58, 0x47, 0x08, 0x8b, 0x15, 0xb6, 0x1c, 0xba, 0x59, 0xd4, 0xe2, 0xe8, 0xcd, 0x39, 0xdf, 0xce])
    }
}
