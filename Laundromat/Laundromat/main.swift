//
//  main.swift
//  Laundromat
//
//  Created by 윤태민 on 8/27/21.
//



import Foundation

// 일주일에 한 번씩 세탁하고, 100주간 반복
print("Total washed number: \(normalLaundrySimulator(stuffNumber: 10, term: 7, repeatNumber: 100, possibility: 0.8, isRandom: true).reduce(0) { $0 + $1.washedNumber })")

// 일주일에 한 번씩 세탁하고, 100주간 반복
print("Total washed number: \(normalLaundrySimulator(stuffNumber: 10, term: 7, repeatNumber: 100, possibility: 0.8, isRandom: false).reduce(0) { $0 + $1.washedNumber })")
