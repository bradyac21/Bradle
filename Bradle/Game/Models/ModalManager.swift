//
//  ModalManager.swift
//  Bradle
//
//  Created by Brady Carden on 6/4/26.
//

import SwiftUI

@Observable
@MainActor
class AppState {
    static let shared = AppState()
    
    private init() {
        sheet = nil
        fullScreenCover = nil
    }
    
    var location: AppLocation = .start {
        willSet {
            fullScreenCover = nil
            sheet = nil
        }
        
        didSet {
            print("location updated")
        }
    }
    
    var sheet: BradleSheet? {
        willSet {
            if fullScreenCover != nil {
                fullScreenCover = nil
            }
        }
        
        didSet {
            print("sheet updated")
        }
    }
    
    var fullScreenCover: FullScreenCover? {
        willSet {
            if sheet != nil {
                sheet = nil
            }
        }
        
        didSet {
            print("fullScreenCover updated")
        }
    }
    
}

