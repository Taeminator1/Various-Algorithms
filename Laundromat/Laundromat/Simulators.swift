//
//  Simulators.swift
//  Laundromat
//
//  Created by 윤태민 on 8/28/21.
//

//  Washing simulators:
//  - Instance of Stuff Class represented daily clotehs like underwear.

import Foundation

//  - stuffNumber: number of stuff.
//  - term: term for washing.
//  - repeatNumber: number of washing. (total days: term * repeatNumber)
//  - possibility: whether wearing or not today
//  - isRandom: way to select stuff
func normalLaundrySimulator(stuffNumber: Int, term: Int, repeatNumber: Int, possibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffNumber >= term else {
        fatalError("Term has to be more than the number of stuff")
    }
    
    var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
    var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
    var underwears: Array<Stuff> = []                       // 관리할 옷 추가
    underwears.addAtFirst(stuffNumber, to: &washedBasket)   // 관리할 옷 바구니2에 넣기
    
    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < term {                          // 세탁을 위한 주기 카운트
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                if isRandom {
                    let selectedIndex: Int = Int.random(in: 0 ..< washedBasket.count)
                    // 바구니2에 있는 속옷과 전체 속옷 대조하여 일치할 때, 바구니2에서 사용할 속옷을 꺼내고, 사용 후 바구니1에 넣기
                    for i in 0 ..< underwears.count {
                        if underwears[i] == washedBasket[selectedIndex] {
                            laundryBasket.append(washedBasket.remove(at: selectedIndex))
                            day += 1
                            break
                        }
                    }
                }
                else {
                    laundryBasket.append((washedBasket.removeLast()))   // 바구니2에서 사용할 속옷 꺼내고, 사용 후 바구니1에 넣기
                    day += 1
                }
            }
            else {
                day += 1
            }
        }
        
        laundryBasket.doTheWash(to: &washedBasket, isSorted: true)      // 세탁 후, 바구니2에 넣기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

//  Add temporary basket for property in the fucntion
//  - tmpWashedBasket: Stuff will be kept there at first after washing. If washedBasket is empty, all stuff in the tmpBasket will be moved to the washedBasket.
func advancedLaundrySimulator1(stuffNumber: Int, term: Int, repeatNumber: Int, possibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffNumber >= term else {
        fatalError("Term has to be more than the number of stuff")
    }
    
    var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
    var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
    var underwears: Array<Stuff> = []                       // 관리할 옷 추가
    underwears.addAtFirst(stuffNumber, to: &washedBasket)   // 관리할 옷 바구니2에 넣기
    var tmpBasket: Basket = []                              // 세탁된 옷을 보관하는 임시 바구니1

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < term {                          // 세탁을 위한 주기 카운트
            if washedBasket.isEmpty {               // 바구니2가 비어있을 경우, 임시 바구니에서 가져오기
                tmpBasket.move(to: &washedBasket, isSorted: true)
            }
            
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                if isRandom {
                    let selectedIndex: Int = Int.random(in: 0 ..< washedBasket.count)
                    // 바구니2에 있는 속옷과 전체 속옷 대조하여 일치할 때, 바구니2에서 사용할 속옷을 꺼내고, 사용 후 바구니1에 넣기
                    for i in 0 ..< underwears.count {
                        if underwears[i] == washedBasket[selectedIndex] {
                            laundryBasket.append(washedBasket.remove(at: selectedIndex))
                            day += 1
                            break
                        }
                    }
                }
                else {
                    laundryBasket.append((washedBasket.removeLast()))   // 바구니2에서 사용할 속옷 꺼내고, 사용 후 바구니1에 넣기
                    day += 1
                }
            }
            else {
                day += 1
            }
        }
        
        laundryBasket.doTheWash(to: &tmpBasket)                         // 세탁 후, 임시 바구니에 넣기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

//  Add temporary baskets for properties in the fucntion
//  - tmpLaundryBasket: Stuff will be kept there at first after using. If the number of stuff in the tmpLaundryBasket is term, all stuff will be moved to the laundryBasket.
//  - tmpWashedBasket: Stuff will be kept there at first after washing. If washedBasket is empty, all stuff in the tmpWashedBasket will be moved to the washedBasket.
func advancedLaundrySimulator2(stuffNumber: Int, term: Int, repeatNumber: Int, possibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffNumber >= term else {
        fatalError("Term has to be more than the number of stuff")
    }
    
    var laundryBasket: Basket = []                          // 세탁할 옷을 넣는 바구니1
    var washedBasket: Basket = []                           // 세탁된 옷을 넣는 바구니2
    var underwears: Array<Stuff> = []                       // 관리할 옷 추가
    underwears.addAtFirst(stuffNumber, to: &washedBasket)   // 관리할 옷 바구니2에 넣기
    var tmpLaundryBasket: Basket = []                       // 세탁할 옷을 보관하는 임시 바구니1
    var tmpWashedBasket: Basket = []                        // 세탁된 옷을 보관하는 임시 바구니2

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < term {                          // 세탁을 위한 주기 카운트
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                if isRandom {
                    let selectedIndex: Int = Int.random(in: 0 ..< washedBasket.count)
                    // 바구니2에 있는 속옷과 전체 속옷 대조하여 일치할 때, 바구니2에서 사용할 속옷을 꺼내고, 사용 후 임시 바구니1에 넣기
                    for i in 0 ..< underwears.count {
                        if underwears[i] == washedBasket[selectedIndex] {
                            tmpLaundryBasket.append(washedBasket.remove(at: selectedIndex))
                            if washedBasket.isEmpty {                   // 바구니2가 비어있을 경우, 임시 바구니2에서 가져오기
                                tmpWashedBasket.move(to: &washedBasket, isSorted: true)
                            }
                            if tmpLaundryBasket.count == term {         // 임시 바구니1에 속옷의 개수가 term이 되면 바구니1로 옮기기
                                tmpLaundryBasket.move(to: &laundryBasket)
                            }
                            day += 1
                            break
                        }
                    }
                }
                else {
                    tmpLaundryBasket.append(washedBasket.removeLast())  // 바구니2에서 사용할 속옷을 꺼내고, 임시 바구니1에 넣기
                    if washedBasket.isEmpty {                           // 바구니2가 비어있을 경우, 임시 바구니2에서 가져오기
                        tmpWashedBasket.move(to: &washedBasket, isSorted: true)
                    }
                    if tmpLaundryBasket.count == term {                 // 임시 바구니1에 속옷의 개수가 term이 되면 바구니1로 옮기기
                        tmpLaundryBasket.move(to: &laundryBasket)
                    }
                    day += 1
                }
            }
            else {
                day += 1
            }
        }
        
        laundryBasket.doTheWash(to: &tmpWashedBasket)                   // 세탁 후, 임시 바구니2에 넣기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}
