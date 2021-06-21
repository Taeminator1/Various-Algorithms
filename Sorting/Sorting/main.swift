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
        var resArray: [Element] = self
        
        for i in 1 ..< resArray.count {
            var j: Int = i - 1
            let tmp = resArray[i]
            
            while j >= 0 && !by(resArray[j], tmp) {
                resArray[j + 1] = resArray[j]
                j -= 1
            }
            resArray[j + 1] = tmp
        }
        return resArray
    }
    
    mutating func insertionSort(by: byType = (<)) {
        for i in 1 ..< self.count {
            var j: Int = i - 1
            let tmp = self[i]
            
            while j >= 0 && !by(self[j], tmp) {
                self[j + 1] = self[j]
                j -= 1
            }
            self[j + 1] = tmp
        }
    }
}

// Selction Sort
extension Array where Self.Element : Comparable {
    
    func selectionSorted(by: byType = (<)) -> [Element] {
        var resArray: [Element] = self
        
        for i in 0 ..< resArray.count {
            var tmpIndex: Int = i
            for j in i + 1 ..< resArray.count {
                tmpIndex = by(resArray[tmpIndex], resArray[j]) ? tmpIndex : j
            }
            resArray.swapAt(i, tmpIndex)
        }
        
        return resArray
    }
    
    mutating func selectionSort(by: byType = (<)) {
        for i in 0 ..< self.count {
            var tmpIndex: Int = i
            for j in i + 1 ..< self.count {
                tmpIndex = by(self[tmpIndex], self[j]) ? tmpIndex : j
            }
            self.swapAt(i, tmpIndex)
        }
    }
}


var arr: [Int] = [11, 3, 4, 1, 2, 3, 6, 2, 4, 45, 5]
print(arr.insertionSorted())
print(arr)
arr.insertionSort()
//print(arr.sorted())
//print(arr.insertionSorted())
print(arr)
//print(arr.insertionSort(by: <))
//print(arr)
//arr.sort(by: <#T##(Int, Int) throws -> Bool#>)


// throws 추가 필요
