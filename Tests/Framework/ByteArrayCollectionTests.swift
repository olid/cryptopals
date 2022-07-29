//
//  ByteArrayCollectionTests.swift
//  Tests
//
//  Created by Oliver Donald on 26/07/2022.
//

import XCTest

final class ByteArrayCollectionTests: XCTestCase {
    func testTranspose() throws {
        let input: ByteArrayCollection = [[0x10, 0x20, 0x30], [0x11, 0x21, 0x31], [0x12, 0x22, 0x32], [0x13, 0x23, 0x33]]
        let transposed = input.transpose()
        
        XCTAssertEqual(transposed, [[0x10, 0x11, 0x12, 0x13], [0x20, 0x21, 0x22, 0x23], [0x30, 0x31, 0x32, 0x33]])
    }
}
