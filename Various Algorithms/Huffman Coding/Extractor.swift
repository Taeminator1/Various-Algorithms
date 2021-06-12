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
    var pNumber: Int        // positional number
    
    init(_ input: String, pNumber: Int = 7) {
        self.input = input
        self.pNumber = pNumber
    }
    
    func extractOriginalStr() -> String {
        var mIndex: Int = 0             // main index
        
        let huffmanCodesCnt: Int = getNumber(from: &mIndex)
        let huffmanCodes: CodesType = findHuffmanCodes(from: &mIndex, huffmanCodesCnt)
        let strCnt: Int = getNumber(from: &mIndex)
        
        // 입력된 유니코드(아스키) 문자열을 십진수들로 변환
        var decimals: [UInt32] = []
        while mIndex < input.count {
            decimals.append(UnicodeScalar(input[mIndex])!.value)
            mIndex += 1
        }
        
        // 십진수들을 이진 문자열로 변환
        var binStr: String = ""
        decimals.forEach {
            let tmp: String = String($0, radix: 2)
            
            // pNumber 자리가 되도록 앞 부분을 0으로 채움
            for _ in 0 ..< (pNumber - tmp.count) {
                binStr += "0"
            }
            binStr += tmp
        }
        
        // 허프만 코드와 원래 문자열의 길이를 이용해 이진 문자열을 원래 문자열로 변환
        var res: String = ""
        var tmp: String = ""
        var bIndex: Int = 0             // 이진 문자열 조회를 위한 index
        while res.count < strCnt {
            tmp += binStr[bIndex]
            if huffmanCodes[tmp] != nil {
                res += String(huffmanCodes[tmp]!)
                tmp = ""
            }
            bIndex += 1
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
    private func findHuffmanCodes(from index: inout Int, _ huffmanCodesCnt: Int) -> [String: Character] {
        var huffmanCodes: [String: Character] = [:]
        while huffmanCodes.count < huffmanCodesCnt {
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
