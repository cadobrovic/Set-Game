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
			print("CRD: \(card)")
			cards.append(card)
		}
		//shuffleCards()
		print("cards.count: \(cards.count)")
		dealTwelveInitialCards()
		

	}
	
	func dealTwelveInitialCards() {
		for i in 0...11 {
			dealtCards.append(cards.remove(at: 0))
			print("dealtCards: \(dealtCards[i])")
		}
	}
	
	func deal3NewCards() {
		for _ in 0...2 {
			dealtCards.append(cards.remove(at: 0))
		}
	}
	
	func chooseCard(at index: Int) {
		if !selectedCards.contains(dealtCards[index]), selectedCards.count < 3 {
			selectedCards.append(dealtCards[index])
		}
		else if selectedCards.count >= 3 {
			if checkForMatch(selectedCards) {
				dealtCards.removeAll(where: { selectedCards.contains($0) })
				deal3NewCards()
			}
			selectedCards.removeAll()
			selectedCards.append(dealtCards[index])
		}
		else if selectedCards.contains(dealtCards[index]) {
			selectedCards.removeAll(where: { $0 == dealtCards[index] })
		}
		
		if selectedCards.count == 3 {
			
			//TODO: determine actions if match/no match
		}
	}
	
	func checkForMatch(_ selectedCards: [SetCard]) -> Bool  {
		var matchCount = 0
		for i in 0...3 {
			var sortedCards = selectedCards.sorted(by: { $0.props[i] < $1.props[i] })
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
			return true
		}
		else {
			print("NO MATCH")
			return false
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
