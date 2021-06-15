//
//  HuffmanNode.swift
//  HuffmanCoding
//
//  Created by 윤태민 on 6/6/21.
//

import Foundation

class HuffmanNode: Comparable {
    private var value: Int       // Frequency of Character
    private var key: Character?
    var left: HuffmanNode?
    var right: HuffmanNode?
    
    init(_ value: Int) {
        self.value = value
    }
    
    init(_ value: Int, _ key: Character) {
        self.value = value
        self.key = key
    }
    
    func getValue() -> Int {
        return self.value
    }
    
    func getKey() -> Character? {
        return self.key
    }
    
    static func < (lhs: HuffmanNode, rhs: HuffmanNode) -> Bool {
        lhs.getValue() < rhs.getValue()
    }
    
    static func == (lhs: HuffmanNode, rhs: HuffmanNode) -> Bool {
        lhs.getValue() == rhs.getValue()
    }
}


