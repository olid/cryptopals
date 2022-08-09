//
//  CookieParser.swift
//  CryptoPals
//
//  Created by Oliver Donald on 07/08/2022.
//

import Foundation

typealias Email = ByteArray

struct CookieHelpers {
    static func parse(cookieString: String) -> Dictionary<String, String> {
        let kvps = cookieString
            .components(separatedBy: "&")
            .map { kvp in kvp.components(separatedBy: "=") }
            .map { pair in (pair[0], pair[1]) }
        
        return Dictionary(uniqueKeysWithValues: kvps)
    }
    
    static func profile(for user: Email) -> ByteArray {
        let sanitisedEmail = user.filter { byte in byte != 0x26 && byte != 0x3d }
        
        return "email=".utf8Bytes + sanitisedEmail + "&uid=10&role=user".utf8Bytes
    }
    
    static func encryptedProfile(for user: Email, key: ByteArray) -> ByteArray {
        let profile = profile(for: user)
        return Aes.Ecb().encrypt(input: profile, key: key)
    }
    
    static func decrypt(profile: ByteArray, key: ByteArray) -> ByteArray {
        return Aes.Ecb().decrypt(input: profile, key: key)
    }
}
