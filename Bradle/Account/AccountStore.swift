//
//  AccountStore.swift
//  Bradle
//
//  Created by Brady Carden on 6/7/26.
//

import SwiftData
import Foundation

@Observable
class AccountStore {
    static let shared = AccountStore()
    private static var context: ModelContext?
    var account: BradleAccount?
    
    private init() {}
    
    #if DEBUG
    private init(_ val: Any) {
        account = BradleAccount.testAccount
    }
    #endif
    
    static var isLoggedIn: Bool {
        shared.account != nil
    }
    
    public func loadAccount(from context: ModelContext) {
        var descriptor = FetchDescriptor<BradleAccount>(
            predicate: #Predicate { $0.rememberMe }
        )
        descriptor.fetchLimit = 1
        
        if let fetchedAccount = try? context.fetch(descriptor).first {
            let components = Calendar.current.dateComponents([.day], from: fetchedAccount.lastWonGameDate, to: .now)
            let daysDifference = components.day ?? 0
            
            if daysDifference > 1 {
                fetchedAccount.currentStreak = 0
            }
            account = fetchedAccount
        }
        
        Self.context = context
    }
    
    public static func logout() {
        print(shared.account == nil)
        shared.account?.rememberMe = false
        try? context?.save()
        shared.account = nil
    }
    
    static func handleFinishedGame(success: Bool, numAttempts: Int) {
        shared.account?.handleFinishedGame(success: success, numAttempts: numAttempts)
    }
}
