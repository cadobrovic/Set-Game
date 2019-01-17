//
//  Set Model.swift
//  Set
//
//  Created by Karlo Dobrović on 1/6/19.
//  Copyright © 2019 Carlo Dobrović. All rights reserved.
//

import Foundation

class SetGame {
	var deck = [SetCard]()
	var selectedCards = Set<SetCard>()
	var matchedCards = [SetCard]()
	var matchedDictionary = [Int:Set<SetCard>]()
	var dealtCards = [SetCard]()
	var playerHasMatch = false
	var score = 0
	var startTime = Date()
	init(){
		startNewGame()
	}
	
	func dealTwelveInitialCards() {
		for _ in 0...11 {
			dealtCards.append(deck.remove(at: 0))
		}
	}
	
	func deal3NewCards() {
		analyzeForMatch(in: dealtCards)
		if matchedDictionary.count > 0 {
			startTime = Date()
			score -= score >= 20 ? 20 : score
			print("There was a match!")
		}
		
		if deck.count >= 3, dealtCards.count < 24 {
				for _ in 0...2 {
					dealtCards.append(deck.remove(at: 0))
				}
		}
		else {
			print("NOT ENOUGH SPACE IN UI")
		}
		analyzeForMatch(in: dealtCards)
	}
	
	func startNewGame() {
		selectedCards.removeAll()
		dealtCards.removeAll()
		deck.removeAll()
		score = 0
		SetCard.reset()
		for _ in 0...80 {
			let card = SetCard()
			deck.append(card)
		}
		shuffleCards()
		dealTwelveInitialCards()
		analyzeForMatch(in: dealtCards)
		startTime = Date()
	}
	
	func chooseCard(at index: Int) {
		analyzeForMatch(in: dealtCards)
		let elapsed = Date().timeIntervalSince(startTime)
		if !selectedCards.contains(dealtCards[index]), selectedCards.count < 3 {
			selectedCards.insert(dealtCards[index])
			if selectedCards.count == 3 {
				playerHasMatch = assessSelectedCards(with: selectedCards) ? true : false
			}
		}
		else if !selectedCards.contains(dealtCards[index]), selectedCards.count >= 3 {
			if playerHasMatch && deck.count == 0 {
				playerHasMatch = false
				print("FOO")
				addPoints(for: elapsed)
				dealtCards.removeAll(where: { selectedCards.contains($0) })
				selectedCards.removeAll()
				
				selectedCards.insert(dealtCards[index-(index-(dealtCards.count-1))])
			}
			else {
				print("BAR")
				if playerHasMatch {
					addPoints(for: elapsed)
					startTime = Date()
					replaceCards()
					playerHasMatch = false
				}
				selectedCards.removeAll()
				selectedCards.insert(dealtCards[index])
			}
		}
		else if selectedCards.contains(dealtCards[index]) {
			if !playerHasMatch {
				//player looses 5 points for deselection of
				//non-mathing cards.
				score -= score >= 5 ? 5 : score
			}
			selectedCards.remove(dealtCards[index])
			playerHasMatch = false
		}
	}
	
//	func checkForMatch(amongCards selectedCards: Set<SetCard>) {
//		var matchCount = 0
//		//for all 4 properties
//		for i in 0...3 {
//			var sortedCards = selectedCards.sorted(by: { $0.props[i] < $1.props[i] })
//			if sortedCards[0].props[i] == sortedCards[1].props[i] {
//				if sortedCards[0].props[i] == sortedCards[2].props[i] {
//					matchCount += 1
//				}
//			}
//			else {
//				if !(sortedCards[1].props[i] == sortedCards[2].props[i]) {
//					matchCount += 1
//				}
//			}
//		}
//		if matchCount == 4 {
//			for card in selectedCards {
//				matchedCards.append(card)
//			}
////			playerHasMatch = true
//		}
////		else {
////			playerHasMatch = false
////		}
//	}//end func

	
	func replaceCards() {
		dealtCards.removeAll(where: { selectedCards.contains($0) })
		deal3NewCards()
	}
	
	func addPoints(for elapsedTime: TimeInterval) {
		print("POINTS ADDED")
		switch elapsedTime{
		case 0.0..<10.0:
			score += 100
		case 10.0..<30.0:
			score += 50
		case 30.0..<120.0:
			score += 20
		default:
			score += 10
		}
	}

	/**
	Takes the cards array and randomizes the
	elements within.
	*/
	func shuffleCards() {
		for _ in 0...100 {
			for index in deck.indices {
				var temp = SetCard()
				temp = deck[index]
				let randomIndex = deck.count.randomize
				deck[index] = deck[randomIndex]
				deck[randomIndex] = temp
			}//end inner for
		}//end outer for
	}//end func
	
	/**
	Takes an Array of SetCard structs and checks every combination
	of the SetCards for a match according to the rules of Set.
	Combinations that conform to the match rules then populate
	the global Dictionary `matchedDictionary`, which is empited each
	time this function is invoked.
	
	-Param: cards is an Array of SetCard sturcts.
	*/
	func analyzeForMatch(in cards: [SetCard]) {
		var keyIncrementor = 0
		matchedDictionary.removeAll()
		var matchCount = 0
		for x in 0..<cards.count {
			for y in (x+1)..<cards.count {
				for z in (y+1)..<cards.count {
					let isolatedCards = [cards[x], cards[y], cards[z]]
					
					for i in 0...3 {
						var sortedCards = isolatedCards.sorted(by: { $0.props[i] < $1.props[i] })
						if sortedCards[0].props[i] == sortedCards[1].props[i] {
							if sortedCards[0].props[i] == sortedCards[2].props[i] {
								matchCount += 1
							}
						}
						else {
							if !(sortedCards[1].props[i] == sortedCards[2].props[i]) {
								matchCount += 1
							}
						}
					}
					if matchCount == 4 {
						keyIncrementor += 1
					matchedDictionary.updateValue([isolatedCards[0], isolatedCards[1], isolatedCards[2]], forKey: keyIncrementor)
						matchCount = 0
						print("THERE IS A MATCH!")
					}
					matchCount = 0
				}//end inner-most for
			}
		}
	}//end func
	
	/**
	Tests wether a given Set of SetCards conforms to rules
	of a match in the game of Set by comparing it with values
	in the `matchedDictionary` Dictionary.
	
	-Return a boolean value indicating conformity to match rules.
	*/
	func assessSelectedCards(with cards: Set<SetCard>) -> Bool {
		var hasMatch = false
		for entry in matchedDictionary.values {
			if cards == entry {
				hasMatch = true
				print("\thasMatch = true")
				print("\tcards: \n\(cards)")
				print("\tentry: \n\(entry)")
			}
		}
		return hasMatch
	}
}//end class
