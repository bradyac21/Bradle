//
//  Accounts.swift
//  Bradle
//
//  Created by Brady Carden on 6/6/26.
//

#if DEBUG
import SwiftUI
import SwiftData

struct BradleAccountsView: View {
    var context: ModelContext?
    @Query var accounts: [BradleAccount]
    @Environment(GameRunner.self) var gameRunner
    
    var body: some View {
        VStack {
            if accounts.isEmpty {
                ContentUnavailableView("No Accounts Found", systemImage: "tray", description: Text("Try creating an Account"))
            } else {
                List {
                    ForEach(accounts, id: \.username) { account in
                        DisclosureGroup(account.username) {
                            VStack(alignment: .leading) {
                                Text("ID: \(account.id)")
                                Text("Password: \(account.password)")
                                Text("Games Played: \(account.gamesPlayed)")
                                Text("Games Won: \(account.gamesWon)")
                                Text("Current Streak: \(account.currentStreak)")
                                Text("Max Streak: \(account.maxStreak)")
                                Text("Next Word Index: \(account.nextWordIndex)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        }
                        .swipeActions {
                            Button("Delete Account", systemImage: "trash", role: .destructive) {
                                do {
                                    let username = account.username
                                    try context?.delete(model: BradleAccount.self, where: #Predicate { $0.username == username } )
                                    if AccountStore.shared.account?.username == username {
                                        AccountStore.shared.account = nil
                                    }
                                } catch {
                                    print("Failed to delete Account.")
                                }
                            }
                            .labelStyle(.iconOnly)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        BradleAccountsView(context: try? ModelContext(ModelContainer(for: BradleAccount.self)))
            .environment(GameRunner())
    }
}

#endif
