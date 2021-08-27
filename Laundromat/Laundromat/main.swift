//
//  main.swift
//  Laundromat
//
//  Created by 윤태민 on 8/27/21.
//

//  Washing simulator:
//  - Objects: daily clothes like underwear.

import Foundation

func doTheWash(_ underwears: [Stuff]) -> [Stuff] {
    underwears.forEach { $0.wash() }
    return underwears
}

func laundrySimulator(stuffsNumber: Int, term: Int, repeatNumber: Int, posibility: Double) -> [Stuff] {
    guard stuffsNumber >= term else {
        fatalError("ther have to be more than the number of stuff")
    }
    var underwears: [Stuff] = []
    for _ in 0 ..< stuffsNumber { underwears.append(Stuff()) }      // 관리할 옷 추가

    var laundryBasket: Array<Stuff> = []            // 세탁할 옷을 넣는 바구니
    var washedBasket: Array<Stuff> = []             // 세탁된 옷을 넣는 바구니
    underwears.forEach { washedBasket.append($0) }  // 세탁된 옷을 바구니에 넣기

    var washedNumber: Int = 0
    while washedNumber < repeatNumber {             // repeatNumber 만큼 세탁 가능
        var day: Int = 0
        while day < term {                          // 세탁을 위한 주기 카운트
            let isPossible: Bool = { Double.random(in: 0.0 ..< 1.0) < posibility }()
            if isPossible {                                         // 속옷 입는 날
                let index: Int = Int.random(in: 0 ..< Stuff.sId)    // 어떤 속옷으 입을지 무작위로 선택
                for i in 0 ..< washedBasket.count {                 // 사용할 속옷이 바구니에 있는지 확인
                    if washedBasket[i] == underwears[index] {
                        washedBasket.remove(at: i)                  // 바구니에서 사용할 속옷 꺼내기
                        laundryBasket.append(underwears[index])     // 사용할 양말 바구니에 넣기
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
            .forEach { washedBasket.append($0) }                // 세탁한 속옷 바구니에 넣기
        laundryBasket.removeAll()                               // 세탁이 완료되었으므로 바구니 비우기
        washedNumber += 1
    }

    underwears.forEach { $0.displayState() }
    return underwears
}

// 일주일에 한 번씩 세탁하고, 100주간 반복
let underwears: [Stuff] = laundrySimulator(stuffsNumber: 10, term: 7, repeatNumber: 100, posibility: 0.8)
var totalWashedNumber: Int = 0
underwears.forEach { totalWashedNumber += $0.washedNumber }
print(totalWashedNumber)


