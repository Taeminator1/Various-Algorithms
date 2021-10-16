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
}
