//
//  main.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 5/28/21.
//

import Foundation

print("Hello, World!")

var page0: Page = Page("page 0")
var page1: Page = Page("page 1")
var page2: Page = Page("page 2")
var page3: Page = Page("page 3")
var page4: Page = Page("page 4")

page0.setOutcomingLinks(page1, page2, page3)
page0.displayOutcomingPages()

page3.setOutcomingLinks(page4)
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
