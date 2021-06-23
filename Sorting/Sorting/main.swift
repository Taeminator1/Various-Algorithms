//
//  main.swift
//  Sorting
//
//  Created by 윤태민 on 6/21/21.
//

import Foundation

print("Hello, World!")

// throws 추가 필요

extension Array {
    typealias ByType = (Element, Element) -> Bool
}

// Insertion Sort
extension Array where Self.Element : Comparable {
    
    func insertionSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        insertionSortFunction(&res, by)
        return res
    }
    
    mutating func insertionSort(by: ByType = (<)) {
        insertionSortFunction(&self, by)
    }
    
    private func insertionSortFunction(_ input: inout [Element], _ by: ByType) {
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
    
    func selectionSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        selectionSortFunction(&res, by)
        return res
    }
    
    mutating func selectionSort(by: ByType = (<)) {
        selectionSortFunction(&self, by)
    }
    
    private func selectionSortFunction(_ input: inout [Element], _ by: ByType) {
        for i in 0 ..< input.count {
            var tmpIndex: Int = i
            for j in i + 1 ..< input.count {
                tmpIndex = by(input[tmpIndex], input[j]) ? tmpIndex : j
            }
            input.swapAt(i, tmpIndex)
        }
    }
}

// Merge Sort
extension Array where Self.Element : Comparable {

    func mergeSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        mergeSortFunction(&res, 0, res.count - 1, by)
        return res
    }
    
    mutating func mergeSort(by: ByType = (<)) {
        mergeSortFunction(&self, 0, self.count - 1, by)
    }
    
    private func mergeSortFunction(_ input: inout [Element], _ firstIndex: Int, _ lastIndex: Int, _ by: ByType) {
        if firstIndex < lastIndex {
            let middleIndex: Int = (firstIndex + lastIndex) / 2
            mergeSortFunction(&input, firstIndex, middleIndex, by)
            mergeSortFunction(&input, middleIndex + 1, lastIndex, by)
            merge(&input, firstIndex, middleIndex, lastIndex, by)
        }
    }

    private func merge(_ input: inout [Element], _ firstIndex: Int, _ middleIndex: Int, _ lastIndex: Int, _ by: ByType) {
        var leftIndex: Int = firstIndex
        var rightIndex: Int = middleIndex + 1
        var tmpIndex: Int = firstIndex
        var res: [Element] = []
        
        while leftIndex <= middleIndex && rightIndex <= lastIndex {
            if by(input[leftIndex], input[rightIndex]) {
                res.append(input[leftIndex])
                leftIndex += 1
            }
            else {
                res.append(input[rightIndex])
                rightIndex += 1
            }
            tmpIndex += 1
        }
        
        while leftIndex <= middleIndex {
            res.append(input[leftIndex])
            leftIndex += 1
            tmpIndex += 1
        }
        
        while rightIndex <= lastIndex {
            res.append(input[rightIndex])
            rightIndex += 1
            tmpIndex += 1
        }
        
        var k: Int = 0
        for i in firstIndex ... lastIndex {
            input[i] = res[k]
            k += 1
        }
    }
}


//var arr: [Int] = [11, 3, 4, 1, 2, 3, 6, 2, 4, 45, 5]
var arr: [Int] = [27, 10, 12, 20, 25, 13, 15, 22, 15]
var sorted: [Int] = arr

//print(arr.insertionSorted(by: >))
//print(arr)
//arr.insertionSort(by: >)
//print(arr)

//print(arr.selectionSorted(by: >))
//print(arr)
//arr.selectionSort(by: >)
//print(arr)

//print(arr.mergeSorted(by: >))
//print(arr)
//arr.mergeSort(by: >)
//print(arr)


