//
//  AesDecryptionState.swift
//  CryptoPals
//
//  Created by olid on 27/07/2022.
//

import Foundation

private typealias Quad = (Byte, Byte, Byte, Byte)

struct AesDecryptionState: CustomStringConvertible, Equatable {
    let a00, a01, a02, a03: Byte
    let a10, a11, a12, a13: Byte
    let a20, a21, a22, a23: Byte
    let a30, a31, a32, a33: Byte
    
    init(_ a00: Byte, _ a01: Byte, _ a02: Byte, _ a03: Byte,
         _ a10: Byte, _ a11: Byte, _ a12: Byte, _ a13: Byte,
         _ a20: Byte, _ a21: Byte, _ a22: Byte, _ a23: Byte,
         _ a30: Byte, _ a31: Byte, _ a32: Byte, _ a33: Byte) {
        self.a00 = a00; self.a01 = a01; self.a02 = a02; self.a03 = a03
        self.a10 = a10; self.a11 = a11; self.a12 = a12; self.a13 = a13
        self.a20 = a20; self.a21 = a21; self.a22 = a22; self.a23 = a23
        self.a30 = a30; self.a31 = a31; self.a32 = a32; self.a33 = a33
    }
    
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
    
    func applyRound(key: AesKey, roundNumber: Int) -> AesDecryptionState {
        if roundNumber == 0 {
            return self
                .apply(key: key)
                .substitute()
                .shiftRows()

        } else {
            return self
                .apply(key: key)
                .mixColumn()
                .shiftRows()
                .substitute()

        }
    }
    
    func apply(key: AesKey) -> AesDecryptionState {
        return AesDecryptionState(
            a00 ^ key.a00, a01 ^ key.a01, a02 ^ key.a02, a03 ^ key.a03,
            a10 ^ key.a10, a11 ^ key.a11, a12 ^ key.a12, a13 ^ key.a13,
            a20 ^ key.a20, a21 ^ key.a21, a22 ^ key.a22, a23 ^ key.a23,
            a30 ^ key.a30, a31 ^ key.a31, a32 ^ key.a32, a33 ^ key.a33
        )
    }
    
    func substitute() -> AesDecryptionState {
        return AesDecryptionState(
            _sBoxInverse[Int(a00)], _sBoxInverse[Int(a01)], _sBoxInverse[Int(a02)], _sBoxInverse[Int(a03)],
            _sBoxInverse[Int(a10)], _sBoxInverse[Int(a11)], _sBoxInverse[Int(a12)], _sBoxInverse[Int(a13)],
            _sBoxInverse[Int(a20)], _sBoxInverse[Int(a21)], _sBoxInverse[Int(a22)], _sBoxInverse[Int(a23)],
            _sBoxInverse[Int(a30)], _sBoxInverse[Int(a31)], _sBoxInverse[Int(a32)], _sBoxInverse[Int(a33)]
        )
    }
    
    func shiftRows() -> AesDecryptionState {
        return AesDecryptionState(
            a00, a01, a02, a03,
            a13, a10, a11, a12,
            a22, a23, a20, a21,
            a31, a32, a33, a30
        )
    }
    
    func mixColumn() -> AesDecryptionState {
        let a = gQuad(quad: (a00, a10, a20, a30))
        let b = gQuad(quad: (a01, a11, a21, a31))
        let c = gQuad(quad: (a02, a12, a22, a32))
        let d = gQuad(quad: (a03, a13, a23, a33))
        
        return AesDecryptionState(
            a.0, b.0, c.0, d.0,
            a.1, b.1, c.1, d.1,
            a.2, b.2, c.2, d.2,
            a.3, b.3, c.3, d.3
        )
        
        func gQuad(quad: Quad) -> Quad {
            return (
                _g14[Int(quad.0)] ^ _g11[Int(quad.1)] ^ _g13[Int(quad.2)] ^  _g9[Int(quad.3)],
                 _g9[Int(quad.0)] ^ _g14[Int(quad.1)] ^ _g11[Int(quad.2)] ^ _g13[Int(quad.3)],
                _g13[Int(quad.0)] ^  _g9[Int(quad.1)] ^ _g14[Int(quad.2)] ^ _g11[Int(quad.3)],
                _g11[Int(quad.0)] ^ _g13[Int(quad.1)] ^  _g9[Int(quad.2)] ^ _g14[Int(quad.3)]
            )
        }
    }
    
    var bytes: ByteArray {
        return [a00, a10, a20, a30, a01, a11, a21, a31, a02, a12, a22, a32, a03, a13, a23, a33]
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
