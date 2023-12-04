//
//  AdventDay4.swift
//  Advent2023
//
//  Created by Khushboo Neema on 12/4/23.
//

import Foundation

struct Card {
    let number: Int
    let winning: [Int]
    let givenNum: [Int]
}

class AdventDay4 {
    
    func parseData() -> [Card] {
        var lines: [String] = []
        var cards: [Card] = []
        
        do {
            if let path = Bundle.main.path(forResource: "InputDay4", ofType: "txt") {
                let content = try String(contentsOfFile: path)
                let contentArray = content.components(separatedBy: "\n")
                lines = Array(contentArray.filter({ $0.count > 0 }))
            }
        } catch {
            print(error)
        }
        
        for line in lines {
            var line = line.dropFirst(5)
            let arr = line.components(separatedBy: ":")
            
            //for numbers
            
            guard let cardNum = Int(arr.first?.trimmingCharacters(in: .whitespaces) ?? "") else {
                return []
            }
            
            guard let numSet = arr.last?.components(separatedBy: "|") else { return [] }
            
            var winning: [Int] = []
            var given: [Int] = []
            
            if let firstSet = numSet.first {
                let numbers = firstSet.components(separatedBy: " ")
                
                for number in numbers {
                    if let num = Int(number.trimmingCharacters(in: .whitespaces)) {
                        winning.append(num)
                    }
                }
            }
           
            if let last = numSet.last {
                let numbers = last.components(separatedBy: " ")
                
                for number in numbers {
                    if let num = Int(number.trimmingCharacters(in: .whitespaces)) {
                        given.append(num)
                    }
                }
            }
            
            let card = Card(number: cardNum, winning: winning, givenNum: given)
            cards.append(card)
        }
        
        return cards
    }
    
    func part_I() -> Double {
        let cards = parseData()
        var sum = 0.0
        
        
        for card in cards {
            var count = 0
            
            for num in card.winning {
                if card.givenNum.contains(num) {
                    count += 1
                }
            }
            
            if count > 0 {
                sum += pow(2, Double(count-1))
                count = 0
            }
        }
        
        return sum
    }
    
    
    func part_II() -> Int {
        let cards = parseData()
        var dict: [Int: Int] = [:]
        
        for card in cards {
            dict[card.number] = 1
        }
        
        for card in cards {
            var count = 0
            
            for num in card.winning {
                if card.givenNum.contains(num) {
                    count += 1
                }
            }
            
            guard var repetativeCards = dict[card.number] else { return 0 }
            
            while repetativeCards != 0 {
                if count > 0 {
                    var i = 1
                    
                    while i <= count {
                        dict[card.number+i]! += 1
                        i+=1
                    }
                }
                
                repetativeCards -= 1
            }
        }
        
        return dict.values.reduce(0, +)
    }
}
