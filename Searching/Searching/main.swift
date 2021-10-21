//
//  main.swift
//  Searching
//
//  Created by 윤태민 on 10/10/21.
//

import Foundation
import DataStructure

print("Hello, World!")

//var arr: [Int] = [27, 10, 12, 20, 25, 13, 15, 22, 15]
//print(arr.sequentialSearch(key: 10) ?? "Fail to search")
//print(arr.sequentialSearch(key: 14) ?? "Fail to search")
//
//var arr2: [Int] = [1, 3, 4, 6, 7, 8, 10, 13, 14]
//print(arr2.recursiveBinarySearch(key: 4) ?? "Fail to search")
//print(arr2.recursiveBinarySearch(key: 5) ?? "Fail to search")
//print(arr2.binarySearchUsingLoop(key: 4) ?? "Fail to search")
//print(arr2.binarySearchUsingLoop(key: 5) ?? "Fail to search")


let binarySearchTree: BinarySearchTree<Int> = BinarySearchTree()
binarySearchTree.insert(BinaryNode(35))
binarySearchTree.insert(BinaryNode(18))
binarySearchTree.insert(BinaryNode(7))
binarySearchTree.insert(BinaryNode(26))
binarySearchTree.insert(BinaryNode(12))
binarySearchTree.insert(BinaryNode(3))
binarySearchTree.insert(BinaryNode(68))
binarySearchTree.insert(BinaryNode(22))
binarySearchTree.insert(BinaryNode(30))
binarySearchTree.insert(BinaryNode(99))

print(binarySearchTree.inorder())
print(binarySearchTree.preorder())
print(binarySearchTree.postorder())

binarySearchTree.remove(key: 3)
print(binarySearchTree.inorder())
binarySearchTree.remove(key: 35)
print(binarySearchTree.inorder())

let binarySearchTree2: BinarySearchTree<Int> = BinarySearchTree()
binarySearchTree2.insert(BinaryNode(10))
binarySearchTree2.insert(BinaryNode(16))
binarySearchTree2.remove(key: 16)
print(binarySearchTree2.inorder())
