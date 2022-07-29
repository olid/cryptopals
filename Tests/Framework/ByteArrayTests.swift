//
//  Tests.swift
//  Tests
//
//  Created by Oliver Donald on 25/07/2022.
//

import XCTest

final class ByteArrayTests: XCTestCase {
    func testParse() throws {
        XCTAssertEqual([0x01, 0x05, 0xff], ByteArray.parse(string: "0105ff"))
    }
    
    func testToHexString() throws {
        XCTAssertEqual([0x01, 0x05, 0xff].toHexString, "0105ff")
    }                
    
    func testHammingDistance() throws {
        let a = "this is a test".utf8Bytes
        let b = "wokka wokka!!!".utf8Bytes
        
        let distance = a.hammingDistance(to: b)
        
        XCTAssertEqual(distance, 37)
    }
}
