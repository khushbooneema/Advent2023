//
//  ContentView.swift
//  Advent2023
//
//  Created by Khushboo Neema on 12/1/23.
//

import SwiftUI

struct AdventDay1_1 {
    var dictionary = ["one" : 1, "two" : 2, "three" : 3, "four" : 4, "five" : 5, "six" : 6, "seven" : 7, "eight": 8, "nine": 9, "zero": 0]
    
    func calculateSumCalibration() -> Int {
        var inputString: [String] = []
        
        do {
            if let path = Bundle.main.path(forResource: "InputDay1_1", ofType: "txt") {
                let content = try String(contentsOfFile: path)
                let contentArray = content.components(separatedBy: "\n")
                inputString = Array(contentArray)
            }
        } catch {
            print(error)
        }
        
        var sum = 0
        
        for line in inputString {
            let nums = InterchangeString(line)
            
            if nums.count != 0 {
                var str = String(nums[0])
                str += String(nums[nums.count-1])
                sum += Int(str) ?? 0
                print(nums, sum, line)
            }
            
            
        }
                   
        return sum
    }
    
    func InterchangeString(_ line: String) -> [Int] {
        var nums:[Int] = []
        
        for (i,char) in line.enumerated() {
            for dict in dictionary {
                let startIndex = line.index(line.startIndex, offsetBy: i)
                
                if i+dict.key.count <= line.count {
                    let endIndex = line.index(startIndex, offsetBy: dict.key.count)
                    let str = line[startIndex..<endIndex]
                    
                    if dict.key == str {
                        nums.append(dict.value)
                    }
                }
            }
            
            if "0"..."9" ~= char, let num = char.wholeNumberValue {
                nums.append(num)
            }
        }
        
        return nums
    }
}
