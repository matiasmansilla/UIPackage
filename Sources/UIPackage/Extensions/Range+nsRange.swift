//
//  File.swift
//  
//
//  Created by Dardo Mansilla on 15/12/2021.
//

import Foundation

public extension Range where Bound == String.Index {
    var nsRange: NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                   length: self.upperBound.encodedOffset -
                    self.lowerBound.encodedOffset)
    }
}
