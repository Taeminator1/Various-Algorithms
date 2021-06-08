//
//  HuffmanNode.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 6/6/21.
//

import Foundation
import DataStructure

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

// 문자열 압축
func compress(_ input: String) -> String {
    let huffmanCodes: [Character: String] = makeHuffmanCodes(input)
    let convertedStr = convertStr(input, huffmanCodes)
    return makeForm(input, convertedStr, huffmanCodes)
}

// 허프만 코드 구하기
func makeHuffmanCodes(_ input: String) -> [Character: String] {
    var keyFreqs: Dictionary<Character, Int> = [:]
    input.forEach {
        if keyFreqs[$0] == nil {
            keyFreqs.updateValue(1, forKey: $0)
        }
        else {
            keyFreqs[$0]! += 1
        }
    }
    
    // 각각의 빈도수에 대한 허프만 코드 구하기
    let priorityQueue: PriorityQueue = PriorityQueue<HuffmanNode>(handler: <)
    keyFreqs.forEach { priorityQueue.insert(data: HuffmanNode($0.1, $0.0)) }
    
    while priorityQueue.getCount() != 1 {
        let left: HuffmanNode = priorityQueue.pop()!.getData()
        let right: HuffmanNode = priorityQueue.pop()!.getData()
        
        let tmp = HuffmanNode(left.getValue() + right.getValue())
        tmp.setLeft(left)
        tmp.setRight(right)
        priorityQueue.insert(data: tmp)
    }
    
    let root: HuffmanNode = priorityQueue.pop()!.getData()
    var huffmanCodes: [Character: String] = [:]
    
    func DFS(_ start: HuffmanNode, _ str: String) {
        if start.getKey() != nil {
            huffmanCodes.updateValue(str, forKey: start.getKey()!)
        }
        else {
            DFS(start.getLeft()!, str + "0")
            DFS(start.getRight()!, str + "1")
        }
    }
    
    DFS(root, "")
    
    return huffmanCodes
}

// 입력 받은 문자열을 허프만 코드를 이용해 반환
func convertStr(_ input: String, _ huffmanCodes: [Character: String]) -> String {
    // 입력된 문자열을 허프만 코드를 이용해 변환
    let binStr: String = input.map { huffmanCodes[$0]! }.reduce("") { $0 + $1 }
    let binStrCnt: Int = binStr.count
    
    // 이진 문자열을 8개씩 쪼개 십진 문자열로 변경
    var decimals: [Int] = []
    var index: Int = 0
    while index < binStrCnt {
        decimals.append(Int(binStr[index ..< index + 8], radix: 2)!)
        index += 8
    }
    
    // 마지막 원소가 8개로 구성이 안 될경우 처리
    if index != binStrCnt {
        index -= 8
        decimals.removeLast()        // 8자리가 안 된 마지막 원소 제거
        
        var tmp: String = binStr[index ..< index + binStrCnt]
        index = binStrCnt
        // 8자리가 되도록 뒷 부분을 0으로 채움
        while index % 8 != 0 {
            tmp += "0"
            index += 1
        }
        
        decimals.append(Int(tmp, radix: 2)!)
    }
    
    // 쪼개진 십진수들을 유니코드 문자열로 반환
    return decimals.map { String(UnicodeScalar($0)!) }.reduce("") { $0 + $1 }
}

// 양식에 맞춰 문자열 반환
func makeForm(_ originalStr: String, _ convertedStr: String, _ huffmanCodes: [Character: String]) -> String {
    var res: String = ""
    
    // 허프만 코드의 개수
    res += String(huffmanCodes.count)
    res += "\n"
    
    // 허프만 코드
    huffmanCodes.forEach { res += "\($0.key)\($0.value) " }
    res += "\n"
    
    // 원래 문자열의 길이
    res += String(originalStr.count)
    res += "\n"
    // 숫자열을 문자열 ascii로 변환
    res += convertedStr
    
    return res
}

// 문자열 추출
func extract(_ input: String) -> String {
    var index: Int = 0
    
    let huffmanCodeCnt: Int = getNumber(input, from: &index)
    let huffmanCodes: [String: Character] = findHuffmanCodes(input, from: &index, huffmanCodeCnt)
    let strCnt: Int = getNumber(input, from: &index)
    return returnStr(input, from: &index, strCnt, huffmanCodes)
}

// 시작 인덱스로부터 숫자 구하기
func getNumber(_ input: String, from index: inout Int) -> Int {
    let startIndex: Int = index
    while input[index] != "\n" {
        index += 1
    }
    let res: Int = Int(input[startIndex ..< index])!
    index += 1
    
    return res
}

// 허프만 코드 찾기
func findHuffmanCodes(_ input: String, from index: inout Int, _ huffmanCodeCnt: Int) -> [String: Character] {
    var huffmanCodes: [String: Character] = [:]
    while huffmanCodes.count < huffmanCodeCnt {
        let char: Character = Character(input[index])
        index += 1
        
        let startIndex = index
        while input[index ..< index + 1] != " " {
            index += 1
        }
        
        let code: String = input[startIndex ..< index]
        huffmanCodes.updateValue(char, forKey: code)
        index += 1
    }
    index += 1
    
    return huffmanCodes
}

// 입력받은 문자열을 허프만 코드를 이용해 변환
func returnStr(_ input: String, from index: inout Int, _ strCnt: Int, _ huffmanCodes: [String: Character]) -> String {
    // 입력된 유니코드 문자열을 십진수들로 변환
    var decimals: [UInt32] = []
    while index < input.count {
        decimals.append(UnicodeScalar(input[index])!.value)
        index += 1
    }
    
    // 십진수들을 이진 문자열로 변환
    var binStr: String = ""
    decimals.forEach {
        let tmp: String = String($0, radix: 2)
        
        // 8자리가 되도록 앞 부분을 0으로 채움
        for _ in 0 ..< (8 - tmp.count) {
            binStr += "0"
        }
        binStr += tmp
    }
    
    // 허프만 코드를 이용해 이진 문자열을 원래 문자열로 변환
    var res: String = ""
    var tmp: String = ""
    var index2: Int = 0
    while res.count < strCnt {
        tmp += binStr[index2]
        if huffmanCodes[tmp] != nil {
            res += String(huffmanCodes[tmp]!)
            tmp = ""
        }
        index2 += 1
    }
    
    return res
}


// https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

