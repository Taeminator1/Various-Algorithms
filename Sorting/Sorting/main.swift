//
//  main.swift
//  Sorting
//
//  Created by 윤태민 on 6/21/21.
//

import Foundation

print("Hello, World!")

extension Array {
    typealias byType = (Element, Element) -> Bool
}

// Insertion Sort
extension Array where Self.Element : Comparable {
    
    func insertionSorted(by: byType = (<)) -> [Element] {
        var res: [Element] = self
        insertionSortFunction(&res, by)
        return res
    }
    
    mutating func insertionSort(by: byType = (<)) {
        insertionSortFunction(&self, by)
    }
    
    private func insertionSortFunction(_ input: inout [Element], _ by: byType) {
        for i in 1 ..< input.count {
            var j: Int = i - 1
            let tmp = input[i]
            
            while j >= 0 && !by(input[j], tmp) {
                input[j + 1] = input[j]
                j -= 1
            }
            input[j + 1] = tmp
        }
    }
}

// Selction Sort
extension Array where Self.Element : Comparable {
    
    func selectionSorted(by: byType = (<)) -> [Element] {
        var res: [Element] = self
        selectionSortFunction(&res, by)
        return res
    }
    
    mutating func selectionSort(by: byType = (<)) {
        selectionSortFunction(&self, by)
    }
    
    private func selectionSortFunction(_ input: inout [Element], _ by: byType) {
        for i in 0 ..< input.count {
            var tmpIndex: Int = i
            for j in i + 1 ..< input.count {
                tmpIndex = by(input[tmpIndex], input[j]) ? tmpIndex : j
            }
            input.swapAt(i, tmpIndex)
        }
    }
}


var arr: [Int] = [11, 3, 4, 1, 2, 3, 6, 2, 4, 45, 5]

//print(arr.insertionSorted(by: >))
//print(arr)
//arr.insertionSort(by: >)
//print(arr)

//print(arr.selectionSorted(by: >))
//print(arr)
//arr.selectionSort(by: >)
//print(arr)


// throws 추가 필요
