//
//  Basket.swift
//  Laundromat
//
//  Created by 윤태민 on 8/31/21.
//

import Foundation

typealias Basket = Array<Stuff>

extension Array where Element == Stuff {
    
    // 선호도가 가장 높은 Stuff의 인덱스 반환
    var maxPreferredIndex: Int? {
        if self.isEmpty { return nil }
        
        var tmpMaxPreferredIndex: Int = 0
        var tmpMaxPreference: Int = self[0].preference
        
        for i in 1 ..< self.count {
            let tmpPreference: Int = self[i].preference
            if tmpPreference > tmpMaxPreference {
                tmpMaxPreferredIndex = i
                tmpMaxPreference = tmpPreference
            }
        }
        
        return tmpMaxPreferredIndex
    }
    
    // 초기에 관리할 항목 추가
    mutating func create(_ number: Int, to basket: inout Basket) {
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
    mutating func doTheWash(isSorted: Bool = false) {
        self.forEach { $0.wash() }              // 옷 세탁
        self.shuffle()                          // 세탁 시에 옷이 섞임
    }
}
