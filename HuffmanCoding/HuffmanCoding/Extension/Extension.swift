//
//  Extension.swift
//  HuffmanCoding
//
//  Created by 윤태민 on 6/15/21.
//

import Foundation

//  Extension of String for getting partial string using subscript.
//  - Reference: https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language

extension String {
    var length: Int { count }

    subscript (i: Int) -> String { self[i ..< i + 1] }

    func substring(fromIndex: Int) -> String { self[min(fromIndex, length) ..< length] }

    func substring(toIndex: Int) -> String { self[0 ..< max(0, toIndex)] }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        
        return String(self[start ..< end])
    }
}
