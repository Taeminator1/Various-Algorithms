//
//  Simulators.swift
//  Laundromat
//
//  Created by 윤태민 on 8/28/21.
//

//  Washing simulators:
//  - Instance of Stuff Class represented daily clotehs like underwear.

import Foundation

//  Run wash method from the instances
func doTheWash(_ underwears: [Stuff]) -> [Stuff] {
    underwears.forEach { $0.wash() }
    return underwears.shuffled()            // 세탁이 완료된 후 꺼낼 때는 순서가 없음
}

//  - stuffNumber: number of stuff.
//  - term: term for washing.
//  - repeatNumber: number of washing. (total days: term * repeatNumber)
//  - possibility: whether wearing or not today
//  - isRandom: way to select stuff
func normalLaundrySimulator(stuffNumber: Int, term: Int, repeatNumber: Int, possibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffNumber >= term else {
        fatalError("Term has to be more than the number of stuff")
    }
    var underwears: [Stuff] = []
    Stuff.sPreference = 0
    for _ in 0 ..< stuffNumber { underwears.append(Stuff()) }      // 관리할 옷 추가

    var laundryBasket: Array<Stuff> = []            // 세탁할 옷을 넣는 바구니1
    var washedBasket: Array<Stuff> = []             // 세탁된 옷을 넣는 바구니2
    underwears.forEach { washedBasket.append($0) }  // 세탁된 옷을 바구니2에 넣기

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < term {                          // 세탁을 위한 주기 카운트
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {                                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                if isRandom {
                    let id: Int = Int.random(in: 0 ..< Stuff.sPreference)
                    for i in 0 ..< washedBasket.count {                         // 사용할 속옷이 바구니2에 있는지 확인
                        if washedBasket[i] == underwears[id] {
                            laundryBasket.append(washedBasket.remove(at: i))    // 바구니2에서 사용할 속옷 꺼내고, 사용 후 바구니1에 넣기
                            day += 1
                            break
                        }
                    }
                }
                else {
                    laundryBasket.append((washedBasket.removeLast()))           // 바구니2에서 사용할 속옷 꺼내고, 사용 후 바구니1에 넣기
                    day += 1
                }
            }
            else {
                day += 1
            }
        }
        
        washedBasket.append(contentsOf: doTheWash(laundryBasket))   // 세탁한 속옷을 바구니2에 넣기
        washedBasket.sort { $0.preference < $1.preference }         // 선호도에 따라 바구니2 정렬
        laundryBasket.removeAll()                                   // 바구니2에 옮겼으므로 바구니1 비우기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

// Add temporary basket.
func advancedLaundrySimulator1(stuffNumber: Int, term: Int, repeatNumber: Int, possibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffNumber >= term else {
        fatalError("Term has to be more than the number of stuff")
    }
    var underwears: [Stuff] = []
    Stuff.sPreference = 0
    for _ in 0 ..< stuffNumber { underwears.append(Stuff()) }      // 관리할 옷 추가

    var laundryBasket: Array<Stuff> = []            // 세탁할 옷을 넣는 바구니1
    var washedBasket: Array<Stuff> = []             // 세탁된 옷을 넣는 바구니2
    underwears.forEach { washedBasket.append($0) }  // 세탁된 옷을 바구니2에 넣기
    
    var tmpBasket: Array<Stuff> = []               // 건조된 옷을 보관하는 임시 바구니1

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < term {                          // 세탁을 위한 주기 카운트
            
            while washedBasket.isEmpty {               // 바구니2가 비어있을 경우 바구니3에서 가져오기
                washedBasket.append(contentsOf: tmpBasket)
                tmpBasket.removeAll()
                washedBasket.sort { $0.preference < $1.preference }         // 선호도에 따라 바구니2 정렬
            }
            
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < possibility }()
            if isPossible {                                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                if isRandom {
                    let id: Int = Int.random(in: 0 ..< Stuff.sPreference)
                    for i in 0 ..< washedBasket.count {                         // 사용할 속옷이 바구니2에 있는지 확인
                        if washedBasket[i] == underwears[id] {
                            laundryBasket.append(washedBasket.remove(at: i))    // 바구니2에서 사용할 속옷 꺼내고, 사용 후 바구니1에 넣기
                            day += 1
                            break
                        }
                    }
                }
                else {
                    laundryBasket.append((washedBasket.removeLast()))           // 바구니2에서 사용할 속옷 꺼내고, 사용 후 바구니1에 넣기
                    day += 1
                }
            }
            else {
                day += 1
            }
        }
        
        tmpBasket.append(contentsOf: doTheWash(laundryBasket))     // 세탁한 속옷을 임시 바구니에 넣기
        laundryBasket.removeAll()                                   // 바구니3에 옮겼으므로 바구니1 비우기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

