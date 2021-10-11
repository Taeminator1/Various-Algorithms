//
//  main.swift
//  Searching
//
//  Created by 윤태민 on 10/10/21.
//

import Foundation

print("Hello, World!")

var arr: [Int] = [27, 10, 12, 20, 25, 13, 15, 22, 15]
print(arr.sequentialSearch(key: 10) ?? "Fail to search")
print(arr.sequentialSearch(key: 14) ?? "Fail to search")

var arr2: [Int] = [1, 3, 4, 6, 7, 8, 10, 13, 14]
print(arr2.recursiveBinarySearch(key: 4) ?? "Fail to search")
print(arr2.recursiveBinarySearch(key: 5) ?? "Fail to search")
print(arr2.binarySearchUsingLoop(key: 4) ?? "Fail to search")
print(arr2.binarySearchUsingLoop(key: 5) ?? "Fail to search")
