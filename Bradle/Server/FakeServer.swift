//
//  FakeServer.swift
//  Bradle
//
//  Created by Brady Carden on 3/8/26.
//

import Foundation
internal import UniformTypeIdentifiers

class FakeServer {
    static var shared = FakeServer()
    
    let accountURL: URL
    
    init() {
        self.accountURL = FileManager.default
                    .urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("Accounts")
    }
    
    func attemptLogin(with username: String, and password: String) -> BradleAccount? {
        // Get JSON data from account file
        if let accountData = try? Data(contentsOf: accountURL.appendingPathComponent(username, conformingTo: .json)) {
            
            // Decode JSON data into account
            let account = try? JSONDecoder().decode(BradleAccount.self, from: accountData)
            
            // Return decoded account. nil if decoding fails
            return account
        }
        
        // If can't get account
        return nil
    }
    
    func saveAccountData(for account: BradleAccount) {
        do {
            // Encode account to JSON
            let accountData = try JSONEncoder().encode(account)
            
            // Write data to file with username
            try accountData.write(to: accountURL.appendingPathComponent(account.username, conformingTo: .json))
            print("\(account.username) data saved successfully.")
            
            // Handle errors if neccessary
        } catch let error as EncodingError {
            print("Error encoding account data. Error: \(error.localizedDescription)")
        } catch  {
            print("Error saving account data. Error: \(error).")
        }
    }
}

