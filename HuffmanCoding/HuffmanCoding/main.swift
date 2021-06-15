//
//  main.swift
//  HuffmanCoding
//
//  Created by 윤태민 on 6/15/21.
//

import Foundation
import FileRW
import DataStructure

// 압축할 시에 이진 문자열의 자릿수 결정
let pNumer: Int = 7
let path: String = "AccountName/Desktop"
let originalStr: String = readTextFile(fileName: "origin", at: path)!
let compressor = Compressor(originalStr, pNumber: pNumer)
writeTextFile(fileName: "Conversion", contents: compressor.convertedStrInForm, at: path, overwrite: true)

// "conversion" 파일을 불러와 문자열로 반환하여 추출한 후 "return" 파일 저장
let convertedStr: String = readTextFile(fileName: "conversion", at: path)!
let extractor = Extractor(convertedStr, pNumber: pNumer)
writeTextFile(fileName: "return", contents: extractor.extractOriginalStr(), at: path, overwrite: true)

// "return" 파일을 불러와 문자열로 반환
let returnedStr: String = readTextFile(fileName: "return", at: path)!

// 원래 문자와 return 파일의 문자열 비교
if originalStr == returnedStr {
    print("SAME")
}
else {
    print("DIFFERENT")
}

