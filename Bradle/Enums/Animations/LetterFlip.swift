//
//  LetterFlip.swift
//  Bradle
//
//  Created by Brady Carden on 2/14/26.
//

import SwiftUI

enum LetterFlip: CaseIterable {
    case initial
    case halfway
    case end
    
    var yScale: CGFloat {
        switch self {
        case .initial: 1
        case .halfway: 0
        case .end: 1
        }
    }
    
    static var phases: [LetterFlip] {
        return LetterFlip.allCases
    }
}
