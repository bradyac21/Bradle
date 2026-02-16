//
//  Pop.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

enum Pop {
    case normal, out
    
    var scale: CGFloat {
        switch self {
            
        case .normal:
            return 1.0
        case .out:
            return 1.05
        }
    }
    
    static var phases: [Pop] {
        [.normal, .out, .normal]
    }
}
