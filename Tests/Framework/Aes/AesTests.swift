//
//  AesTests.swift
//  Tests
//
//  Created by Oliver Donald on 27/07/2022.
//

import XCTest

final class AesTests: XCTestCase {
    func testRoundKey() throws {
        let key = "Thats my Kung Fu".utf8Bytes
        let plainText = "Two One Nine Two".utf8Bytes
        
        let roundKey = RoundKey(byteArray: key)
        
        print(roundKey)
    }
}
