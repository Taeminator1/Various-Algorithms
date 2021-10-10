//
//  ArrayExtension.swift
//  Searching
//
//  Created by 윤태민 on 10/10/21.
//

import Foundation
import DataStructure

extension Array where Self.Element : Comparable {
    func sequentialSearch(key: Element) -> Int? {
        for i in 0 ..< self.count {
            if self[i] == key {
                return i
            }
        }
        return nil
    }
}

