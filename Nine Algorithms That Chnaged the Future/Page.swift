//
//  Page.swift
//  Nine Algorithms That Chnaged the Future
//
//  Created by 윤태민 on 5/28/21.
//

import Foundation
import DataStructure

class Page
{
    var urlString: String
    var outcomingPages: [Page] = []
    
    var incomingPagesCount: Int = 0             // for Hyperlink Trick
    var authority: Int = 1                      // for Authority Trick
    var referedCount: Int = 0                   // for Random Surfer Trick
    
    init(_ urlString: String) {
        self.urlString = urlString
    }
    
    init(_ urlString: String, linked pages: Page...) {
        self.urlString = urlString
        
        for page in pages {
            outcomingPages.append(page)
            page.authority += self.authority
            page.incomingPagesCount += 1
        }
    }
    
    func setOutcomingPages(_ pages: Page...) {
        for page in pages {
            outcomingPages.append(page)
            page.authority += self.authority
            page.incomingPagesCount += 1
        }
    }
    
    func displayOutcomingPages() {
        print("list of outcoming pages of \(urlString): ", terminator: "")
        for page in outcomingPages {
            print("<\(page.urlString)>", terminator: " ")
        }
        print("")
    }
    
    func displayIncomingPagesCount() {
        print("Incoming pages count of \(urlString): \(self.incomingPagesCount)")
    }
    
    func displayAuthority() {
        print("Authority of \(urlString): \(self.authority)")
    }
    
    func displayReferedCount() {
        print("Posiibility of \(urlString): \(self.referedCount)")
    }
    
    func randomSurferTrickSimulator(_ pages: [Page], surfPossiblity: Int = 100, repeatNumber: Int) {
        let pagesCount: Int = pages.count
        let pageQueue: Queue = Queue<Page>(Node(self))
        self.referedCount += 1
        var repeatCount: Int = 1
        
        loop: while repeatCount < repeatNumber && !pageQueue.isEmpty() {
            let popedPage: Page = pageQueue.pop()!.getData()
            
            for page in popedPage.outcomingPages {
                var outComingPage: Page = page
                if Page.isPossible(surfPossiblity)! {
                    var tmpPage: Page = pages[Int.random(in: 0 ..< pagesCount)]
                    while outComingPage.urlString == tmpPage.urlString {
                        tmpPage = pages[Int.random(in: 0 ..< pagesCount)]
                    }
                    
                    outComingPage = tmpPage
                }
                
                pageQueue.append(Node(outComingPage))
                outComingPage.referedCount += 1
                repeatCount += 1
            }
        }
    }
    
    static func isPossible(_ possiblity: Int) -> Bool? {
        if possiblity < 0 || possiblity > 100 {
            print("possiblity is out of range")
            return nil
        }
        return Int.random(in: 1 ... 100) <= possiblity
    }
}
