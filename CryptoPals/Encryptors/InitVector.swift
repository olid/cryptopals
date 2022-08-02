//
//  InitVector.swift
//  CryptoPals
//
//  Created by Oliver Donald on 02/08/2022.
//

import Foundation

struct InitVector: Equatable, Hashable {
    let a00, a01, a02, a03: Byte
    let a10, a11, a12, a13: Byte
    let a20, a21, a22, a23: Byte
    let a30, a31, a32, a33: Byte
    
    static let zero: InitVector = InitVector(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    
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
}
