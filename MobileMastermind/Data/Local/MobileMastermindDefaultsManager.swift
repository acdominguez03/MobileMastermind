//
//  MobileMastermindDefaults.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 21/4/25.
//

import Foundation

class MobileMastermindDefaultsManager {
    static let shared = MobileMastermindDefaultsManager()
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    var username: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "username")
        }
        get {
            return UserDefaults.standard.string(forKey: "username") ?? ""
        }
    }
    
    var imageURL: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "imageURL")
        }
        get {
            return UserDefaults.standard.string(forKey: "imageURL") ?? ""
        }
    }
    
    func saveTokens(accessToken: String, refreshToken: String) {
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
    }
    
    func saveAccessToken(accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
    }
    
    func saveLoginData(accessToken: String, refreshToken: String, username: String, imageURL: String) {
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        self.username = username
        self.imageURL = imageURL
    }
    
    /*func isAccessTokenValid() -> Bool {
        
        guard let token = accessToken else {
            return false
        }

        let expirationDate = Utils.shared.getExpirationDateFromJWT(token: token)
        
        return expirationDate > Date()
    }*/
}
