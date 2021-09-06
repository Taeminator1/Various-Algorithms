//
//  Stuff.swift
//  Laundromat
//
//  Created by 윤태민 on 8/27/21.
//

//  Class for clothes
//  - preference
//      - To tell instances from the Structure
//      - Standard to select one in the Sequences

import Foundation

class Stuff {
    static var sPreference: Int = 1             // Whenever create a instance, add unique ID.
    private(set) var preference: Int = 0
    private(set) var washedNumber: Int = 0

    init() {
        self.preference = Stuff.sPreference
        Stuff.sPreference += 1
    }

    func wash() {
        washedNumber += 1
    }

    func displayState() {
        print("The washed number of Stuff[\(preference)]: \(washedNumber)")
    }
}

extension Stuff: Equatable {
    static func == (lhs: Stuff, rhs: Stuff) -> Bool {
        lhs.preference == rhs.preference
    }
}
