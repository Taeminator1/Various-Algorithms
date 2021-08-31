//
//  Basket.swift
//  Laundromat
//
//  Created by 윤태민 on 8/31/21.
//

import Foundation

typealias Basket = Array<Stuff>

extension Array where Element == Stuff {
    // 초기에 관리할 항목 추가
    mutating func addAtFirst(_ number: Int, to basket: inout Basket) {
        Stuff.sPreference = 0               // 선호도 초기화
        for _ in 0 ..< number { self.append(Stuff()) }  // 관리할 옷 생성
        basket.append(contentsOf: self)     // 다른 바구니로 옮기기
    }
    
    // 현재 바구니에 있는 옷을 다른 바구니로 옮기기
    mutating func move(to basket: inout Basket, isSorted: Bool = false) {
        basket.append(contentsOf: self)     // 다른 바구니로 옮기기
        self.removeAll()                    // 현재 바구니 비우기
        if isSorted {
            basket.sort { $0.preference < $1.preference }       // 선호도에 따라 바구니2 정렬
        }
    }
    
    // 현재 바구니에 있는 옷을 세탁한 뒤, 다른 바구니로 옮기기
    mutating func doTheWash(to basket: inout Basket, isSorted: Bool = false) {
        self.forEach { $0.wash() }              // 옷 세탁
        basket.shuffle()                        // 세탁이 완료된 후 순서 변경 됨
        move(to: &basket, isSorted: isSorted)   // 다른 바구니로 옮기기
    }
}
