//
//  Hint.swift
//  Bradle
//
//  Created by Brady Carden on 3/7/26.
//

struct Hint {
    let letter: Letter
    let location: Int?
    
    init(letter: Letter, location: Int? = nil) {
        self.letter = letter
        
        // If location is an invalid number, just assign it to 0
        if let location, location < 0 || location > 5 {
            self.location = 0
        } else {
            self.location = location
        }
    }
}
