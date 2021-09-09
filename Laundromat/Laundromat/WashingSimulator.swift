//
//  WashingSimulator.swift
//  Laundromat
//
//  Created by 윤태민 on 9/9/21.
//

//  Struct for simulator of washing

import Foundation

struct WashingSimulator {
    private var stuffNumber: UInt           // number of Stuff.
    private var washTerm: UInt              // Term for washing.
    private var repeatNumber: Int           // Number of washing. (total days: washTerm * repeatNumber)
    private var possibility: Double         // Whether wearing or not tody
    
    init(stuffNumber: UInt, washTerm: UInt, repeatNumber: Int, possibility: Double) {
        self.stuffNumber = stuffNumber
        self.washTerm = washTerm
        self.repeatNumber = repeatNumber
        self.possibility = possibility
    }
    
    func run(_ priority: SelectionPriority) -> [Stuff] {
        guard stuffNumber >= washTerm else {
            fatalError("Wash term has to be more than the number of stuff")
        }

        var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
        var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
        var underwears: Array<Stuff> = []                       // 관리할 옷 추가
        underwears.create(stuffNumber, to: &washedBasket)       // 관리할 옷 바구니2에 넣기

        var washedNumber: Int = 0
        while washedNumber < repeatNumber {                     // repeatNumber 만큼 세탁 가능
            var day: Int = 0
            while day < washTerm {                              // 세탁을 위한 주기 카운트
                let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
                if isPossible {                                 // 속옷 입는 날
                    var selectedIndex: Int
                    
                    switch priority {                           // priority에 따라 어떤 속옷을 꺼낼지 정함
                    case .lastInFirstOut:
                        selectedIndex = washedBasket.count - 1
                    case .randomly:
                        selectedIndex = Int.random(in: 0 ..< washedBasket.count)
                    case .byPreference:
                        selectedIndex = washedBasket.maxPreferredIndex!
                    }
                    
                    laundryBasket.append(washedBasket.remove(at: selectedIndex))    // 선택된 속옷을 사용 후에 바구니1에 넣기
                }
                day += 1
            }
            
            laundryBasket.doTheWash()                           // 세탁하기
            laundryBasket.move(to: &washedBasket)               // 바구니2에 넣기
            washedNumber += 1
        }

        underwears.forEach { $0.displayState() }
        return underwears
    }
    
}
