//
//  RoundKeyTests.swift
//  Tests
//
//  Created by Oliver Donald on 27/07/2022.
//

import XCTest


final class RoundKeyTests: XCTestCase {
    func testKeyExpansion() throws {
        let keys = RoundKey(byteArray: "Thats my Kung Fu".utf8Bytes).buildKeys()
        
        XCTAssertEqual(keys[0].description,  "54 68 61 74 73 20 6d 79 20 4b 75 6e 67 20 46 75")
        XCTAssertEqual(keys[1].description,  "e2 32 fc f1 91 12 91 88 b1 59 e4 e6 d6 79 a2 93")
        XCTAssertEqual(keys[2].description,  "56 08 20 07 c7 1a b1 8f 76 43 55 69 a0 3a f7 fa")
        XCTAssertEqual(keys[3].description,  "d2 60 0d e7 15 7a bc 68 63 39 e9 01 c3 03 1e fb")
        XCTAssertEqual(keys[4].description,  "a1 12 02 c9 b4 68 be a1 d7 51 57 a0 14 52 49 5b")
        XCTAssertEqual(keys[5].description,  "b1 29 3b 33 05 41 85 92 d2 10 d2 32 c6 42 9b 69")
        XCTAssertEqual(keys[6].description,  "bd 3d c2 87 b8 7c 47 15 6a 6c 95 27 ac 2e 0e 4e")
        XCTAssertEqual(keys[7].description,  "cc 96 ed 16 74 ea aa 03 1e 86 3f 24 b2 a8 31 6a")
        XCTAssertEqual(keys[8].description,  "8e 51 ef 21 fa bb 45 22 e4 3d 7a 06 56 95 4b 6c")
        XCTAssertEqual(keys[9].description,  "bf e2 bf 90 45 59 fa b2 a1 64 80 b4 f7 f1 cb d8")
        XCTAssertEqual(keys[10].description, "28 fd de f8 6d a4 24 4a cc c0 a4 fe 3b 31 6f 26")
    }
}


