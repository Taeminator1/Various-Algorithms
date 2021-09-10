//
//  WashingSimulator.swift
//  Laundromat
//
//  Created by 윤태민 on 9/9/21.
//

//  Struct for simulator of washing

import Foundation

struct WashingSimulator {
    private var stuffNumber: UInt               // number of Stuff.
    private var washTerm: Int                   // Term for washing.
    private var repeatNumber: Int               // Number of washing. (total days: washTerm * repeatNumber)
    private var possibility: Double             // Whether wearing or not tody
    
    private var washedBasket: Basket = []       // 세탁된 옷을 넣는 바구니1
    private var laundryBasket: Basket = []      // 세탁할 옷을 넣는 바구니2
    private var tmpWashedBasket: Basket = []    // 세탁된 옷을 보관하는 임시 바구니1
    private var tmpLaundryBasket: Basket = []   // 세탁할 옷을 보관하는 임시 바구니2
    
    init(stuffNumber: UInt, washTerm: Int, repeatNumber: Int, possibility: Double) {
        self.stuffNumber = stuffNumber
        self.washTerm = washTerm
        self.repeatNumber = repeatNumber
        self.possibility = possibility
    }
    
    mutating func run(_ priority: SelectionPriority, isTmpWashedBasket: Bool = false, isTmpLaundryBasket: Bool = false) -> [Stuff] {
        if isTmpWashedBasket == false && isTmpLaundryBasket == false {
            guard stuffNumber >= washTerm else {
                fatalError("The number of stuff must be more than or equal to the washing term")
            }
        }
        else if isTmpWashedBasket == true && isTmpLaundryBasket == false {
            guard stuffNumber >= washTerm + 1 else {
                fatalError("The number of stuff must be more than the washing term")
            }
        }
        else if isTmpWashedBasket == false && isTmpLaundryBasket == true {
            guard stuffNumber >= washTerm * 2 - 1 else {
                fatalError("The number of stuff must be more than or equal to the twice washing term minus one")
            }
        }
        else {
            guard stuffNumber >= washTerm * 2 else {
                fatalError("The number of stuff must be more than or equal to the twice washing term")
            }
        }

        initializeBasket()
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
                    
                    // 선택된 속옷을 사용 후에 바구니2 또는 임시 바구니2에 넣기
                    selectBasket(isTmpLaundryBasket, &laundryBasket, &tmpLaundryBasket) {
                        $0.append(washedBasket.remove(at: selectedIndex))
                    }
                    if washedBasket.isEmpty {                   // isTmpWashedBasket이 false인 경우, 항상 빈 배열 전달.
                        tmpWashedBasket.move(to: &washedBasket)
                    }
                    if tmpLaundryBasket.count == washTerm {     // isTmpLaundryBasket이 false인 경우 무시 됨.
                        tmpLaundryBasket.move(to: &laundryBasket)
                    }
                }
                
                day += 1
            }
            
            laundryBasket.doTheWash()                                           // 세탁하기
            selectBasket(isTmpWashedBasket, &washedBasket, &tmpWashedBasket) {  // 세탁한 후에 바구니1 또는 임시 바구니1에 넣기
                laundryBasket.move(to: &($0))
            }
            
            washedNumber += 1
        }
        
        underwears.forEach { $0.displayState() }
        return underwears
    }
    
    private mutating func initializeBasket() {
        washedBasket = []
        laundryBasket = []
        tmpWashedBasket = []
        tmpLaundryBasket = []
    }
    
    private func selectBasket(_ isTmpBasket: Bool, _ basket: inout Basket, _ tmpBasket: inout Basket, f: (inout Basket) -> Void) {
        isTmpBasket ? f(&tmpBasket) : f(&basket)
    }
}
