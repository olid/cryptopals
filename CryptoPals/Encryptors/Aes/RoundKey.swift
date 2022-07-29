//
//  RoundKey.swift
//  CryptoPals
//
//  Created by Oliver Donald on 27/07/2022.
//

import Foundation

private typealias Quad = (Byte, Byte, Byte, Byte)

private let rci: [Byte] = [0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36]

struct RoundKey: CustomStringConvertible, Equatable {
    let a00, a01, a02, a03: Byte
    let a10, a11, a12, a13: Byte
    let a20, a21, a22, a23: Byte
    let a30, a31, a32, a33: Byte
    
    init(byteArray: ByteArray) {
        guard byteArray.count == 16 else { fatalError("ByteArray must be exactly 16 bytes") }
        
        a00 = byteArray[0]
        a01 = byteArray[1]
        a02 = byteArray[2]
        a03 = byteArray[3]
        a10 = byteArray[4]
        a11 = byteArray[5]
        a12 = byteArray[6]
        a13 = byteArray[7]
        a20 = byteArray[8]
        a21 = byteArray[9]
        a22 = byteArray[10]
        a23 = byteArray[11]
        a30 = byteArray[12]
        a31 = byteArray[13]
        a32 = byteArray[14]
        a33 = byteArray[15]
    }
    
    func buildKeys() -> [RoundKey] {
        return (1...10).reduce([self]) { keys, round in
            let next = keys.last!.buildRoundKey(round: round)
            return keys + [next]
        }
    }
    
    func buildRoundKey(round: Int) -> RoundKey {
        let gw3 = g(w: (a30, a31, a32, a33), round: round)
        
        let w4 = (a00 ^ gw3.0, a01 ^ gw3.1, a02 ^ gw3.2, a03 ^ gw3.3)
        let w5 = (w4.0 ^ a10, w4.1 ^ a11, w4.2 ^ a12, w4.3 ^ a13)
        let w6 = (w5.0 ^ a20, w5.1 ^ a21, w5.2 ^ a22, w5.3 ^ a23)
        let w7 = (w6.0 ^ a30, w6.1 ^ a31, w6.2 ^ a32, w6.3 ^ a33)
        
        return RoundKey(byteArray: [
            w4.0, w4.1, w4.2, w4.3,
            w5.0, w5.1, w5.2, w5.3,
            w6.0, w6.1, w6.2, w6.3,
            w7.0, w7.1, w7.2, w7.3])
    }
    
    private func g(w: Quad, round: Int) -> Quad {
        return (_sBox[Int(w.1)] ^ rci[round], _sBox[Int(w.2)], _sBox[Int(w.3)], _sBox[Int(w.0)])
    }
    
    var toState: AesState {
        AesState(byteArray: [a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33])
    }
    
    var description: String {
        let state = [a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33]
        return state.map { byte in byte.toHex }.joined(separator: " ")
    }
}
