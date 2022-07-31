//
//  RoundKeyTests.swift
//  Tests
//
//  Created by olid on 27/07/2022.
//

import XCTest

final class RoundKeyTests: XCTestCase {
    func testKeyExpansion() throws {
        let keys = AesInitialKey(byteArray: "Thats my Kung Fu".utf8Bytes).buildKeys()
        
        XCTAssertEqual(keys[0].description,  "54 73 20 67 68 20 4b 20 61 6d 75 46 74 79 6e 75")
        XCTAssertEqual(keys[1].description,  "e2 91 b1 d6 32 12 59 79 fc 91 e4 a2 f1 88 e6 93")
        XCTAssertEqual(keys[2].description,  "56 c7 76 a0 08 1a 43 3a 20 b1 55 f7 07 8f 69 fa")
        XCTAssertEqual(keys[3].description,  "d2 15 63 c3 60 7a 39 03 0d bc e9 1e e7 68 01 fb")
        XCTAssertEqual(keys[4].description,  "a1 b4 d7 14 12 68 51 52 02 be 57 49 c9 a1 a0 5b")
        XCTAssertEqual(keys[5].description,  "b1 05 d2 c6 29 41 10 42 3b 85 d2 9b 33 92 32 69")
        XCTAssertEqual(keys[6].description,  "bd b8 6a ac 3d 7c 6c 2e c2 47 95 0e 87 15 27 4e")
        XCTAssertEqual(keys[7].description,  "cc 74 1e b2 96 ea 86 a8 ed aa 3f 31 16 03 24 6a")
        XCTAssertEqual(keys[8].description,  "8e fa e4 56 51 bb 3d 95 ef 45 7a 4b 21 22 06 6c")
        XCTAssertEqual(keys[9].description,  "bf 45 a1 f7 e2 59 64 f1 bf fa 80 cb 90 b2 b4 d8")
        XCTAssertEqual(keys[10].description, "28 6d cc 3b fd a4 c0 31 de 24 a4 6f f8 4a fe 26")
    }
}


