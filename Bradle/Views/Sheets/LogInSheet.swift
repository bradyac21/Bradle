//
//  LogInSheet.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct LogInSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var emailEntry: String = ""
    var body: some View {
        ZStack {
            BradleColors.dark.ignoresSafeArea()
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
                            .font(.custom("Chomsky", size: 20))
                        Spacer()
                    }
                }
                Divider()
                    .padding(.bottom, 25)
                    .frame(width: .infinity, height: 1)
                    .background(BradleColors.light)
                    .ignoresSafeArea()
                Text("Log in or create an account")
                    .fontWeight(.semibold)
                    .padding(.bottom, 7.5)
                
                HStack(spacing: 0) {
                    Text("By continuing, you agree to the ")
                        .padding(.horizontal, 0)
                    Text("Terms of Sale")
                        .underline()
                        .padding(.horizontal, 0)
                    Text(",")
                        .padding(.horizontal, 0)

                }
                
                HStack(spacing: 0) {
                    Text("Terms of Service")
                        .underline()
                        .padding(.horizontal, 0)

                    Text(", and ")
                        .padding(.horizontal, 0)

                    Text("Privacy Policy")
                        .underline()
                        .padding(.horizontal, 0)

                    Text(".")
                        .padding(.horizontal, 0)
                }
                .padding(.bottom, 25)

                
                HStack {
                    Text("Email Address")
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                    Spacer()
                }
                .padding(.bottom, 0)
                TextField("", text: $emailEntry)
                    .padding(.vertical, 15)
                    .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.white, lineWidth: 1)
                        )
                    .padding(.top, 0)
                    .padding(.bottom, 10)
                
                Button(action: {
                    print("Continue with email tapped")
                }, label: {
                    Text("Continue with email")
                        .foregroundStyle(BradleColors.dark)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                        .padding(.horizontal, 126)
                        .padding(.vertical, 19)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .tint(.white)
                        }
                })
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.5))

                    Text("OR")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 4)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.5))
                }
                .padding(.vertical)

                LoginSheetButton(label: "Continue with Google") {}
                .padding(.bottom)
                
                LoginSheetButton(label: "Continue with Facebook") {}
                .padding(.bottom)

                LoginSheetButton(label: "Continue with Apple") {}
                .padding(.bottom)

                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    LogInSheet()
}

struct LoginSheetButton: View {
    var icon: String
    var label: String
    var action: () -> Void
    
    init(icon: String = "apple.logo", label: String, action: @escaping () -> Void) {
        self.icon = icon
        self.label = label
        self.action = action
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(label)
                .fontWeight(.semibold)
                .font(.system(size: 14))
                .foregroundStyle(.white)
        }
        .frame(width: 360, height: 40)
        .background {
            RoundedRectangle(cornerRadius: 2)
                .stroke(.white)
            
        }
        
    }
}
