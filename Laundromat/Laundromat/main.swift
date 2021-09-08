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



