//
//  FrameFlip.swift
//  Bradle
//
//  Created by Brady Carden on 2/14/26.
//

import SwiftUI

enum FrameFlip: CaseIterable {
    case initial
    case halfway
    case end
    
    var yScale: CGFloat {
        switch self {
        case .initial: 1
        case .halfway: -1
        case .end: 1
        }
    }
    
    var duration: CGFloat {
        switch self {
        case .initial, .halfway: 0.2
        case .end: 0.2
        }
    }
        
    static var phases: [FrameFlip] {
        return FrameFlip.allCases
    }
}
