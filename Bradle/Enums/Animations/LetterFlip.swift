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
        case .halfway: -0.5
        case .end: 1
        }
    }
    
    var duration: CGFloat {
        switch self {
        case .initial, .halfway: 0.4
        case .end: 0
        }
    }
    
    static var phases: [LetterFlip] {
        return LetterFlip.allCases
    }
}
