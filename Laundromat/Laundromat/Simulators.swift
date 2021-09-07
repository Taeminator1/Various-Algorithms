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
//  - isRandom: Way to select stuff
//  - priority: Selection priority
func normalLaundrySimulator(stuffNumber: Int, washTerm: Int, repeatNumber: Int, possibility: Double = 1.0, priority: SelectionPriority) -> [Stuff] {
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
        while day < washTerm {                                  // 세탁을 위한 주기 카운트
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
                
                laundryBasket.append(washedBasket.remove(at: selectedIndex))
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
func advancedLaundrySimulator1(stuffNumber: Int, washTerm: Int, repeatNumber: Int, possibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffNumber >= washTerm else {
        fatalError("Wash term has to be more than the number of stuff")
    }
    
    var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
    var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
    var underwears: Array<Stuff> = []                       // 관리할 옷 추가
    underwears.create(stuffNumber, to: &washedBasket)       // 관리할 옷 바구니2에 넣기
    var tmpBasket: Basket = []                              // 세탁된 옷을 보관하는 임시 바구니1

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < washTerm {                          // 세탁을 위한 주기 카운트
            if washedBasket.isEmpty {               // 바구니2가 비어있을 경우, 임시 바구니에서 가져오기
                tmpBasket.move(to: &washedBasket, isSorted: true)
            }
            
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                if isRandom {
                    let selectedIndex: Int = Int.random(in: 0 ..< washedBasket.count)
                    // 바구니2에서 사용할 속옷을 꺼내고, 사용 후 바구니1에 넣기
                    laundryBasket.append(washedBasket.remove(at: selectedIndex))
                }
                else {
                    laundryBasket.append((washedBasket.removeLast()))   // 바구니2에서 사용할 속옷 꺼내고, 사용 후 바구니1에 넣기
                }
            }
            day += 1
        }
        
        laundryBasket.doTheWash()                   // 세탁하기
        laundryBasket.move(to: &tmpBasket)          // 임시 바구니에 넣기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

//  Add temporary baskets for properties in the fucntion
//  - tmpLaundryBasket: Stuff will be kept there at first after using. If the number of stuff in the tmpLaundryBasket is wash term, all stuff will be moved to the laundryBasket.
//  - tmpWashedBasket: Stuff will be kept there at first after washing. If washedBasket is empty, all stuff in the tmpWashedBasket will be moved to the washedBasket.
func advancedLaundrySimulator2(stuffNumber: Int, washTerm: Int, repeatNumber: Int, possibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffNumber >= washTerm else {
        fatalError("Wash term has to be more than the number of stuff")
    }
    
    var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
    var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
    var underwears: Array<Stuff> = []                       // 관리할 옷 추가
    underwears.create(stuffNumber, to: &washedBasket)       // 관리할 옷 바구니2에 넣기
    var tmpLaundryBasket: Basket = []                       // 세탁할 옷을 보관하는 임시 바구니1
    var tmpWashedBasket: Basket = []                        // 세탁된 옷을 보관하는 임시 바구니2

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < washTerm {                          // 세탁을 위한 주기 카운트
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                if isRandom {
                    let selectedIndex: Int = Int.random(in: 0 ..< washedBasket.count)
                    // 바구니2에서 사용할 속옷을 꺼내고, 사용 후 임시 바구니1에 넣기
                    tmpLaundryBasket.append(washedBasket.remove(at: selectedIndex))
                    if washedBasket.isEmpty {                   // 바구니2가 비어있을 경우, 임시 바구니2에서 가져오기
                        tmpWashedBasket.move(to: &washedBasket, isSorted: true)
                    }
                    if tmpLaundryBasket.count == washTerm {         // 임시 바구니1에 속옷의 개수가 washTerm이 되면 바구니1로 옮기기
                        tmpLaundryBasket.move(to: &laundryBasket)
                    }
                }
                else {
                    tmpLaundryBasket.append(washedBasket.removeLast())  // 바구니2에서 사용할 속옷을 꺼내고, 임시 바구니1에 넣기
                    if washedBasket.isEmpty {                           // 바구니2가 비어있을 경우, 임시 바구니2에서 가져오기
                        tmpWashedBasket.move(to: &washedBasket, isSorted: true)
                    }
                    if tmpLaundryBasket.count == washTerm {                 // 임시 바구니1에 속옷의 개수가 washTerm이 되면 바구니1로 옮기기
                        tmpLaundryBasket.move(to: &laundryBasket)
                    }
                }
            }
            day += 1
        }
        
        laundryBasket.doTheWash()                   // 세탁하기
        laundryBasket.move(to: &tmpWashedBasket)    // 임시 바구니2에 넣기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

