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
}
