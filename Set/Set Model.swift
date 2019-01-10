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
	var dealtCards = [SetCard]()
	init(){
		for _ in 0...80 {
			let card = SetCard()
			cards.append(card)
		}
		dealTwelveInitialCards()
		shuffleCards()
		print("cards.count: \(cards.count)")

	}
	
	func dealTwelveInitialCards() {
		for i in 0...11 {
			dealtCards.append(cards[i])
		}
	}
	
	func deal3NewCards() {
		
	}
	
	func chooseCard(at index: Int) {
		//TODO:
		//1. Compare just selected card to array of
		//	 already selected cards.
		if !selectedCards.contains(cards[index]), selectedCards.count < 3 {
			selectedCards.append(cards[index])
		}
		else if selectedCards.count >= 3 {
			selectedCards.removeAll()
			selectedCards.append(cards[index])
		}
	}
	
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
	
	
	
	
	//TODO:
	//	1. Initialize
	//  2. Game Logic
	//  3. New Game
	//  4. Score
}
