//
//  main.swift
//  Searching
//
//  Created by 윤태민 on 10/10/21.
//

import Foundation
import DataStructure

print("Hello, World!")

var arr: [Int] = [27, 10, 12, 20, 25, 13, 15, 22, 15]
print(arr.sequentialSearch(key: 10) ?? "Fail to search")
print(arr.sequentialSearch(key: 14) ?? "Fail to search")

var arr2: [Int] = [1, 3, 4, 6, 7, 8, 10, 13, 14]
print(arr2.recursiveBinarySearch(key: 4) ?? "Fail to search")
print(arr2.recursiveBinarySearch(key: 5) ?? "Fail to search")
print(arr2.binarySearchUsingLoop(key: 4) ?? "Fail to search")
print(arr2.binarySearchUsingLoop(key: 5) ?? "Fail to search")


let binaryNode27 = BinaryNode(27)
let binaryNode31 = BinaryNode(31, left: binaryNode27)
let binaryNode26 = BinaryNode(26, right: binaryNode31)
let binaryNode12 = BinaryNode(12)
let binaryNode3 = BinaryNode(3)
let binaryNode7 = BinaryNode(7, left: binaryNode3, right: binaryNode12)
let binaryNode18 = BinaryNode(18, left: binaryNode7, right: binaryNode26)

let binarySearchTree = BinarySearchTree(root: binaryNode18)
print(binarySearchTree.inorder())

print("search")
print(binarySearchTree.search(key: 13)?.data)
print(binarySearchTree.search(key: 26)?.data)
print(binarySearchTree.search(key: 17)?.data)

binarySearchTree.insert(BinaryNode(17))
binarySearchTree.insert(BinaryNode(1))
print(binarySearchTree.inorder())



print(binarySearchTree.remove(key: 1))
print(binarySearchTree.remove(key: -1))
print(binarySearchTree.inorder())

print(binarySearchTree.remove(key: 31))
print(binarySearchTree.inorder())

