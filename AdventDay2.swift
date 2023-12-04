//
//  AdventDay2_1.swift
//  Advent2023
//
//  Created by Khushboo Neema on 12/2/23.
//

import Foundation

struct Game {
    let red: Int
    let green: Int
    let blue: Int
}

class AdventDay2 {
    
    func readInputFile() -> [Int: [Game]]? {
        var lines: [String] = []
        var input: [Int: [Game]] = [:]
        
        do {
            if let path = Bundle.main.path(forResource: "InputDay2", ofType: "txt") {
                let content = try String(contentsOfFile: path)
                let contentArray = content.components(separatedBy: "\n")
                lines = Array(contentArray.filter({ $0.count > 0 }))
            }
        } catch {
            print(error)
        }
        
        for line in lines {
            var line = line.dropFirst(5)
            var games: [Game] = []
            
            guard let idStr = line.components(separatedBy: ":").first,
                  let id = Int(idStr)
            else { return nil }
            
            line = line.dropFirst(3)
            
            for game in line.components(separatedBy: ";") {
                let outcomes = game.components(separatedBy: ",")
               
                var red = 0
                var green = 0
                var blue = 0
                
                for outcome in outcomes {
                    let outcome = outcome.trimmingCharacters(in: .whitespaces)
                    let arr = outcome.components(separatedBy: " ")
                    guard let color = arr.last else { return nil }
                    
                    switch color {
                    case "red":
                        red = Int(arr.first ?? "0") ?? 0
                    case "green":
                        green = Int(arr.first ?? "0") ?? 0
                    case "blue":
                        blue = Int(arr.first ?? "0") ?? 0
                    default:
                        break
                    }
                }
                
                let gameResult =  Game(red: red, green: green, blue: blue)
                games.append(gameResult)
            }
            
            input[id] = games
        }
        
        return  input
    }
    
    func part_I() -> Int {
        guard let events = readInputFile() else { return 0 }
        
        var sum = 0
        
        for event in events {
            let games = event.value
            
            var isValidGame = true
            
            for game in games {
                if game.red > 12 || game.green > 13 || game.blue > 14 {
                    isValidGame = false
                }
            }
            
            if isValidGame {
                sum += event.key
            }
        }
        
        return sum
    }
    
    func part_II() -> Int {
        guard let events = readInputFile() else { return 0 }
        var sum = 0
        
        for event in events {
            var maxRed = 0
            var maxGreen = 0
            var maxBlue = 0
            
            let games = event.value
            
            for game in games {
                if maxRed < game.red {
                    maxRed = game.red
                }
                
                if maxBlue < game.blue {
                    maxBlue = game.blue
                }
                
                if maxGreen < game.green {
                    maxGreen = game.green
                }
            }
            
            let power = maxRed*maxBlue*maxGreen
            sum += power
        }
        
        return sum
    }
    
}
