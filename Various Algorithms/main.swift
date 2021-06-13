//
//  main.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 5/28/21.
//

import Foundation
import DataStructure

//print("Hello, World!")

// MARK: - Page Rank Test
/*
var page0: Page = Page("page 0")
var page1: Page = Page("page 1")
var page2: Page = Page("page 2")
var page3: Page = Page("page 3")
var page4: Page = Page("page 4")

page0.setOutcomingPages(page1, page2, page3)
page0.displayOutcomingPages()

page3.setOutcomingPages(page4)
page3.displayOutcomingPages()

print("")

var pages: [Page] = [page0, page1, page2, page3, page4]
for i in 0 ..< pages.count {
    pages[i].displayIncomingPagesCount()
}

print("")

for i in 0 ..< pages.count {
    pages[i].displayAuthority()
}

print("")

for i in 0 ..< pages.count {
    pages[i].displayOutcomingPages()
}



var falseCnt: Int = 0
var trueCnt: Int = 0
let possiblity: Int = 10
for _ in 0 ..< 1000 {
    if Page.isPossible(possiblity)! {
        trueCnt += 1
    }
    else {
        falseCnt += 1
    }
}

print("trueCnt: \(trueCnt)")
print("falseCnt: \(falseCnt)")

//page0.randomSurferTrickSimulator(pages, surfPossiblity: 90, repeatNumber: 10)
//for i in 0 ..< pages.count {
//    pages[i].displayReferedCount()
//}


var p0: Page = Page("page 0")
var p1: Page = Page("page 1")
var p2: Page = Page("page 2")
var p3: Page = Page("page 3")
var p4: Page = Page("page 4")
var p5: Page = Page("page 5")
var p6: Page = Page("page 6")
var p7: Page = Page("page 7")
var p8: Page = Page("page 8")
var p9: Page = Page("page 9")
var p10: Page = Page("page 10")
var p11: Page = Page("page 11")
var p12: Page = Page("page 12")
var p13: Page = Page("page 13")
var p14: Page = Page("page 14")
var p15: Page = Page("page 15")

p0.setOutcomingPages(p1, p2, p3)
p1.setOutcomingPages(p4)
p2.setOutcomingPages(p4, p5)
p3.setOutcomingPages(p5, p9)
p4.setOutcomingPages(p5)
p5.setOutcomingPages(p6, p9)
p6.setOutcomingPages(p7, p8, p9)
p7.setOutcomingPages(p8)
p8.setOutcomingPages(p9, p10, p11, p12, p13)
p9.setOutcomingPages(p14)
p10.setOutcomingPages(p14)
p11.setOutcomingPages(p14)
p12.setOutcomingPages(p14)
p13.setOutcomingPages(p14)
p14.setOutcomingPages(p15)
p15.setOutcomingPages(p0)

var ps: [Page] = [p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15]
p0.randomSurferTrickSimulator(ps, surfPossiblity: 15, repeatNumber: 100000)
for i in 0 ..< ps.count {
    print("\(ps[i].referedCount)")
}
 */


// MARK: - Lossless Compression Test
// "origin" 파일을 불러와 문자열로 반환하여 압축한 후 "conversion" 파일 저장
let pNumer: Int = 7
let originalStr: String = readFileFromDesktop(fileName: "origin")!
let compressor = Compressor(originalStr, pNumber: pNumer)
saveFileIntoDesktop(fileName: "conversion", contents: compressor.convertedStrInForm)

// "conversion" 파일을 불러와 문자열로 반환하여 추출한 후 "return" 파일 저장
let convertedStr: String = readFileFromDesktop(fileName: "conversion")!
let extractor = Extractor(convertedStr, pNumber: pNumer)
saveFileIntoDesktop(fileName: "return", contents: extractor.extractOriginalStr())

// "return" 파일을 불러와 문자열로 반환
let returnedStr: String = readFileFromDesktop(fileName: "return")!

// 원래 문자와 return 파일의 문자열 비교
if originalStr == returnedStr {
    print("SAME")
}
else {
    print("DIFFERENT")
}
