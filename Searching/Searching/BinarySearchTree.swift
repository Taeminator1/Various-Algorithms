//
//  BinarySearchTree.swift
//  Searching
//
//  Created by 윤태민 on 10/16/21.
//

import Foundation
import DataStructure

class BinarySearchTree<Element: Comparable>: BinaryTree<Element> {
    
    func insert(_ newElement: BinaryNode<Element>) {
        guard !self.isEmpty else {      // 트리가 비어있는 경우, root를 노드로 설정
            self.root = newElement
            return
        }
        
        var node: BinaryNode? = root
        while let tmpNode = node {
            guard tmpNode != newElement else {
                fatalError("Disable to insert exsisting data.")
            }
            
            if tmpNode > newElement {
                if tmpNode.left == nil {            // 왼쪽 노드가 비어있으면, 새 원소 추가
                    tmpNode.left = newElement
                    return
                }
                else {
                    node = tmpNode.left
                }
            }
            else {
                if tmpNode.right == nil {           // 오른쪽 노드가 비어있으면, 새 원소 추가
                    tmpNode.right = newElement
                    return
                }
                else {
                    node = tmpNode.right
                }
            }
        }
    }
    
    func search(key: Element) -> BinaryNode<Element>? {
        guard !self.isEmpty else {
            return nil
        }
        
        var node: BinaryNode? = root
        while let tmpNode = node {
            guard tmpNode.data == key else {
                return node
            }
            
            node = tmpNode.data > key ? tmpNode.left : tmpNode.right
        }
        
        return nil
    }
    
    
    
    func remove(key: Element) -> Element? {
        // 트리가 비어있으면 nil 반환
        guard !self.isEmpty else {
            return nil
        }
        
        var targetNode = root
        var parentNode: BinaryNode<Element>? = nil
        
        while let tmpNode = targetNode {
            if tmpNode.data > key {
                parentNode = targetNode
                targetNode = tmpNode.left
            }
            else if tmpNode.data < key {
                parentNode = targetNode
                targetNode = tmpNode.right
            }
            else {
                break
            }
        }
        
        // 삭제할 노드가 없으면 nil 반환
        guard let target = targetNode else {
            return nil
        }
        
        if target.isLeaf {            // 삭제하려는 노드가 단말 노드일 경우
            if let parent = parentNode {
                if parent.left == targetNode {
                    parent.left = nil
                }
                else {
                    parent.right = nil
                }
            }
            else {                  // 삭제할 노드가 루트 노드인 경우
                root = nil
            }
        }
        else if target.left == nil || target.right == nil {  // 삭제하려는 노드가 하나의 서브트리만 가지고 있는 경우
            let child = target.left == nil ? target.right : target.left
            if let parent = parentNode {
                if parent.left == targetNode {
                    parent.left = child
                }
                else {
                    parent.right = child
                }
            }
            else {                  // 삭제할 노드가 루트 노드인 경우
                root = child
            }
        }
        else {                      // 삭제하려는 노드가 두 개의 서브트리를 가지고 있는 경우
            // 왼쪽 후계 노드 선택하는 경우
            var successor = target.left!
            var successorParent = target
            
            if successor.right == nil {         // 오른쪽 서브트리가 없는 경우
                parentNode!.left = successor
                successor.right = target.right
            }
            else {                              // 오른쪽 서브트리가 있는 경우
                while let tmpNode = successor.right {
                    successorParent = successor
                    successor = tmpNode
                }
                
                successorParent.right = nil
                successor.left = target.left
                successor.right = target.right
                
                if let parent = parentNode {
                    parent.left = successor
                }
                else {
                    root = successor
                }
            }
        }
        
        return target.data
    }
}
