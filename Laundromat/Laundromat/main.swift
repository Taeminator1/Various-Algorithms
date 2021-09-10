//
//  main.swift
//  Laundromat
//
//  Created by 윤태민 on 8/27/21.
//



import Foundation

//  MARK:- normalLaundrySimulator
//  Depending on priority.
//print("Total washed number: \(normalLaundrySimulator(stuffNumber: 10, washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .lastInFirstOut).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(normalLaundrySimulator(stuffNumber: 10, washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .randomly).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(normalLaundrySimulator(stuffNumber: 10, washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .byPreference).reduce(0) { $0 + $1.washedNumber })")

//  MARK:- advancedLaundrySimulator1
//  - 임시 바구니 사용
//  - 전혀 사용하지 않는 속옷은 사라짐
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 10, washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .lastInFirstOut).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 10, washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .randomly).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 10, washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .byPreference).reduce(0) { $0 + $1.washedNumber })")
//
////  옷의 종류가 주기의 배수가 되고, 그 날 옷을 입을 확률이 100%: 모든 옷을 균등하게 사용 가능
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 14, washTerm: 7, repeatNumber: 100, possibility: 1.0, priority: .lastInFirstOut).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 14, washTerm: 7, repeatNumber: 100, possibility: 1.0, priority: .randomly).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 14, washTerm: 7, repeatNumber: 100, possibility: 1.0, priority: .byPreference).reduce(0) { $0 + $1.washedNumber })")


//  MARK:- advancedLaundrySimulator2
//  - 2개의 바구니에 대한 각각의 임시 바구니 사용
//  - 옷의 가짓수가 주기의 2배
//  - 선택 방법에 상관 없이 균등하게 세탁
//print("Total washed number: \(advancedLaundrySimulator2(washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .lastInFirstOut).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(advancedLaundrySimulator2(washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .randomly).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(advancedLaundrySimulator2(washTerm: 7, repeatNumber: 100, possibility: 0.8, priority: .byPreference).reduce(0) { $0 + $1.washedNumber })")


var simulator = WashingSimulator(stuffNumber: 13, washTerm: 7, repeatNumber: 100, possibility: 0.9)
// 서랍의 가장 바깥쪽의 속옷을 꺼낼 경우
//print("Total washed number: \(simulator.run(.lastInFirstOut).reduce(0) { $0 + $1.washedNumber })")
// 무작위로 속옷을 꺼낼 경우
//print("Total washed number: \(simulator.run(.randomly).reduce(0) { $0 + $1.washedNumber })")
// 가장 선호하는 속옷을 꺼낼 경우
//print("Total washed number: \(simulator.run(.byPreference).reduce(0) { $0 + $1.washedNumber })")


// [stuffNumber >= washTerm]
// stuffNumber가 washTerm 보다 작으면 washedBasket이 비는 경우가 생김.
// 따라서  washTerm 만큼의 옷이 필요.
//print("Total washed number: \(simulator.run(.lastInFirstOut).reduce(0) { $0 + $1.washedNumber })")

// [stuffNumber >= washTerm + 1]
// stuffNumber와 washTerm이 같은 경우, tmpWashedBasket에 stuffNumber만큼의 속옷이 있어 선택을 할 수 없는 경우가 생김.
// 따라서 최소 (washTerm + 1) 만큼의 옷이 필요.
//print("Total washed number: \(simulator.run(.lastInFirstOut, isTmpWashedBasket: true).reduce(0) { $0 + $1.washedNumber })")

// [stuffNumber >= washTerm * 2 - 1]
// 세탁 직전에 tmpLaundryBasket에 (washTerm - 1) 만큼의 옷이 있어서 세탁을 안함.
// 그 다음날 최대 washTerm 갯수만큼 써야함.
// 따라서 최소 (washTerm * 2 - 1) 만큼의 옷이 필요.
//print("Total washed number: \(simulator.run(.lastInFirstOut, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")

// stuffNumber >= washTerm * 2
// 두 번째 경우와 세 번째 경우가 합쳐진 형태.
// 세탁 직전에 tmpLaundryBasket에 (washTerm - 1) 만큼의 옷이 있어서 세탁을 안함.
// stuffNumber와 washTerm이 같은 경우, tmpWashedBasket에 stuffNumber만큼의 속옷이 있어 선택을 할 수 없는 경우가 생김.
// 따라서 최소 (washTerm * 2) 만큼의 옷이 필요.
print("Total washed number: \(simulator.run(.lastInFirstOut, isTmpWashedBasket: true, isTmpLaundryBasket: true).reduce(0) { $0 + $1.washedNumber })")
