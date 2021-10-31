//
//  main.swift
//  Sorting
//
//  Created by 윤태민 on 6/21/21.
//

import Foundation

print("Hello, World!")

var arr: [Int] = [27, 10, 12, 20, 25, 13, 15, 22, 15]
//var arr: [Int] = []

//print(arr.insertionSorted(by: <))
//print(arr)
//arr.insertionSort(by: <)
//print(arr)

//print(arr.selectionSorted(by: >))
//print(arr)
//arr.selectionSort(by: >)
//print(arr)

//print(arr.mergeSorted(by: >))
//print(arr)
//arr.mergeSort(by: >)
//print(arr)

//print(arr.quickSorted(by: >))
//print(arr)
//arr.quickSort(by: >)
//print(arr)

print(arr.simpleQuickSorted(by: >))
print(arr)
arr.simpleQuickSort(by: >)
print(arr)

//print(arr.heapSorted(by: >))
//print(arr)
//arr.heapSort(by: >)
//print(arr)

var arr2: [UInt] = [27, 10, 12, 20, 25, 13, 15, 22, 15]
//var arr2: [UInt] = []
print(arr2.radixSorted())
print(arr2)
arr2.radixSort()
print(arr2)
