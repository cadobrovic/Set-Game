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
				let card = game.cards[index]
				if game.selectedCards.contains(card){
					button.backgroundColor = UIColor.white
					button.setAttributedTitle(setSymbolAttributes(for: card), for: UIControl.State.normal
					)
				}//end if
				else {
					button.backgroundColor = UIColor.orange
					button.setTitle("", for: UIControl.State.normal)
					button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
				}//end else
			}//end if
			else {
				button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
				button.setTitle("", for: UIControl.State.normal)
				button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
			}//end else
		}//end for
	}//end func
	

	//MARK: Newest system of handling permutations
	var symbolsDictionary: [String:Int] = ["▲":27, "●":27, "■":27]
	var numberOfSymbolsDictionary: [Int:Int] = [1:27, 2:27, 3:27]
	var colorsDicionary: [UIColor:Int] = [UIColor.red:27, UIColor.green:27, UIColor.purple:27]
	var fillsDicionary: [String:Int] = ["solid":27, "striped":27, "open":27]
	
	func updateAvailability(of symbol: String, of number: Int, of color: UIColor, of fill: String) {
		symbolsDictionary[symbol]! > 0 ? symbolsDictionary.updateValue(symbolsDictionary[symbol]! - 1 , forKey: symbol) :  symbolsDictionary.removeValue(forKey: symbol)
		print("updateAvailability invoked. \nsymbolsDictionary now: \(symbolsDictionary)")
		numberOfSymbolsDictionary[number]! > 0 ? numberOfSymbolsDictionary.updateValue(numberOfSymbolsDictionary[number]! - 1 , forKey: number) : numberOfSymbolsDictionary.removeValue(forKey: number)
		//Might cause an error
		print("numberOfSymbolsDictionary now: \(numberOfSymbolsDictionary)")
		
		colorsDicionary[color]! > 0 ? colorsDicionary.updateValue(colorsDicionary[color]! - 1, forKey: color) : colorsDicionary.removeValue(forKey: color)
		print("colorsDictionary now: \(colorsDicionary)")
		fillsDicionary[fill]! > 0 ? fillsDicionary.updateValue(fillsDicionary[fill]! - 1, forKey: fill) : fillsDicionary.removeValue(forKey: fill)
		print("fillsDictionary now: \(fillsDicionary)")
	}//end func
	
	//MARK: [cardIndex:attribute] dictionaries
	var titleDictionary = [SetCard:String]()
	var attributesDictionary = [SetCard : [NSAttributedString.Key:Any] ]()
	
	/**
	- Sets an attributed string to a given SetCard. The symbols
		and the number of symbols are assigned or retrieved to/fro
		cards via the `titleDictionary` dictionary. The attributes for
		color and fill are assigned or retrieved to/fro the
		`attributesDictionary`.
	
	-Param a given SetCard that conforms to Hashable.
	
	-Return an NSAttributedString with String and attributes of the corresponding SetCard.
	*/
	func setSymbolAttributes(for card: SetCard) -> NSAttributedString {
		if titleDictionary[card] == nil, attributesDictionary[card] == nil, symbolsDictionary.count > 0, numberOfSymbolsDictionary.count > 0, colorsDicionary.count > 0, fillsDicionary.count > 0 {
			var title = ""
			var symbolToUpdate: String
			var numberOfSymbolsToUpdate: Int
			var colorToUpdate: UIColor
			var fillToUpdate: String
			if let symbol = symbolsDictionary[symbolsDictionary.count.randomize]?.key, let numberOfSymbols = numberOfSymbolsDictionary[numberOfSymbolsDictionary.count.randomize]?.key,let aColor = colorsDicionary[colorsDicionary.count.randomize]?.key, let givenFill = fillsDicionary[fillsDicionary.count.randomize]?.key {
				print("symbol retrieved: \(symbol)")
				print("numberOfSymbols retrieved: \(numberOfSymbols)")
				print("color retrieved: \(aColor)")
				print("fill retrieved: \(givenFill)")
				symbolToUpdate = symbol
				numberOfSymbolsToUpdate = numberOfSymbols
				colorToUpdate = aColor
				fillToUpdate = givenFill
				let anAlpha: CGFloat
				let aStrokeWidth: Double
				for _ in 0..<numberOfSymbols {
					title += symbol
				}
				titleDictionary[card] = title
				switch givenFill {
				case "solid":
					anAlpha = 1.0
					aStrokeWidth = -1.0
					print("solid chosen")
				case "striped":
					anAlpha = 0.15
					aStrokeWidth = -1.0
					print("striped chosen")
				case "open":
					anAlpha = 1.0
					aStrokeWidth = 2.0
					print("open chosen")
				default:
					anAlpha = 1.0
					aStrokeWidth = 2.0
				}
				let symbolAttributes: [NSAttributedString.Key:Any] = [
					.strokeWidth : aStrokeWidth,
					.strokeColor : aColor,
					.foregroundColor : aColor.withAlphaComponent(anAlpha),
					.font : UIFont.systemFont(ofSize: 25)
				]
				attributesDictionary[card] = symbolAttributes
				updateAvailability(of: symbolToUpdate, of: numberOfSymbolsToUpdate, of: colorToUpdate, of: fillToUpdate)
			}//end if
		}//end if
		return NSAttributedString(string: titleDictionary[card]!, attributes: attributesDictionary[card])
	}//end func
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
