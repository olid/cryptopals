//
//  Set1.swift
//  Tests
//
//  Created by olid on 25/07/2022.
//

import XCTest

final class Set2Tests: XCTestCase {
    func testPart9() throws {
        let input = "YELLOW SUBMARINE".utf8Bytes
        let padded = PKCS7.pad(bytes: input, length: 20)
        
        XCTAssertEqual(padded.description, "YELLOW SUBMARINE\\x04\\x04\\x04\\x04")
    }
    
    func testPart10() throws {
        let cypherText = _set2Challenge2.parseAsBase64String
        let key = "YELLOW SUBMARINE".utf8Bytes
        let iv = ByteArray([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        
        let decrypted = Aes.Cbc().decrypt(input: cypherText, key: key, iv: iv)
        
        XCTAssertTrue(decrypted.description.starts(with: "I'm back and I'm ringin' the bell"))
    }
    
    func testPart11() throws {
        let plainText = "0123456789abcdef0123456789abcdef0123456789abcdef".utf8Bytes
        
        let correct = (1...10).reduce(0) { count, _ in
            let (cypherText, actualMode) = Aes.Random.randomEcbCbcEncrypt(plainText: plainText)
            let estimatedMode = EcbCbcOracle.detectModeFor(cypherText: cypherText)
            
            return (estimatedMode == actualMode) ? count + 1 : 0
        }
        
        XCTAssertEqual(correct, 10)
    }
    
    func testPart12() throws {
        let unknownText = _set2Challenge3.parseAsBase64String
        
        let answer = AesEcbDecryptor(keySize: 16).decrypt(unknownText: unknownText)
        let expected = String(format: """
            Rollin' in my 5.0
            With my rag-top down so my hair can blow
            The girlies on standby waving just to say hi
            Did you stop? No, I just drove by
            
            """)
        
        XCTAssertEqual(answer, expected.utf8Bytes)
    }
    
    func testPart13() throws {
        let randomKey = ByteArray.random(length: 16)
                
        // generate plaintext such that email is under our control, and the 'role' parameter value starts in a new block
        // |--------------|---------------|---------------|----
        // email=test____________@mydomain.com&uid=10&role=user
        let prefixEmail = "test____________@mydomain.com".utf8Bytes
        let encryptedPrefix = CookieHelpers.encryptedProfile(for: prefixEmail, key: randomKey)
        let attackPrefix = encryptedPrefix[0..<48]
        
        // generate plaintext such that 'admin' parameter starts on next block, but everything after is clipped off by 'padding' (•'s)
        // |--------------|---------------|---------------|----
        // email=__________admin•••••••••••&uid=10&role=user
        let postfix = "__________admin".utf8Bytes + Byte(0x0b).repeating(11)
        let encryptedPostfix = CookieHelpers.encryptedProfile(for: postfix, key: randomKey)
        let attackPostfix = encryptedPostfix[16..<32]
        
        // combine the two!
        let cyphertext = ByteArray(attackPrefix + attackPostfix)
        
        let decrypted = CookieHelpers.decrypt(profile: cyphertext, key: randomKey)
        let decoded = CookieHelpers.parse(cookieString: decrypted.toString)
        
        XCTAssertEqual(decoded["email"], "test____________@mydomain.com")
        XCTAssertEqual(decoded["role"], "admin")
    }
}


