//
//  main.swift
//  Laundromat
//
//  Created by 윤태민 on 8/27/21.
//



import Foundation

// MARK:- WashingSimulator 객체 생성
// 속옷의 개수: 14
// 세탁 주기: 7일
// 세탁기 돌리는 횟수: 100
// 그 날 속옷을 사용할 확률: 90%
//var simulator = WashingSimulator(stuffNumber: 14, washTerm: 7, repeatNumber: 100, possibility: 0.7)


// MARK:- 임시 바구니 사용 안 함.

// [stuffNumber >= washTerm]
// stuffNumber가 washTerm 보다 작으면 washedBasket이 비는 경우가 생김.
// 따라서  washTerm 만큼의 옷이 필요.

// 속옷을 선택하는 방법(.lastInFirstOut, .byPreference)에 따라 전혀 사용하지 않는 속옷이 생김.
// 무작위로 속옷을 선택하는 경우(.randomly) 조차도 각 속옷에 대해 세탁 횟수의 차이가 발생.

//print("Total washed number: \(simulator.run(.lastInFirstOut).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.randomly).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.byPreference).reduce(0) { $0 + $1.washedNumber })")


// MARK:- washedBasket에 대한 임시 바구니 tmpWashedBasket 추가

// [stuffNumber >= washTerm + 1]
// stuffNumber와 washTerm이 같은 경우, tmpWashedBasket에 stuffNumber만큼의 속옷이 있어 선택을 할 수 없는 경우가 생김.
// 따라서 최소 (washTerm + 1) 만큼의 옷이 필요.

// 속옷을 선택하는 방법(.lastInFirstOut, .byPreference)에 따라 전혀 사용하지 않는 속옷이 생기던 문제가 해결됨.
// 하지만 각 속옷에 대한 세탁 횟수의 차이는 발생하고 있음.
// 특히 선호도에 따라 속옷을 선택할 때 심함.

//print("Total washed number: \(simulator.run(.lastInFirstOut, isTmpWashedBasket: true).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.randomly, isTmpWashedBasket: true).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.byPreference, isTmpWashedBasket: true).reduce(0) { $0 + $1.washedNumber })")


// MARK:- laundryBasket에 대한 임시 바구니 tmpLaundryBasket 추가

// [stuffNumber >= washTerm * 2 - 1]
// 세탁 직전에 tmpLaundryBasket에 (washTerm - 1) 만큼의 옷이 있어서 세탁을 안함.
// 그 다음날 최대 washTerm 갯수만큼 써야함.
// 따라서 최소 (washTerm * 2 - 1) 만큼의 옷이 필요.

//print("Total washed number: \(simulator.run(.lastInFirstOut, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.randomly, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.byPreference, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")


// MARK:- washedBasket, laundryBasket에 대한 임시 바구니 tmpWashedBasket, tmpLaundryBasket 추가

// [stuffNumber >= washTerm * 2]
// 두 번째 경우와 세 번째 경우가 합쳐진 형태.
// 세탁 직전에 tmpLaundryBasket에 (washTerm - 1) 만큼의 옷이 있어서 세탁을 안함.
// stuffNumber와 washTerm이 같은 경우, tmpWashedBasket에 stuffNumber만큼의 속옷이 있어 선택을 할 수 없는 경우가 생김.
// 따라서 최소 (washTerm * 2) 만큼의 옷이 필요.

// 속옷의 개수가 세탁 주기의 2배일 때,
// 속옷을 선택하는 방법에 관계 없이 전부, 거의 동일한 세탁 횟수(최대 차이: 1)를 가짐.

//print("Total washed number: \(simulator.run(.lastInFirstOut, isTmpWashedBasket: true, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.randomly, isTmpWashedBasket: true, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(simulator.run(.byPreference, isTmpWashedBasket: true, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")
