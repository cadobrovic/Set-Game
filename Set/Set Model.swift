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
		//shuffleCards()
		print("cards.count: \(cards.count)")

	}
	
	func dealTwelveInitialCards() {
		for i in 0...11 {
			dealtCards.append(cards[i])
		}
	}
	
	func deal3NewCards() {
		//TODO: Implement
	}
	
	func chooseCard(at index: Int) {
		//TODO:
		//1. Compare just selected card to array of
		//	 already selected cards.
		//2. Determine a match
		if !selectedCards.contains(cards[index]), selectedCards.count < 3 {
			selectedCards.append(cards[index])
		}
		else if selectedCards.count >= 3 {
			selectedCards.removeAll()
			selectedCards.append(cards[index])
		}
		
		if selectedCards.count == 3 {
			checkForMatch(selectedCards)
		}
	}
	
	func checkForMatch(_ selectedCards: [SetCard]) {
		var matchCount = 0
		for i in 0...3 {
			var sortedCards = selectedCards.sorted(by: { $0.props[i] < $1.props[i] })
			print("props[\(i)] should present as: \(sortedCards[0].props[i]) < \(sortedCards[1].props[i]) < \(sortedCards[2].props[i])")
			if sortedCards[0].props[i] == sortedCards[1].props[i] {
				if sortedCards[0].props[i] == sortedCards[2].props[i] {
					print("111 TRUE")
					matchCount += 1
				}
				else {
					print("222 FALSE")
				}
			}
			else {
				if sortedCards[1].props[i] == sortedCards[2].props[i] {
					print("333 FALSE")
				}
				else {
					print("444 TRUE")
					matchCount += 1
				}
			}
		}
		if matchCount == 4 {
			print("MATCH")
		}
		else {
			print("NO MATCH")
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
