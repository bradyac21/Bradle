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
    
    private init() {
        account = BradleAccount.testAccount
    }
    
#if DEBUG
    private init(_ val: Any) {
        account = BradleAccount.testAccount
    }
#endif
    
    static var isLoggedIn: Bool {
        shared.account != nil
    }
    
    public func loadAccount(from context: ModelContext) {
//        guard
//            let savedIdString = UserDefaults.standard.string(forKey: "remember-me-id"),
//            let savedId = UUID(uuidString: savedIdString)
//        else {
//            return
//        }
//        
//        var descriptor = FetchDescriptor<BradleAccount>(
//            predicate: #Predicate { $0.id == savedId }
//        )
//        descriptor.fetchLimit = 1
//        
//        if let fetchedAccount = try? context.fetch(descriptor).first {
//            let components = Calendar.current.dateComponents([.day], from: fetchedAccount.lastWonGameDate, to: .now)
//            let daysDifference = components.day ?? 0
//            
//            if daysDifference > 1 {
//                fetchedAccount.currentStreak = 0
//            }
//            account = fetchedAccount
//        }
//        account = BradleAccount.testAccount
        Self.context = context
    }
    
    public static func logout() {
        UserDefaults.standard.set(nil, forKey: "remember-me-id")
        try? context?.save()
        shared.account = nil
    }
    
    public static var earnedBadges: [(badge: Badge, earnedCount: Int)] {
        guard let account = shared.account else {
            return []
        }
        
        return Array(account.badges.keys.compactMap { (Badge(rawValue: $0)!, account.badges[$0] ?? -1) }) // default should be redundant
    }
    

}
