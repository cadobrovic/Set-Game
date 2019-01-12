//
//  SetCard.swift
//  Set
//
//  Created by Karlo Dobrović on 1/6/19.
//  Copyright © 2019 Carlo Dobrović. All rights reserved.
//

import Foundation

struct SetCard: Hashable {
	
	var hashValue: Int { return identifier }
	
	// [symbol, numberOfSymbols, fill, color]
	var props: [Int] = []
	var isMatched = false
	private var identifier: Int
	private static var identifierFactory = 0
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
	
	private static var symFac = 0
	private static var numFac = 0
	private static var fillFac = 0
	private static var colorFac = 0
	private static var incrementor = 0
	
	private static func getUniqueProps() -> [Int] {
		incrementor += 1
		colorFac.loop1To3()
		if (incrementor - 1) % 3 == 0 {
			 fillFac.loop1To3()
		}
		if(incrementor - 1) % 9 == 0 {
			numFac.loop1To3()
		}
		if(incrementor - 1) % 27 == 0 {
			symFac.loop1To3()
		}
		return [symFac, numFac, fillFac, colorFac]
	}
	
	static func reset(){
		symFac = 0
		numFac = 0
		fillFac = 0
		colorFac = 0
		incrementor = 0
	}
	
	init() {
		self.props = SetCard.getUniqueProps()
		self.identifier = SetCard.getUniqueIdentifier()
	}
	
	static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}//end struct

extension Int {
	mutating func loop1To3() {
		if self < 3 {
			self = self + 1
		}
		else {
			self = self - 2
		}
	}
}
