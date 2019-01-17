//
//  ViewController.swift
//  Set
//
//  Created by Karlo Dobrović on 1/6/19.
//  Copyright © 2019 Carlo Dobrović. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var game = SetGame()
	var timer = Timer()
	var time = 0
	var selectedColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		 self.view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
		updateViewFromModel()
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.tickUp), userInfo: nil, repeats: true)
	}
	@IBOutlet var cardButtons: [UIButton]!
	
	@IBOutlet weak var scoreLabel: UILabel!
	
	@IBOutlet weak var timeElapsedLabel: UILabel!
	
	@IBOutlet weak var possibleMatchesLabel: UILabel!
	
	@IBAction func touchCheat(_ sender: UIButton) {
		//TODO: identify either:
		//1. two cards in a match
		//2. a set.
		game.findAMatch()
		updateViewFromModel()
		game.cheatCards.removeAll()
	}
	
	var attributes = [NSAttributedString.Key:Any]()
	
	@IBAction func touchNewGame(_ sender: UIButton) {
		resetTimer()
		timeElapsedLabel.text = "Time Elapsed: \(time)"
		game.startNewGame()
		updateViewFromModel()
	}//end func
	
	
	@IBAction func touchDeal3NewCards(_ sender: UIButton) {
		//re-set timer
		
		if game.playerHasMatch {
			game.replaceCards()
			resetTimer()
			print("FOO")
		}
		else {
			game.deal3NewCards()
		}
		updateViewFromModel()
	}
	
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardIndex = cardButtons.firstIndex(of: sender){
			
			if game.playerHasMatch {
				resetTimer()
			}
			game.chooseCard(at: cardIndex)
			if game.playerHasMatch {
				timer.invalidate()
			}
			
			updateViewFromModel()
			
		}
	}//end func
	
	func resetTimer() {
		timer.invalidate()
		time = 0
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.tickUp), userInfo: nil, repeats: true)
	}
	
	@objc func tickUp() {
		time += 1
		timeElapsedLabel.text = "Time Elapsed: \(time)"
	}
	
	func updateViewFromModel(){
		scoreLabel.text = "Score: \(game.score)"
		possibleMatchesLabel.text = "Possible Matches: \(game.numberOfMatches)"
		for index in cardButtons.indices {
			let button = cardButtons[index]
			button.titleLabel?.textAlignment = .natural
			button.titleLabel?.lineBreakMode = .byWordWrapping
			if index < game.dealtCards.count {
				let card = game.dealtCards[index]
				if game.dealtCards.contains(card) {
					button.isEnabled = true
					button.backgroundColor = UIColor.white
					button.setAttributedTitle(setAttributes(for: card), for: UIControl.State.normal
					)
					if game.selectedCards.contains(card) {
					button.layer.borderWidth = 7.0
					button.layer.borderColor = game.playerHasMatch ? UIColor.green.cgColor : selectedColor.cgColor
					}
					else if game.cheatCards.contains(card) {
						button.layer.borderWidth = 7.0
						button.layer.borderColor = UIColor.green.cgColor
					}
					else {
						button.layer.borderWidth = 0.0
						button.layer.borderColor = UIColor.white.cgColor
					}
					
					
				}//end if
			}//end if
			else {
				button.isEnabled = false
				button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
				button.setTitle("", for: UIControl.State.normal)
				button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
				button.layer.borderWidth = 0
			}//end else
		}//end for
	}//end func
	
	//MARK: [cardIndex:attribute] dictionaries
	var titleDictionary = [SetCard:String]()
	var attributesDictionary = [SetCard : [NSAttributedString.Key:Any] ]()
	let symbolsDictionary: [Int:String] = [1:"▲", 2:"●", 3:"■"]
	let fillsDictionary: [Int:(CGFloat, Double)] = [1:(1.0,-1.0), 2:(0.15,-2.0), 3:(1.0,2.0)]
	let colorsDictionary: [Int:UIColor] = [1:UIColor.red, 2:UIColor.green, 3:UIColor.purple]
	/**
	- Sets an attributed string to a given SetCard. The symbols
	and the number of symbols are assigned or retrieved to/fro
	cards via the `titleDictionary` dictionary. The attributes for
	color and fill are assigned or retrieved to/fro the
	`attributesDictionary`.
	
	-Param a given SetCard that conforms to Hashable.
	
	-Return an NSAttributedString with String and attributes of the corresponding SetCard.
	*/
	func setAttributes(for card: SetCard) -> NSAttributedString {
		if titleDictionary[card] == nil, attributesDictionary[card] == nil {
			var title = ""
			let symbol = symbolsDictionary[card.props[0]]
			let numberOfSymbols = card.props[1]
			let fill: (alpha: CGFloat, strokeWidth: Double)
			fill = fillsDictionary[card.props[2]]!
			let color = colorsDictionary[card.props[3]]
			
			for _ in 0..<numberOfSymbols {
				title = title + symbol! + "\n"
			}
			title = title.trimmingCharacters(in: .whitespacesAndNewlines)
			titleDictionary[card] = title
			
			let symbolAttributes: [NSAttributedString.Key:Any] = [
				.strokeWidth : fill.strokeWidth,
				.strokeColor : color as Any,
				.foregroundColor : color?.withAlphaComponent(fill.alpha) as Any,
				.font : UIFont.systemFont(ofSize: 35)
			]
			attributesDictionary[card] = symbolAttributes
		}
		return NSAttributedString(string: titleDictionary[card]!, attributes: attributesDictionary[card])
	}
	
}//end class

extension Dictionary {
	subscript(i: Int) -> (key: Key, value: Value)? {
		return self[index(startIndex, offsetBy: i)]
	}
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
