//
//  KeyboardButton.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI


enum KeyboardButton: String, CaseIterable, Hashable {
    // Row 1
    case Q = "Q"
    case W = "W"
    case E = "E"
    case R = "R"
    case T = "T"
    case Y = "Y"
    case U = "U"
    case I = "I"
    case O = "O"
    case P = "P"

    // Row 2
    case A = "A"
    case S = "S"
    case D = "D"
    case F = "F"
    case G = "G"
    case H = "H"
    case J = "J"
    case K = "K"
    case L = "L"

    // Row 3
    case enter = "ENTER"
    case Z = "Z"
    case X = "X"
    case C = "C"
    case V = "V"
    case B = "B"
    case N = "N"
    case M = "M"
    case backspace = "BACKSPACE"

    // MARK: - Variables
    
    /// The View the appears on the Keyboard for a key
    public var icon: AnyView {
        if self == .backspace {
            AnyView(Image(systemName: "delete.left"))
        } else {
            AnyView(Text(self.rawValue).font(.custom("NYTFranklin-Bold", size: 15)))
        }
    }
    
    /// The width of each key
    public var widthScale: CGFloat {
        if self == .backspace || self == .enter {
            return 0.181818
        } else {
            return 0.090909
        }
    }
    
    public var letter: Letter {
        switch self {
        case .Q:
            return .Q
        case .W:
            return .W
        case .E:
            return .E
        case .R:
            return .R
        case .T:
            return .T
        case .Y:
            return .Y
        case .U:
            return .U
        case .I:
            return .I
        case .O:
            return .O
        case .P:
            return .P
        case .A:
            return .A
        case .S:
            return .S
        case .D:
            return .D
        case .F:
            return .F
        case .G:
            return .G
        case .H:
            return .H
        case .J:
            return .J
        case .K:
            return .K
        case .L:
            return .L
        case .Z:
            return .Z
        case .X:
            return .X;
        case .C:
            return .C
        case .V:
            return .V
        case .B:
            return .B
        case .N:
            return .N
        case .M:
            return .M
        case .backspace, .enter:
            return .empty
        }
    }
}
