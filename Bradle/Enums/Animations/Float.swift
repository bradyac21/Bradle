//
//  Float.swift
//  Bradle
//
//  Created by Brady Carden on 2/13/26.
//

import SwiftUI

enum FloatAnimation: CaseIterable {
    case initial
    case peak
    case end
    
    var yOffset: CGFloat {
        switch self {
        case .initial: 0
        case .peak: -40
        case .end: 0
        }
    }
    
    var duration: CGFloat {
        switch self {
        case .initial: 0
        case .peak: 0.2
        case .end: 0.2
        }
    }
    
    var delay: CGFloat {
        switch self {
        case .initial: 0
        case .peak: 2
        case .end: 0
        }
    }
    
    static var phases: [FloatAnimation] {
        FloatAnimation.allCases
    }
}
