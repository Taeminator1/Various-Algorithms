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
            guard tmpNode.data == key else {            // key와 같은 값을 갖는 노드를 발견하면 반환
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
        
        var parentNode: BinaryNode<Element>? = nil
        var targetNode = root
        
        while let tmpNode = targetNode {
            guard tmpNode.data != key else {            // key와 같은 값을 갖는 노드를 발견하면 break
                break
            }

            parentNode = targetNode
            targetNode = tmpNode.data > key ? tmpNode.left : tmpNode.right
        }
        
        // 삭제할 노드가 없으면 nil 반환
        guard let unwrappedTargetNode = targetNode else {
            return nil
        }
        
        if unwrappedTargetNode.left == nil || unwrappedTargetNode.right == nil {      // 삭제하려는 노드가 하나 이하의 서브 트리만 가지고 있는 경우
            // unwrappedTargetNode이 단말 노드인지, 왼쪽 자식 노드가 비어있는지, 오른쪽 자식 노드가 비어있는지에 따라 구분
            let child = unwrappedTargetNode.isLeaf ? nil : (unwrappedTargetNode.left == nil ? unwrappedTargetNode.right : unwrappedTargetNode.left)
            
            if let unwrappedParentNode = parentNode {
                if unwrappedParentNode.left == targetNode {
                    unwrappedParentNode.left = child
                }
                else {
                    unwrappedParentNode.right = child
                }
            }
            else {                  // 삭제할 노드가 루트 노드인 경우
                root = child
            }
        }
        else {                                              // 삭제하려는 노드가 두 개의 서브 트리를 가지고 있는 경우
            // 왼쪽 후계 노드 선택하는 경우
            var successorParentNode = unwrappedTargetNode
            var successorTargetNode = unwrappedTargetNode.left!
            
            if successorTargetNode.right == nil {           // 오른쪽 서브트리가 없는 경우
                parentNode!.left = successorTargetNode
                successorTargetNode.right = unwrappedTargetNode.right
            }
            else {                                          // 오른쪽 서브트리가 있는 경우
                while let tmpNode = successorTargetNode.right {
                    successorParentNode = successorTargetNode
                    successorTargetNode = tmpNode
                }
                
                successorParentNode.right = nil
                successorTargetNode.left = unwrappedTargetNode.left
                successorTargetNode.right = unwrappedTargetNode.right
                
                if let unwrappedParentNode = parentNode {
                    unwrappedParentNode.left = successorTargetNode
                }
                else {
                    root = successorTargetNode
                }
            }
        }
        
        return unwrappedTargetNode.data
    }
}
