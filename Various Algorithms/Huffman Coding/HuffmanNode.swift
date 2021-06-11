//
//  HuffmanNode.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 6/6/21.
//

import Foundation

class HuffmanNode: Comparable {
    var value: Int       // Frequency of Character
    var key: Character?
    var left: HuffmanNode?
    var right: HuffmanNode?
    
    init(_ value: Int) {
        self.value = value
    }
    
    init(_ value: Int, _ key: Character) {
        self.value = value
        self.key = key
    }
    
    func setLeft(_ node: HuffmanNode?) {
        self.left = node
    }
    
    func setRight(_ node: HuffmanNode?) {
        self.right = node
    }
    
    func getValue() -> Int {
        return self.value
    }
    
    func getKey() -> Character? {
        return self.key
    }
    
    func getLeft() -> HuffmanNode? {
        return self.left
    }
    
    func getRight() -> HuffmanNode? {
        return self.right
    }
    
    static func < (lhs: HuffmanNode, rhs: HuffmanNode) -> Bool {
        lhs.getValue() < rhs.getValue()
    }
    
    static func == (lhs: HuffmanNode, rhs: HuffmanNode) -> Bool {
        lhs.getValue() == rhs.getValue()
    }
}


