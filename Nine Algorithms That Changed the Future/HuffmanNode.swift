//
//  HuffmanNode.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 6/6/21.
//

import Foundation
import DataStructure

class HuffmanNode: Comparable {
    var data: Int       // Frequency of Character
    var char: Character?
    var left: HuffmanNode?
    var right: HuffmanNode?
    
    init(_ data: Int) {
        self.data = data
//        print("\(data) node has been created")
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
//        print("\(data) \(char) node has been dismissed")
    }
}

func huffmanCoding(input: String) -> [Int] {
    // 문자열을 구성하는 문자들에 대한 빈도수 구하기
    var charFreqs: Dictionary<Character, Int> = [:]
    input.forEach {
        if charFreqs[$0] == nil {
            charFreqs.updateValue(1, forKey: $0)
        }
        else {
            charFreqs[$0]! += 1
        }
    }
    
    // 각각의 빈도수에 대한 허프만 코드 구하기
    let priorityQueue: PriorityQueue = PriorityQueue<HuffmanNode>(handler: <)
    charFreqs.forEach {
        priorityQueue.insert(data: HuffmanNode($0.1, $0.0))
    }
    
    while priorityQueue.getCount() != 1 {
        let left: HuffmanNode = priorityQueue.pop()!.getData()
        let right: HuffmanNode = priorityQueue.pop()!.getData()
        
        let tmpHuffmanNode = HuffmanNode(left.getData() + right.getData())
        tmpHuffmanNode.setLeft(left)
        tmpHuffmanNode.setRight(right)
        priorityQueue.insert(data: tmpHuffmanNode)
    }
    
    let root: HuffmanNode = priorityQueue.pop()!.getData()
    let huffmanCodes: [Character: String] = makeHuffmanCode(root)
    
    // 입력된 문자열을 허프만 코드로 변경하여 이진 문자열 생성
    let str2: String = str.map { huffmanCodes[$0]! }.reduce("") { $0 + $1 }
    
    // 각 이진 문자열 8개씩 쪼개 십진 문자열로 변경
    var integers: [Int] = []
    var index: Int = 0
    while index < str2.count {
        integers.append(Int(str2[index ..< index + 8], radix: 2)!)
        index += 8
    }
    
    if index != str2.count {
        index -= 8
        integers.removeLast()
        
        var tmpString: String = ""
        while index < str2.count {
            tmpString += str2[index ..< index + 1]
            index += 1
        }
        
        while index % 8 != 0 {
            tmpString += "0"
            index += 1
        }
        
        integers.append(Int(tmpString, radix: 2)!)
    }
    
    return integers
}

func makeHuffmanCode(_ start: HuffmanNode) -> [Character: String] {
    var huffmanCodes: [Character: String] = [:]
    
    func DFS(_ start: HuffmanNode, _ str: String) {
        if start.getRight() == nil {
            huffmanCodes.updateValue(str, forKey: start.getChar()!)
        }
        else {
            DFS(start.getLeft()!, str + "0")
            DFS(start.getRight()!, str + "1")
        }
    }
    
    DFS(start, "")
    
    return huffmanCodes
}

// https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}

