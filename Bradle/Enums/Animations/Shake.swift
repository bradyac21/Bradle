//
//  Shake.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

enum Shake: CaseIterable {
    case initial
    case leftOne
    case rightOne
    case leftTwo
    case rightTwo
    case leftThree
    case rightThree
    case done
    
    var xOffset: CGFloat {
        switch self {
            
        case .initial: 0
        case .leftOne: -5
        case .rightOne: 5
        case .leftTwo: -4
        case .rightTwo: 4
        case .leftThree: -3
        case .rightThree: 2
        case .done: 0
        }
    }
    
    static var phases: [Shake] {
        return Shake.allCases
    }
}
