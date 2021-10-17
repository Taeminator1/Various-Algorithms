//
//  BinarySearchTree.swift
//  Searching
//
//  Created by 윤태민 on 10/16/21.
//

import Foundation
import DataStructure

class BinarySearchTree<Element: Comparable>: BinaryTree<Element> {
    
    func search(_ key: Element) -> BinaryNode<Element>? {
        var node: BinaryNode? = root
        while let tmp = node {
            if tmp.data > key {
                node = tmp.left
            }
            else if tmp.data < key {
                node = tmp.right
            }
            else {
                return node
            }
        }
        
        return nil
    }
    
    func insert(_ newElement: BinaryNode<Element>) {
        var node: BinaryNode? = root

        while let tmp = node {
            if tmp.data > newElement.data {
                if tmp.left == nil {
                    tmp.left = newElement
                    return
                }
                else {
                    node = tmp.left
                }
            }
            else if tmp.data < newElement.data {
                if tmp.right == nil {
                    tmp.right = newElement
                    return
                }
                else {
                    node = tmp.right
                }
            }
            else {
                fatalError("Disable to insert exsisting data.")
            }
        }
    }
}
