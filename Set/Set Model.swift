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
		dealTwelveInitialCards()
		//shuffleCards()
	}
	
	func dealTwelveInitialCards() {
		for _ in 0...11 {
			let card = SetCard()
			cards.append(card)
			dealtCards.append(card)
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
	
	
	
	
	//TODO:
	//	1. Initialize
	//  2. Game Logic
	//  3. New Game
	//  4. Score
}
