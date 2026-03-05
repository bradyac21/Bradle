//
//  Letter.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import Foundation

enum Letter: String, CaseIterable, Decodable, Equatable {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case H = "H"
    case I = "I"
    case J = "J"
    case K = "K"
    case L = "L"
    case M = "M"
    case N = "N"
    case O = "O"
    case P = "P"
    case Q = "Q"
    case R = "R"
    case S = "S"
    case T = "T"
    case U = "U"
    case V = "V"
    case W = "W"
    case X = "X"
    case Y = "Y"
    case Z = "Z"
    
    case empty = ""
    
    public static func formTargetWord(from target: String) -> [Letter] {
        var targetWord = [Letter]()
        for element in target.map({ String($0) }) {
            if let letter = Letter(rawValue: element) {
                targetWord.append(letter)
            } else {
                print("Unable to form target word. Target Word is empty.")
                return Array(repeating: .empty, count: 5)
            }
        }
        
        return targetWord
    }
    
    public static func lettersToString(letters: [Letter]) {}
}

extension Array where Element == Letter {
    func toString() -> String {
        return self.reduce(into: "") { partialResult, letter in
            partialResult += letter.rawValue
        }
    }
}
