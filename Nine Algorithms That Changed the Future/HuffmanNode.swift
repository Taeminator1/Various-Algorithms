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

func compress(input: String) -> String {
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
//    print(charFreqs)
    
    // 각각의 빈도수에 대한 허프만 코드 구하기
    let priorityQueue: PriorityQueue = PriorityQueue<HuffmanNode>(handler: <)
    charFreqs.forEach {
        priorityQueue.insert(data: HuffmanNode($0.1, $0.0))
    }
    
    while priorityQueue.getCount() != 1 {
        let left: HuffmanNode = priorityQueue.pop()!.getData()
        let right: HuffmanNode = priorityQueue.pop()!.getData()
        
//        print("l: \(left.getData()), r: \(right.getData())")
        
        let tmpHuffmanNode = HuffmanNode(left.getData() + right.getData())
        tmpHuffmanNode.setLeft(left)
        tmpHuffmanNode.setRight(right)
        priorityQueue.insert(data: tmpHuffmanNode)
    }
    
    let root: HuffmanNode = priorityQueue.pop()!.getData()
//    print(root.getRight()?.getLeft()?.getData())
    let huffmanCodes: [Character: String] = makeHuffmanCode(root)
//    print(huffmanCodes)
    
    // 입력된 문자열을 허프만 코드로 변경하여 이진 문자열 생성
    let str2: String = str.map { huffmanCodes[$0]! }.reduce("") { $0 + $1 }
    print(str2)
    
    // 각 이진 문자열 8개씩 쪼개 십진 문자열로 변경
    var integers: [Int] = []
    var index: Int = 0
    while index < str2.count {
        integers.append(Int(str2[index ..< index + 8], radix: 2)!)
        index += 8
    }
    print(integers)
    
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
    
    var res: String = ""
    
    // 허프만 코드의 개수
    res += String(huffmanCodes.count)
    res += "\n"
    // 허프만 코드
    huffmanCodes.forEach {
        res += "\($0.key)\($0.value) "
    }
    res += "\n"
    // 원래 문자열의 길이
    res += String(input.count)
    res += "\n"
    // 숫자열을 문자열 ascii로 변환
    integers.forEach {
        res += String(UnicodeScalar($0)!)
    }
    
    return res
}

func makeHuffmanCode(_ start: HuffmanNode) -> [Character: String] {
    var huffmanCodes: [Character: String] = [:]
    
    func DFS(_ start: HuffmanNode, _ str: String) {
        if start.getChar() != nil {
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

func extract(input: String) -> String {
    var index: Int = 0
    
    // 입력 받은 문자열에서 허프만 코드의 개수 추출
    while input[index ..< index + 1] != "\n" {
        index += 1
    }
    let huffmanCodeCount: Int = Int(input[0 ..< index])!
    index += 1
    
    print(huffmanCodeCount)
    
    // 입력 받은 문자열에서 허프만 코드 추출
    var huffmanCodes: [String: Character] = [:]
    while huffmanCodes.count < huffmanCodeCount {
        let char: Character = Character(input[index ..< index + 1])
        index += 1
        
        let tmpIndex = index
        while input[index ..< index + 1] != " " {
            index += 1
        }
        
        let code: String = input[tmpIndex ..< index]
        huffmanCodes.updateValue(char, forKey: code)
        
        index += 1
    }
    index += 1
    
    print(huffmanCodes)
    
    // 입력 받은 문자열에서 원래 문자열의 길이 추출
    let tmpIndex = index
    while input[index ..< index + 1] != "\n" {
        index += 1
    }
    let strCount: Int = Int(input[tmpIndex ..< index])!
    index += 1
    
    // 변환된 문자열의 문자들에 대해 아스키 코드 값으로 변환
    var integers: [UInt32] = []
    while index < input.count {
        integers.append(UnicodeScalar(input[index ..< index + 1])!.value)
        index += 1
    }
    print(integers)
    
    // 각각의 아스키 코드 값에 대한 이진 문자열로 변환
    var binaryStr: String = ""
    integers.forEach {
        let tmpStr: String = String($0, radix: 2)
        Array(0 ..< 8 - tmpStr.count).forEach { _ in
            binaryStr += "0"
        }
        binaryStr += tmpStr
    }
    print(binaryStr)
    
    // 허프만 코드를 이용해 이진 문자열을 원래 문자열로 변환
    var res: String = ""
    var tmpStr: String = ""
    var i: Int = 0
    while res.count < strCount {
        tmpStr += binaryStr[i ..< i + 1]
        if huffmanCodes[tmpStr] != nil {
            res += String(huffmanCodes[tmpStr]!)
            tmpStr = ""
        }
        i += 1
    }
    
    return res
}
