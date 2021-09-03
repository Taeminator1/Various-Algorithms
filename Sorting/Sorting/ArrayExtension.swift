//
//  ArrayExtension.swift
//  Sorting
//
//  Created by 윤태민 on 9/3/21.
//

//  Varios sorting algorithms by extending Array type.
//  Import DataStructure framework to make heapSort.
//  Each sorting algorithms have -Sorted and -Sort method like sort method from Swift

import Foundation
import DataStructure

extension Array {
    typealias ByType = (Element, Element) -> Bool       // To sort elements, compare two element in order.
}


// MARK:- Insertion Sort
// Time Complexity: O(n)
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
        for i in 0 ..< input.count {        // 0부터 시작해야 빈 배열일 때 대응 가능
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


// MARK:- Selction Sort
// Time Complexity: O(n)
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


// MARK:- Merge Sort
// Time Complexity: O(n * log n)
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


// MARK:- Quick Sort
// Time Complexity: O(n * log n)
extension Array where Self.Element : Comparable {

    func quickSorted(by: ByType = (<)) -> [Element] {
        var res: [Element] = self
        quickSortFunction(&res, 0, res.count - 1, by)
        return res
    }
    
    mutating func quickSort(by: ByType = (<)) {
        quickSortFunction(&self, 0, self.count - 1, by)
    }
    
    private func quickSortFunction(_ input: inout [Element], _ startIndex: Int, _ lastIndex: Int, _ by: ByType) {
        if startIndex < lastIndex {
            let pivotIndex: Int = part(&input, startIndex, lastIndex, by)
            quickSortFunction(&input, startIndex, pivotIndex - 1, by)
            quickSortFunction(&input, pivotIndex + 1, lastIndex, by)
        }
    }

    private func part(_ input: inout [Element], _ startIndex: Int, _ lastIndex: Int, _ by: ByType) -> Int {
        let pivot: Element = input[startIndex]
        var leftIndex: Int = startIndex + 1
        var rightIndex: Int = lastIndex
        
        if leftIndex == rightIndex {
            if input[leftIndex] < pivot {
                input.swapAt(startIndex, rightIndex)
            }
        }
        else {
            while leftIndex < rightIndex {
                
                // 왼쪽 부분 비교할 때 또는 오른쪽 부분 비교할 때 등호가 한 군데 이상 있어야 함
                // do-while로 하는게 더 효율적인가??
//                while leftIndex < lastIndex && input[leftIndex] <= pivot {
                while leftIndex < lastIndex && by(input[leftIndex], pivot) {
                    leftIndex += 1
                }
                
//                while leftIndex < lastIndex && input[rightIndex] > pivot {
                while rightIndex > startIndex && !by(input[rightIndex], pivot) {
                    rightIndex -= 1
                }
                if leftIndex < rightIndex {
                    input.swapAt(leftIndex, rightIndex)
                }
            }
            input.swapAt(startIndex, rightIndex)
        }
        return rightIndex
    }
}


// MARK:- Heap Sort
// Time Complexity: O(n * log n)
extension Array where Self.Element : Comparable {

    func heapSorted(by: @escaping ByType = (<)) -> [Element] {
        return heapSortFunction(by)
    }
    
    mutating func heapSort(by: @escaping ByType = (<)) {
        self = heapSortFunction(by)
    }
    
    private func heapSortFunction(_ by: @escaping ByType) -> [Element] {
        let heap: Heap = Heap<Element> {
            by($0.data, $1.data)
        }
        var res: [Element] = []
        
        self.forEach { heap.insert(data: $0) }
        while heap.count > 0 { res.append(heap.remove()!.data) }
        
        return res
    }
}


// MARK:- Radix Sort
// Time Complexity: O(d * n)
// 0을 포함하는 자연수(UnsignedInteger)에 대한 오름차순 정렬
extension Array where Self.Element : UnsignedInteger {
    func radixSorted() -> [Element] {
        var res: [Element] = self
        radixSortFunction(&res)
        return res
    }
    
    mutating func radixSort() {
        radixSortFunction(&self)
    }
    
    func radixSortFunction(_ input: inout [Element]) {
        // 원소의 갯수가 0일 때 처리
        guard let max = input.max() else { return }
        
        var repeatNumber: Int = findDigit(max) - 1
        var buckets: [[Element]] = [[Element]](repeating: [Element](), count: 10)
        var tmpBuckets: [[Element]] = [[Element]](repeating: [Element](), count: 10)
        var tenSquare = 10
        
        input.forEach { tmpBuckets[Int($0) / 1 % 10].append($0) }
        buckets = tmpBuckets
        
        while repeatNumber > 0 {
            tmpBuckets = [[Element]](repeating: [Element](), count: 10)
            
            buckets.forEach { $0.forEach { tmpBuckets[Int($0) / tenSquare % 10].append($0) }}
            buckets = tmpBuckets
            
            repeatNumber -= 1
            tenSquare *= 10
        }
        
        input = [Element]()
        buckets.forEach { $0.forEach { input.append($0) }}      // buckets.forEach { input.append(contentsOf: $0) }
    }
    
    private func findDigit(_ number: Element) -> Int {
        var tmp: Element = number
        var res: Int = 0
        while tmp > 0 {
            res += 1
            tmp /= 10
        }
        return res
    }

}
