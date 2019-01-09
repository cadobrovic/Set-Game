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
	
	private var identifier: Int
	private static var identifierFactory = 0
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
	
	init() {
		self.identifier = SetCard.getUniqueIdentifier()
	}
	
	static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}







struct OldCard: Equatable {
	
	var isFaceUp = false
	var isMatched = false
	var isShown = false
	let number: CardNumber
	let symbol: CardSymbol
	let shading: CardShading
	let color: CardColor
	
	
	enum CardNumber {
		case one
		case two
		case three
	}

	enum CardSymbol {

		case diamond
		case squiggle
		case oval
	}

	enum CardShading {
		case solid
		case striped
		case open
	}

	enum CardColor {
		case red
		case green
		case purple
	}
	
	static func ==(lhs: OldCard, rhs: OldCard) -> Bool {
		if lhs.number == rhs.number, lhs.symbol == rhs.symbol, lhs.shading == rhs.shading, lhs.color == rhs.color {
			return true
		}
		else {
			return false
		}
	}
	
	/**
	Initializer creates default card
	*/
	init(){
		number = .one
		symbol = .diamond
		shading = .solid
		color = .red
	}
	

	
	/**
	Initializer creates a SetCard with specifications
	*/
	init(withNumber: Int, withSymbol: Int, withShading: Int, withColor: Int) {
		switch withNumber {
		case 0:
			number = CardNumber.one
		case 1:
			number = CardNumber.two
		case 2:
			number = CardNumber.three
		default:
			print("error in card number init")
			number = CardNumber.one
		}
		switch withSymbol {
		case 0:
			symbol = CardSymbol.diamond
		case 1:
			symbol = CardSymbol.squiggle
		case 2:
			symbol = CardSymbol.oval
		default:
			print("error in card symbol init")
			symbol = CardSymbol.diamond
		}
		switch withShading {
		case 0:
			shading = CardShading.solid
		case 1:
			shading = CardShading.striped
		case 2:
			shading = CardShading.open
		default:
			print("error in card shading init")
			shading = CardShading.solid
		}
		switch withColor{
		case 0:
			color = CardColor.red
		case 1:
			color = CardColor.green
		case 2:
			color = CardColor.purple
		default:
			print("error in card color init")
			color = CardColor.red
		}
	}
	
	
	
	
	//TODO:
	// 2. Create internal variables
	// 3. Draw icons — NSAttributedString
	
	
}
