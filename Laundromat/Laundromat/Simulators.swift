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
    return underwears
}

func normalLaundrySimulator(stuffsNumber: Int, term: Int, repeatNumber: Int, posibility: Double = 1.0, isRandom: Bool = true) -> [Stuff] {
    guard stuffsNumber >= term else {
        fatalError("Term has to be more than the number of stuff")
    }
    var underwears: [Stuff] = []
    Stuff.sId = 0
    for _ in 0 ..< stuffsNumber { underwears.append(Stuff()) }      // 관리할 옷 추가

    var laundryBasket: Array<Stuff> = []            // 세탁할 옷을 넣는 바구니1
    var washedBasket: Array<Stuff> = []             // 세탁된 옷을 넣는 바구니2
    underwears.forEach { washedBasket.append($0) }  // 세탁된 옷을 바구니2에 넣기

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < term {                          // 세탁을 위한 주기 카운트
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < posibility }()
            if isPossible {                                         // 속옷 입는 날
                // isRandom에 따라 어떤 속옷을 입을지 선택: 무작위 또는 바구니2의 가장 바깥쪽
                let index: Int = isRandom ? Int.random(in: 0 ..< Stuff.sId) : (washedBasket.count - 1)
                
                for i in 0 ..< washedBasket.count {                 // 사용할 속옷이 바구니2에 있는지 확인
                    if washedBasket[i] == underwears[index] {
                        washedBasket.remove(at: i)                  // 바구니2에서 사용할 속옷 꺼내기
                        laundryBasket.append(underwears[index])     // 사용한 양말 바구니1에 넣기
                        day += 1
                        break
                    }
                }
            }
            else {
                day += 1
            }
        }
        doTheWash(laundryBasket)                                // 세탁하기
            .forEach { washedBasket.append($0) }                // 세탁된 속옷 바구니2에 넣기
        laundryBasket.removeAll()                               // 세탁이 완료되었으므로 바구니1 비우기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}
