//
//  Extractor.swift
//  Nine Algorithms That Changed the Future
//
//  Created by 윤태민 on 6/8/21.
//

import Foundation

struct Extractor {
    typealias CodesType = [String: Character]
    var input: String
    
    init(_ input: String) {
        self.input = input
    }
    
    func extractOriginalStr() -> String {
        var index: Int = 0
        
        let huffmanCodeCnt: Int = getNumber(from: &index)
        let huffmanCodes: CodesType = findHuffmanCodes(from: &index, huffmanCodeCnt)
        let strCnt: Int = getNumber(from: &index)
        
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
    
    // 시작 인덱스로부터 숫자 구하기
    private func getNumber(from index: inout Int) -> Int {
        let startIndex: Int = index
        while input[index] != "\n" {
            index += 1
        }
        let res: Int = Int(input[startIndex ..< index])!
        index += 1
        
        return res
    }

    // 허프만 코드 찾기
    private func findHuffmanCodes(from index: inout Int, _ huffmanCodeCnt: Int) -> [String: Character] {
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
}
