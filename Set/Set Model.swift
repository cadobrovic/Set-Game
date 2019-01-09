//
//  Set Model.swift
//  Set
//
//  Created by Karlo Dobrović on 1/6/19.
//  Copyright © 2019 Carlo Dobrović. All rights reserved.
//

import Foundation

class Set {
	var cards = [SetCard]()
	
	var selectedCards = [SetCard]()
	
	
	init(){
		dealTwelveInitialCards()
		//shuffleCards()
		//print("Cards Array initialized: \n \(cards) ")
	}
	
	/**
	Appends 81 unique cards to the `cards` Array
	*/
	func createDeck() {
//		for i in 0...2 {
//			let number = i
//			for j in 0...2 {
//				let symbol = j
//				for k in 0...2 {
//					let shading = k
//					for h in 0...2 {
//						let color = h
//
//						let card = OldCard(withNumber: number, withSymbol: symbol, withShading: shading, withColor: color)
//
//						cards.append(card)
//					}
//				}
//			}
//		}
	}//end func
	
	/**
	Takes the cards array and randomizes the
	elements within.
	*/
	func shuffleCards() {
		for _ in 0...100 {
			for index in cards.indices {
				var temp = SetCard()
				temp = cards[index]
				let randomIndex = cards.count.randomize
				cards[index] = cards[randomIndex]
				cards[randomIndex] = temp
			}//end inner for
		}//end outer for
	}//end func
	
	func dealTwelveInitialCards() {
		for _ in 0...11 {
			let card = SetCard()
			cards.append(card)
		}
		//TODO: Implement dealing initial 12 cards
	}
	
	func chooseCard(at index: Int) {
		//TODO:
		//1. Compare just selected card to array of
		//	 already selected cards.
		if !selectedCards.contains(cards[index]) {
			selectedCards.append(cards[index])
		}
		else if selectedCards.count >= 3 {
			selectedCards.removeAll()
			selectedCards.append(cards[index])
		}
	}
	
	
	
	
	//TODO:
	//	1. Initialize
	//  2. Game Logic
	//  3. New Game
	//  4. Score
}


/**
Takes an Int and returns a random number
between 0 and that Int.

Works with negative signed Ints as well.
*/
extension Int {
	var randomize: Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		}
		else if self < 0 {
			return -Int(arc4random_uniform(UInt32(abs(self))))
		}
		else {
			return 0
		}
	}
	
}
