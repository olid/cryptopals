//
//  Base64Tests.swift
//  Tests
//
//  Created by olid on 25/07/2022.
//

import XCTest

final class Base64Tests: XCTestCase {
    func testEncode() throws {
        XCTAssertEqual(Base64.encode(bytes: [0x4d, 0x61, 0x6e]), "TWFu")
        XCTAssertEqual(Base64.encode(bytes: [0x4d, 0x61]), "TWE=")
        XCTAssertEqual(Base64.encode(bytes: [0x4d]), "TQ==")
    }
    
    func testEncodeBigger() throws {
        XCTAssertEqual(Base64.encode(bytes: [0x4d, 0x61, 0x6e, 0x4d, 0x61, 0x6e]), "TWFuTWFu")
        XCTAssertEqual(Base64.encode(bytes: [0x4d, 0x61, 0x6e, 0x4d, 0x61]), "TWFuTWE=")
        XCTAssertEqual(Base64.encode(bytes: [0x4d, 0x61, 0x6e, 0x4d]), "TWFuTQ==")
    }
    
    func testDecode() throws {
        XCTAssertEqual(Base64.decode(string: "TWFu"), [0x4d, 0x61, 0x6e])
        XCTAssertEqual(Base64.decode(string: "TWE="), [0x4d, 0x61])
        XCTAssertEqual(Base64.decode(string: "TQ=="), [0x4d])
    }
    
    func testDecodeBigger() throws {
        XCTAssertEqual(Base64.decode(string: "TWFuTWFu"), [0x4d, 0x61, 0x6e, 0x4d, 0x61, 0x6e])
        XCTAssertEqual(Base64.decode(string: "TWFuTWE="), [0x4d, 0x61, 0x6e, 0x4d, 0x61])
        XCTAssertEqual(Base64.decode(string: "TWFuTQ=="), [0x4d, 0x61, 0x6e, 0x4d])
    }
}
