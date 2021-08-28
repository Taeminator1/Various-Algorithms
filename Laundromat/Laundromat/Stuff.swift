//
//  Stuff.swift
//  Laundromat
//
//  Created by 윤태민 on 8/27/21.
//

//  Class for clothes
//  - key: to tell instances from the Structure

import Foundation

class Stuff {
    static var sId: Int = 0             // Whenever create a instance, add unique ID.
    private(set) var id: Int = 0
    private(set) var washedNumber: Int = 0

    init() {
        self.id = Stuff.sId
        Stuff.sId += 1
    }

    func wash() {
        washedNumber += 1
    }

    func displayState() {
        print("The washed number of Stuff[\(id)]: \(washedNumber)")
    }
}

extension Stuff: Equatable {
    static func == (lhs: Stuff, rhs: Stuff) -> Bool {
        lhs.id == rhs.id
    }
}
