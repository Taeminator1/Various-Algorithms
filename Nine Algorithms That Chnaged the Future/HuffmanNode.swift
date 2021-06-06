//
//  HuffmanNode.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 6/6/21.
//

import Foundation

class HuffmanNode: Comparable {
    var data: Int       // Frequency of Character
    var char: Character?
    var left: HuffmanNode?
    var right: HuffmanNode?
    
    init(_ data: Int) {
        self.data = data
        print("\(data) node has been created")
    }
    
    init(_ data: Int, _ char: Character) {
        self.data = data
        self.char = char
    }
    
    func setLeft(_ node: HuffmanNode?) {
        self.left = node
    }
    
    func setRight(_ node: HuffmanNode?) {
        self.right = node
    }
    
    func getData() -> Int {
        return self.data
    }
    
    func getChar() -> Character? {
        return self.char
    }
    
    func getLeft() -> HuffmanNode? {
        return self.left
    }
    
    func getRight() -> HuffmanNode? {
        return self.right
    }
    
    static func < (lhs: HuffmanNode, rhs: HuffmanNode) -> Bool {
        lhs.getData() < rhs.getData()
    }
    
    static func == (lhs: HuffmanNode, rhs: HuffmanNode) -> Bool {
        lhs.getData() == rhs.getData()
    }
    
    deinit {
        print("\(data) \(char) node has been dismissed")
    }
}

