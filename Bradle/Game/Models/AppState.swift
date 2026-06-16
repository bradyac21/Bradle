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
    }
    
    var sheet: BradleSheet? {
        willSet {
            if fullScreenCover != nil {
                fullScreenCover = nil
            }
        }
    }
    
    var fullScreenCover: FullScreenCover? {
        willSet {
            if sheet != nil {
                sheet = nil
            }
        }
    }
    
    var alertMessage: AlertMessage?
    
}

