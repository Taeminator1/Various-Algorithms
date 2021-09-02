//
//  Compressor.swift
//  HuffmanCoding
//
//  Created by 윤태민 on 6/8/21.
//

//  Compress string:
//  - 1. Get huffman code using HuffmanNode.
//  - 2. Convert string to compressed string.
//  - 3. Add some information to extract in the future.

import Foundation
import DataStructure

struct Compressor {
    typealias CodesType = [Character: String]
    var input: String
    var pNumber: Int        // positional number
    
    init(_ input: String, pNumber: Int = 7) {
        self.input = input
        self.pNumber = pNumber
    }
    
    var convertedStrInForm: String {
        let huffmanCodes: CodesType = makeHuffmanCodes()
        let compressedStr: String = compressStr(huffmanCodes)
        var res: String = ""
        
        // 허프만 코드의 개수
        res += String(huffmanCodes.count)
        res += "\n"
        
        // 허프만 코드
        huffmanCodes.forEach { res += "\($0.key)\($0.value) " }
        res += "\n"
        
        // 원래 문자열의 길이
        res += String(input.count)
        res += "\n"
        
        // 압축된 문자열
        res += compressedStr
        
        return res
    }
    
    // 허프만 코드 구하기
    private func makeHuffmanCodes() -> CodesType {
        if input == "" { return [:] }
        
        var keyFreqs: Dictionary<Character, Int> = [:]
        input.forEach {
            if keyFreqs[$0] == nil {        // 새로운 문자 업데이트
                keyFreqs.updateValue(1, forKey: $0)
            }
            else {                          // 빈도 수 증가
                keyFreqs[$0]! += 1
            }
        }
        
        // 각각의 빈도수에 대한 허프만 코드 구하기
        let priorityQueue: PriorityQueue = PriorityQueue<HuffmanNode>(handler: <)       // 최소 힙
        keyFreqs.forEach { priorityQueue.insert(data: HuffmanNode($0.1, $0.0)) }
        
        while priorityQueue.count != 1 {
            let left: HuffmanNode = priorityQueue.pop()!.data
            let right: HuffmanNode = priorityQueue.pop()!.data
            
            let tmp = HuffmanNode(left.getValue() + right.getValue())
            tmp.left = left
            tmp.right = right
            priorityQueue.insert(data: tmp)
        }
        
        let root: HuffmanNode = priorityQueue.pop()!.data
        var huffmanCodes: Dictionary<Character, String> = [:]
        
        func DFS(_ start: HuffmanNode, _ str: String) {
            if start.getKey() != nil {
                huffmanCodes.updateValue(str, forKey: start.getKey()!)
            }
            else {
                DFS(start.left!, str + "0")
                DFS(start.right!, str + "1")
            }
        }
        
        DFS(root, "")
        
        return huffmanCodes
    }
    
    // 입력 받은 문자열을 허프만 코드를 이용해 반환
    func compressStr(_ huffmanCodes: CodesType) -> String {
        // 입력된 문자열을 허프만 코드를 이용해 변환
        let binStr: String = input.map { huffmanCodes[$0]! }.reduce("") { $0 + $1 }
        let binStrCnt: Int = binStr.count
        
        // 이진 문자열을 pNumber 개씩 쪼개 십진수로 변경
        var decimals: [Int] = []
        var index: Int = 0
        while index < binStrCnt {
            decimals.append(Int(binStr[index ..< index + pNumber], radix: 2)!)
            index += pNumber
        }
        
        // 마지막 원소가 pNumber 개로 구성이 안 될경우 처리
        if index != binStrCnt {
            index -= pNumber
            decimals.removeLast()        // pNumber 자리가 안 된 마지막 원소 제거
            
            var tmp: String = binStr[index ..< index + binStrCnt]
            index = binStrCnt
            // pNumber 자리가 되도록 뒷 부분을 0으로 채움
            while index % pNumber != 0 {
                tmp += "0"
                index += 1
            }
            
            decimals.append(Int(tmp, radix: 2)!)
        }
        
        // 쪼개진 십진수들을 유니코드(아스키) 문자열로 반환
        return decimals.map { String(UnicodeScalar($0)!) }.reduce("") { $0 + $1 }
    }
}
