//
//  Simulators.swift
//  Laundromat
//
//  Created by 윤태민 on 8/28/21.
//

//  Washing simulators:
//  - Instance of Stuff Class represented daily clotehs like underwear.

import Foundation

//  How to select stuff from basket.
enum SelectionPriority {
    case lastInFirstOut
    case randomly
    case byPreference
}

//  - stuffNumber: number of stuff.
//  - washTerm: Term for washing.
//  - repeatNumber: Number of washing. (total days: washTerm * repeatNumber)
//  - possibility: Whether wearing or not today
//  - priority: Selection priority
func normalLaundrySimulator(stuffNumber: UInt, washTerm: UInt, repeatNumber: UInt, possibility: Double = 1.0, priority: SelectionPriority) -> [Stuff] {
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

//  Add temporary basket for property in the fucntion
//  - tmpWashedBasket: Stuff will be kept there at first after washing. If washedBasket is empty, all stuff in the tmpBasket will be moved to the washedBasket.
func advancedLaundrySimulator1(stuffNumber: UInt, washTerm: UInt, repeatNumber: UInt, possibility: Double = 1.0, priority: SelectionPriority) -> [Stuff] {
    guard stuffNumber >= washTerm else {
        fatalError("Wash term has to be more than the number of stuff")
    }
    
    var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
    var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
    var underwears: Array<Stuff> = []                       // 관리할 옷 추가
    underwears.create(stuffNumber, to: &washedBasket)       // 관리할 옷 바구니2에 넣기
    var tmpBasket: Basket = []                              // 세탁된 옷을 보관하는 임시 바구니1

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
                
                if washedBasket.isEmpty {                   // 바구니2가 비어있을 경우, 임시 바구니에서 가져오기
                    tmpBasket.move(to: &washedBasket, isSorted: true)
                }
            }
            day += 1
        }
        
        laundryBasket.doTheWash()                           // 세탁하기
        laundryBasket.move(to: &tmpBasket)                  // 임시 바구니에 넣기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

//  Add temporary baskets for properties in the fucntion
//  - tmpLaundryBasket: Stuff will be kept there at first after using. If the number of stuff in the tmpLaundryBasket is wash term, all stuff will be moved to the laundryBasket.
//  - tmpWashedBasket: Stuff will be kept there at first after washing. If washedBasket is empty, all stuff in the tmpWashedBasket will be moved to the washedBasket.
func advancedLaundrySimulator2(washTerm: UInt, repeatNumber: UInt, possibility: Double = 1.0, priority: SelectionPriority) -> [Stuff] {
    guard washTerm > 0 else {
        fatalError("Wash term has to be more than zero.")
    }
    
    var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
    var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
    var underwears: Array<Stuff> = []                       // 관리할 옷 추가
    underwears.create(washTerm * 2, to: &washedBasket)      // 세탁 주기의 두 배만큼 관리할 옷 바구니2에 넣기
    var tmpLaundryBasket: Basket = []                       // 세탁할 옷을 보관하는 임시 바구니1
    var tmpWashedBasket: Basket = []                        // 세탁된 옷을 보관하는 임시 바구니2

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {                     // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < washTerm {                              // 세탁을 위한 주기 카운트
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {
                var selectedIndex: Int
                
                switch priority {                           // priority에 따라 어떤 속옷을 꺼낼지 정함
                case .lastInFirstOut:
                    selectedIndex = washedBasket.count - 1
                case .randomly:
                    selectedIndex = Int.random(in: 0 ..< washedBasket.count)
                case .byPreference:
                    selectedIndex = washedBasket.maxPreferredIndex!
                }
                
                tmpLaundryBasket.append(washedBasket.remove(at: selectedIndex))     // 선택된 속옷을 사용 후에 임시 바구니1에 넣기
                
                if washedBasket.isEmpty {                   // 바구니2가 비어있을 경우, 임시 바구니2에서 가져오기
                    tmpWashedBasket.move(to: &washedBasket)
                }
                if tmpLaundryBasket.count == washTerm {     // 임시 바구니1에 속옷의 개수가 washTerm이 되면 바구니1로 옮기기
                    tmpLaundryBasket.move(to: &laundryBasket)
                }
            }
            day += 1
        }
        
        laundryBasket.doTheWash()                           // 세탁하기
        laundryBasket.move(to: &tmpWashedBasket)            // 임시 바구니2에 넣기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

