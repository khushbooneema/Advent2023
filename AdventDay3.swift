//
//  AdventDay3.swift
//  Advent2023
//
//  Created by Khushboo Neema on 12/4/23.
//

import Foundation



class AdventDay3 {
    func parseData() -> [String] {
        var lines: [String] = []
        
        do {
            if let path = Bundle.main.path(forResource: "InputDay3", ofType: "txt") {
                let content = try String(contentsOfFile: path)
                let contentArray = content.components(separatedBy: "\n")
                lines = Array(contentArray.filter({ $0.count > 0 }))
            }
        } catch {
            print(error)
        }
        
        return lines
    }
    
    func calculateSum() -> Int {
        var sum = 0
        var specials = "!@#$%^&*()_+{}:<>:;[]|"
       
        let input = parseData()
        
        var startIndex = -1
        var endIndex = -1
        
        for (i,line) in input.enumerated() {
            var prevLine: String?
            var nextLine: String?
            
            if i != 0 {
                prevLine = input[i-1]
            }
            
            if i <= input.count-2 {
                nextLine = input[i+1]
            }
            
            var isValid = false
            for (j, letter) in line.enumerated() {
                if "0"..."9" ~= letter {
                    // if startIndex not set
                    if startIndex == -1 {
                        startIndex = j
                    }
                }
                    
                if (specials.contains(letter) || letter == ".") && startIndex != -1 {
                    endIndex = j
                }
                
                if j > 0 && !isValid && startIndex != -1 {
                    let index = line.index(line.startIndex, offsetBy: j-1)
                   
                    if specials.contains(line[index...index]) {
                        isValid = true
                    } else if let prevLine = prevLine, specials.contains(prevLine[index...index]) {
                        isValid = true
                    } else if let nextLine = nextLine, specials.contains(nextLine[index...index]) {
                        isValid = true
                    }
                }
                
                if endIndex != -1 && endIndex < input.count-2 && !isValid {
                    let index = line.index(line.startIndex, offsetBy: endIndex)
                   
                    if specials.contains(line[index...index]) {
                        isValid = true
                    } else if let prevLine = prevLine, specials.contains(prevLine[index...index]) {
                        isValid = true
                    } else if let nextLine = nextLine, specials.contains(nextLine[index...index]) {
                        isValid = true
                    }
                }
                
                if isValid && startIndex != -1 && endIndex != -1 {
                    let start = line.index(line.startIndex, offsetBy: startIndex)
                    let end = line.index(line.startIndex, offsetBy: endIndex-1)
                    
                    if let num = Int(line[start...end]) {
                        sum += num
                        
                        startIndex = -1
                        endIndex = -1
                        isValid = false
                    }
                } else if startIndex != -1 && endIndex != -1 {
                    startIndex = -1
                    endIndex = -1
                    isValid = false
                }
            }
        }

        return sum
    }

}
