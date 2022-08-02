//
//  PKCS7Tests.swift
//  Tests
//
//  Created by Oliver Donald on 02/08/2022.
//

import XCTest

final class PKCS7Tests: XCTestCase {
    func testPadding_NotRequired() throws {
        let input = "0123456789abcdef".utf8Bytes
        let padded = PKCS7.pad(bytes: input)
        
        XCTAssertEqual(padded, input)
    }
    
    func testSingleXor() throws {
        XCTAssertEqual(PKCS7.pad(bytes: "0123456789abcde".utf8Bytes), ByteArray([48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 1]))
        XCTAssertEqual(PKCS7.pad(bytes: "0123456789abc".utf8Bytes), ByteArray([48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 3, 3, 3]))
        XCTAssertEqual(PKCS7.pad(bytes: "012345".utf8Bytes), ByteArray([48, 49, 50, 51, 52, 53, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]))
        XCTAssertEqual(PKCS7.pad(bytes: "0".utf8Bytes), ByteArray([48, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15]))
    }
}
