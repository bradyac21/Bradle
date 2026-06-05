//
//  LogInSheet.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI
import SwiftData

struct LoginSheet: View {
    @State var viewModel = LoginViewModel()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Environment(GameRunner.self) var gameRunner
    
    var body: some View {
        ZStack {
            BradleColors.darkModeBackground.ignoresSafeArea()
            
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.gray)
                        })
                        .buttonStyle(.plain)
                        .padding(.trailing)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("The New York Times")
                            .font(.custom(FontNames.newYorkTimesFont, size: 20))
                        Spacer()
                    }
                }
                
                Divider()
                    .padding(.bottom, 25)
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .background(BradleColors.light)
                
                Text("Log in or create an account")
                    .font(.custom(FontNames.bold, size: 20))
                    .padding(.vertical, 7.5)
                
                LoginTextField(entry: $viewModel.username, label: "Username")
                    .padding(.bottom)
                LoginTextField(entry: $viewModel.password, label: "Password")
                    .padding(.bottom)

                
                Button(viewModel.useCase.primaryButtonLabel) {
                    do {
                        try viewModel.performAction(with: gameRunner, using: context)
                        dismiss()
                    } catch {
                        print("Login or create account failed")
                    }
                }
                .font(.custom(FontNames.bold, size: 15))
                .foregroundStyle(BradleColors.dark)
                .buttonStyle(.plain)
                .containerRelativeFrame([.horizontal, .vertical]) { size, axe in
                    size * (axe == .horizontal ? 0.9 : 0.075)
                }
                .background(.white)
                .clipShape(.rect(cornerRadius: 5))
                .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
                
                
                Button(viewModel.useCase.secondaryButtonLabel) {
                    viewModel.toggleUseCase()
                }
                .font(.custom(FontNames.bold, size: 15))
                .foregroundStyle(.gray)
                .padding(.top, 5)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .foregroundStyle(.white)
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.error != nil },
                set: { if !$0 { viewModel.error = nil } }
            )
        ) {
            Button("Ok", role: .cancel) {}
        } message: {
            if let error = viewModel.error {
                Text(error.alertMessage)
            }
        }
    }
}

#Preview {
    LoginSheet()
        .environment(GameRunner())
        .modelContainer(for: BradleAccount.self)
}

struct LoginTextField: View {
    @Binding var entry: String
    let label: String
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .foregroundStyle(.primary)
                    .font(.custom(FontNames.bold, size: 12))
                Spacer()
            }
            .padding(.bottom, 0)
            
            TextField("", text: $entry)
                .containerRelativeFrame(.vertical) { height, _ in
                    height * 0.075
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.white, lineWidth: 1)
                )
            
        }
        .containerRelativeFrame(.horizontal) { width, _ in
            width * 0.9
        }
    }
}

@Observable
class LoginViewModel {
    var username: String = ""
    var password: String = ""
    var useCase: UseCase = .login
    var error: BradleError?
    
    init() {}
    
    func toggleUseCase() {
        useCase = useCase == .login ? .createAccount : .login
    }
    
    func performAction(with gameRunner: GameRunner, using context: ModelContext) throws {
        var descriptor = FetchDescriptor<BradleAccount>(
            predicate: #Predicate { $0.username == username && $0.password == password}
        )
        descriptor.fetchLimit = 1
        
        let account = try? context.fetch(descriptor).last
        if useCase == .login {
            guard let account else {
                error = .accountNotFound
                throw URLError(.badURL)
            }
            
            gameRunner.account = account
            
        } else {
            guard account == nil else {
                error = .usernameTaken
                throw URLError(.badURL)
            }
            
            let newAccount = BradleAccount(username: username, password: password)
            context.insert(newAccount)
            gameRunner.account = account
        }
    }
    
}

enum UseCase {
    case login
    case createAccount
    
    var primaryButtonLabel: String {
        switch self {
        case .login:
            "Login"
        case .createAccount:
            "Create Account"
        }
    }
    
    var secondaryButtonLabel: String {
        switch self {
        case .login:
            "or Create Account"
        case .createAccount:
            "or login to existing Account"
        }
    }
}

enum BradleError: Error {
    case accountNotFound
    case usernameTaken
    
    var alertTitle: String {
        switch self {
        case .accountNotFound:
            "Login Failed"
        case .usernameTaken:
            "Username Taken"
        }
    }
    
    var alertMessage: String {
        switch self {
        case .accountNotFound:
            "Your username and password may have been incorrect."
        case .usernameTaken:
            "There is already an account associated with that username."
        }
    }
}
