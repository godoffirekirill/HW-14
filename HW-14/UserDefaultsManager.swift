//
//  UserDefaultsManager.swift
//  HW-14
//
//  Created by Кирилл Курочкин on 14.06.2024.
//

import Foundation

class UserDefaultsManager {
    
    struct Keys {
        static let login = "login"
        static let password = "password"
    }
    
    static var login: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.login)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.login)
        }
    }
    
    static var password: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.password)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.password)
        }
    }
}
