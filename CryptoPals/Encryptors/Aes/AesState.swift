//
//  AesState.swift
//  CryptoPals
//
//  Created by Oliver Donald on 27/07/2022.
//

import Foundation

struct AesState: CustomStringConvertible, Equatable {
    let a00, a01, a02, a03: Byte
    let a10, a11, a12, a13: Byte
    let a20, a21, a22, a23: Byte
    let a30, a31, a32, a33: Byte
    
    init(byteArray: ByteArray) {
        guard byteArray.count == 16 else { fatalError("ByteArray must be exactly 16 bytes") }
        
        a00 = byteArray[0]
        a01 = byteArray[4]
        a02 = byteArray[8]
        a03 = byteArray[12]
        a10 = byteArray[1]
        a11 = byteArray[5]
        a12 = byteArray[9]
        a13 = byteArray[13]
        a20 = byteArray[2]
        a21 = byteArray[6]
        a22 = byteArray[10]
        a23 = byteArray[14]
        a30 = byteArray[3]
        a31 = byteArray[7]
        a32 = byteArray[11]
        a33 = byteArray[15]
    }
    
    func add(key: AesState) -> AesState {
        return AesState(byteArray: [
            a00 ^ key.a00, a01 ^ key.a01, a02 ^ key.a02, a03 ^ key.a03,
            a10 ^ key.a10, a11 ^ key.a11, a12 ^ key.a12, a13 ^ key.a13,
            a20 ^ key.a20, a21 ^ key.a21, a22 ^ key.a22, a23 ^ key.a23,
            a30 ^ key.a30, a31 ^ key.a31, a32 ^ key.a32, a33 ^ key.a33,
        ])
    }
    
    func substitute() -> AesState {
        return AesState(byteArray: [
            _sBox[Int(a00)], _sBox[Int(a10)], _sBox[Int(a20)], _sBox[Int(a30)],
            _sBox[Int(a01)], _sBox[Int(a11)], _sBox[Int(a21)], _sBox[Int(a31)],
            _sBox[Int(a02)], _sBox[Int(a12)], _sBox[Int(a22)], _sBox[Int(a32)],
            _sBox[Int(a03)], _sBox[Int(a13)], _sBox[Int(a23)], _sBox[Int(a33)],
        ])
    }
    
    var description: String {
        let state = [a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33]
        return (0...3).map { row in
            (0...3).map { column in
                String(format: "%02x ", state[row * 4 + column])
            }.joined()
        }.joined(separator: "\n")
    }
}
