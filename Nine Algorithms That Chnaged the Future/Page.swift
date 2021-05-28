//
//  Page.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 5/28/21.
//

import Foundation

class Page
{
    var data: String
    var incomingPagesCount: Int = 0
    var authority: Int = 1
    var outcomingPages: [Page] = []
    
    init(_ data: String) {
        self.data = data
    }
    
    init(_ data: String, linked pages: Page...) {
        self.data = data
        
        for page in pages {
            outcomingPages.append(page)
            page.authority += self.authority
            page.incomingPagesCount += 1
        }
    }
    
    func setOutcomingLinks(_ pages: Page...) {
        for page in pages {
            outcomingPages.append(page)
            page.authority += self.authority
            page.incomingPagesCount += 1
        }
    }
    
    func displayIncomingPagesCount() {
        print("Incoming pages count of \(data): \(self.incomingPagesCount)")
    }
    
    func displayAuthority() {
        print("Authority of \(data): \(self.authority)")
    }
    
    func displayOutcomingPages() {
        print("list of outcoming pages of \(data): ", terminator: "")
        for page in outcomingPages {
            print("<\(page.data)>", terminator: " ")
        }
        print("")
    }
    
    
}
