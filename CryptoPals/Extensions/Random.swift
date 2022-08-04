//
//  Random.swift
//  CryptoPals
//
//  Created by Oliver Donald on 04/08/2022.
//

import Foundation

struct Random {
    static func randomInt(max: Int) -> Int { return Int(arc4random_uniform(UInt32(max))) }
    static func randomInt(min: Int, max: Int) -> Int { return Int(arc4random_uniform(UInt32(max - min))) + min }
}
