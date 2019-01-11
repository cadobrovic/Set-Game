//
//  ViewController.swift
//  Set
//
//  Created by Karlo Dobrović on 1/6/19.
//  Copyright © 2019 Carlo Dobrović. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var game = Set()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		updateViewFromModel()
	}
	@IBOutlet var cardButtons: [UIButton]!
	
	@IBOutlet weak var scoreLabel: UILabel!
	
	var attributes = [NSAttributedString.Key:Any]()
	
	@IBAction func touchNewGame(_ sender: UIButton) {
		//TODO: implement new game functionality
		print("Set card index 0: \(game.cards[0])")
		
	}//end func
	
	@IBAction func touchShuffle(_ sender: UIButton) {
		game.shuffleCards()
	}
	
	
	@IBAction func touchDeal3NewCards(_ sender: UIButton) {
		game.deal3NewCards()
	}
	
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardIndex = cardButtons.firstIndex(of: sender){
			game.chooseCard(at: cardIndex)
			updateViewFromModel()
		}
	}//end func
	
	func updateViewFromModel(){
		//TODO: update view based on changes in Set
		for index in cardButtons.indices {
			let button = cardButtons[index]
			if index < game.dealtCards.count {
				let card = game.dealtCards[index]
				if game.selectedCards.contains(card){
					button.backgroundColor = UIColor.white
					button.setAttributedTitle(setAttributes(for: card), for: UIControl.State.normal
					)
					button.layer.borderWidth = 3.0
					button.layer.borderColor = UIColor.blue.cgColor
				}//end if
				else {
					button.backgroundColor = UIColor.orange
					button.setTitle("", for: UIControl.State.normal)
					button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
					button.layer.borderWidth = 0
					button.layer.borderColor = UIColor.blue.cgColor
				}//end else
			}//end if
			else {
				button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
				button.setTitle("", for: UIControl.State.normal)
				button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
			}//end else
		}//end for
	}//end func
	
	//MARK: [cardIndex:attribute] dictionaries
	var titleDictionary = [SetCard:String]()
	var attributesDictionary = [SetCard : [NSAttributedString.Key:Any] ]()
	let symbolsDictionary: [Int:String] = [1:"▲", 2:"●", 3:"■"]
	let fillsDictionary: [Int:(CGFloat, Double)] = [1:(1.0,-1.0), 2:(0.15,-1.0), 3:(1.0,2.0)]
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
				title += symbol ?? "error"
			}
			titleDictionary[card] = title
			
			let symbolAttributes: [NSAttributedString.Key:Any] = [
				.strokeWidth : fill.strokeWidth,
				.strokeColor : color as Any,
				.foregroundColor : color?.withAlphaComponent(fill.alpha) as Any,
				.font : UIFont.systemFont(ofSize: 25)
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
