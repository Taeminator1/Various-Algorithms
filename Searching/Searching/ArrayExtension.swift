//
//  ArrayExtension.swift
//  Searching
//
//  Created by 윤태민 on 10/10/21.
//

import Foundation
import DataStructure

// MARK:- Sequential Search
// Time Complexity: 0(n)
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

// MARK:- Binary Search of Sorted Array1
// - Using recursive function.
// Time Complexity: log(n)
extension Array where Self.Element: Comparable {
    func recursiveBinarySearch(key: Element) -> Int? {
        let array: [Element] = self.sorted()

        return recursiveBinarySearchFunction(array, key, lowIndex: 0, highIndex: array.count - 1)
    }
    
    private func recursiveBinarySearchFunction(_ array: [Element], _ key: Element, lowIndex: Int, highIndex: Int) -> Int? {
        let tmpIndex: Int = (lowIndex + highIndex) / 2
        if lowIndex <= highIndex {
            if array[tmpIndex] == key {
                return tmpIndex
            }
            else if array[tmpIndex] < key {
                return recursiveBinarySearchFunction(array, key, lowIndex: tmpIndex + 1, highIndex: highIndex)
            }
            else {
                return recursiveBinarySearchFunction(array, key, lowIndex: lowIndex, highIndex: tmpIndex - 1)
            }
        }
        else {
            return nil
        }
    }
}

// MARK:- Binary Search of Sorted Array2
// - Using loop.
// Time Complexity: log(n)
extension Array where Self.Element: Comparable {
    func binarySearchUsingLoop(key: Element) -> Int? {
        let array: [Element] = self.sorted()
        
        var lowIndex: Int = 0
        var highIndex: Int = array.count - 1
        while lowIndex <= highIndex {
            let tmpIndex: Int = (lowIndex + highIndex) / 2
            if array[tmpIndex] == key {
                return tmpIndex
            }
            else if array[tmpIndex] < key {
                lowIndex = tmpIndex + 1
            }
            else {
                highIndex = tmpIndex - 1
            }
        }
        
        return nil
    }
}
