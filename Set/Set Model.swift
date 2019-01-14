//
//  Set Model.swift
//  Set
//
//  Created by Karlo Dobrović on 1/6/19.
//  Copyright © 2019 Carlo Dobrović. All rights reserved.
//

import Foundation

class Set {
	var deck = [SetCard]()
	var selectedCards = [SetCard]()
	var dealtCards = [SetCard]()
	var hasMatch = false
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
		if deck.count >= 3, dealtCards.count < 24 {
				for _ in 0...2 {
					dealtCards.append(deck.remove(at: 0))
				}
		}
		else {
			print("NOT ENOUGH SPACE IN UI")
		}
	}
	
	func startNewGame() {
		selectedCards.removeAll()
		dealtCards.removeAll()
		deck.removeAll()
		score = 0
		SetCard.reset()
		for _ in 0...14 {
			let card = SetCard()
			deck.append(card)
		}
		shuffleCards()
		dealTwelveInitialCards()
		startTime = Date()
	}
	
	func chooseCard(at index: Int) {
		let elapsed = Date().timeIntervalSince(startTime)
		print("elapsed: \(elapsed)")
		if !selectedCards.contains(dealtCards[index]), selectedCards.count < 3 {
			selectedCards.append(dealtCards[index])
			if selectedCards.count == 3 {
				checkForMatch(amongCards: selectedCards)
			}
		}
		else if !selectedCards.contains(dealtCards[index]), selectedCards.count >= 3 {
			if hasMatch && deck.count == 0 {
				hasMatch = false
				print("FOO")
				addPoints(for: elapsed)
				dealtCards.removeAll(where: { selectedCards.contains($0) })
				selectedCards.removeAll()
				
				selectedCards.append(dealtCards[index-(index-(dealtCards.count-1))])
			}
			else {
				print("BAR")
				if hasMatch {
					addPoints(for: elapsed)
					startTime = Date()
					replaceCards()
					hasMatch = false
				}
				selectedCards.removeAll()
				selectedCards.append(dealtCards[index])
			}
		}
		else if selectedCards.contains(dealtCards[index]) {
			if !hasMatch {
				score -= score == 0 ? 0 : 5
			}
			selectedCards.removeAll(where: { $0 == dealtCards[index] })
			hasMatch = false
		}
	}
	
	func checkForMatch(amongCards selectedCards: [SetCard]) {
		var matchCount = 0
		for i in 0...3 {
			var sortedCards = selectedCards.sorted(by: { $0.props[i] < $1.props[i] })
			if sortedCards[0].props[i] == sortedCards[1].props[i] {
				if sortedCards[0].props[i] == sortedCards[2].props[i] {
					matchCount += 1
				}
				else {
				}
			}
			else {
				if sortedCards[1].props[i] == sortedCards[2].props[i] {
				}
				else {
					matchCount += 1
				}
			}
		}
		if matchCount == 4 {
			hasMatch = true
		}
		else {
			hasMatch = false
		}
	}
	
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
	
	
	
	
	//TODO:
	//	1. Initialize
	//  2. Game Logic
	//  3. New Game
	//  4. Score
}
