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
