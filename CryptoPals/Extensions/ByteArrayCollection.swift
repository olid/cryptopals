//
//  ByteArrayCollection.swift
//  CryptoPals
//
//  Created by olid on 26/07/2022.
//

import Foundation

typealias ByteArrayCollection = [ByteArray]

extension ByteArrayCollection {
    func transpose() -> ByteArrayCollection {
        let chunkCount = self.count
        let chunkLength = self.first!.count
        
        guard self.allSatisfy({ array in array.count == chunkLength }) else { fatalError("Can't transpose collections of differing lengths") }
        
        return (0..<chunkLength).map { column in
            (0..<chunkCount).map { row in
                self[row][column]
            }
        }
    }
}
