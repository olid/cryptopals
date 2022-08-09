//
//  CookieParserTests.swift
//  Tests
//
//  Created by Oliver Donald on 07/08/2022.
//

import XCTest

final class CookieHelpersTests: XCTestCase {
    func testParse() throws {
        let result = CookieHelpers.parse(cookieString: "foo=bar&baz=qux&zap=zazzle")
        
        XCTAssertEqual(result["foo"], "bar")
        XCTAssertEqual(result["baz"], "qux")
        XCTAssertEqual(result["zap"], "zazzle")
    }
    
    func testProfileFor() throws {
        XCTAssertEqual(CookieHelpers.profile(for: "test@bum.com".utf8Bytes), "email=test@bum.com&uid=10&role=user".utf8Bytes)
        XCTAssertEqual(CookieHelpers.profile(for: "test@bum.&com".utf8Bytes), "email=test@bum.com&uid=10&role=user".utf8Bytes)
        XCTAssertEqual(CookieHelpers.profile(for: "test@bum.=com".utf8Bytes), "email=test@bum.com&uid=10&role=user".utf8Bytes)
    }
    
    func testEncryptedProfileFor() throws {
        let key = "Thats my Kung Fu".utf8Bytes
        let encrypted = CookieHelpers.encryptedProfile(for: "test@bum.com".utf8Bytes, key: key)
        let decrypted = CookieHelpers.decrypt(profile: encrypted, key: key)
        
        XCTAssertTrue(decrypted.starts(with: "email=test@bum.com&uid=10&role=user".utf8Bytes))
    }
}
