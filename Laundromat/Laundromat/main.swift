//
//  main.swift
//  Laundromat
//
//  Created by 윤태민 on 8/27/21.
//



import Foundation

//  MARK:- normalLaundrySimulator
//  - 일주일에 한 번씩 세탁하고, 100주간 반복

//  선호도 반영 x:
//  - 옷을 균등하게 사용 가능
//print("Total washed number: \(normalLaundrySimulator(stuffNumber: 10, term: 7, repeatNumber: 100, possibility: 0.8, isRandom: true).reduce(0) { $0 + $1.washedNumber })")

//  선호도 반영 o:
//  - 선호도가 높은 옷을 많이 사용하는 경향이 생김
//print("Total washed number: \(normalLaundrySimulator(stuffNumber: 10, term: 7, repeatNumber: 100, possibility: 0.8, isRandom: false).reduce(0) { $0 + $1.washedNumber })")

//  MARK:- advancedLaundrySimulator1
//  - 임시 바구니 사용

//  선호도 반영 x
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 10, term: 7, repeatNumber: 1000, possibility: 0.8, isRandom: true).reduce(0) { $0 + $1.washedNumber })")

//  선호도 반영 o:
//  - 전혀 사용하지 않는 옷은 없어짐
//  - 선호도에 따른 사용 불균일이 어느 정도 사라졌지만, 여전히 심함
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 10, term: 7, repeatNumber: 1000, possibility: 0.8, isRandom: false).reduce(0) { $0 + $1.washedNumber })")

//  옷의 종류가 주기의 배수가 되고, 그 날 옷을 입을 확률이 100%:
//  - 모든 옷을 균등하게 사용 가능
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 14, term: 7, repeatNumber: 100, possibility: 1.0, isRandom: true).reduce(0) { $0 + $1.washedNumber })")
//print("Total washed number: \(advancedLaundrySimulator1(stuffNumber: 14, term: 7, repeatNumber: 100, possibility: 1.0, isRandom: false).reduce(0) { $0 + $1.washedNumber })")


//  MARK:- advancedLaundrySimulator2
//  - 2개의 바구니에 대한 각각의 임시 바구니 사용
//  - 옷의 가짓수가 주기의 2배

//  - 선호도에 따라 선택할지 무작위로 선택할지에 상관 없이 모든 옷을 균등하게 사용 가능
print("Total washed number: \(advancedLaundrySimulator2(stuffNumber: 14, term: 7, repeatNumber: 100, possibility: 0.8, isRandom: true).reduce(0) { $0 + $1.washedNumber })")
print("Total washed number: \(advancedLaundrySimulator2(stuffNumber: 14, term: 7, repeatNumber: 100, possibility: 0.8, isRandom: false).reduce(0) { $0 + $1.washedNumber })")
