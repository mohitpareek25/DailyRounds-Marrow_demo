//
//  LoginUtilities.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import Foundation

final class LoginUtilities {
    static func saveLogin() {
        UserDefaults.standard.setValue(true, forKey: Constants.Login.LoginUtility.isLoggedIn)
    }
    
    static func removeLogin() {
        UserDefaults.standard.setValue(false, forKey: Constants.Login.LoginUtility.isLoggedIn)
    }
    
    static func isLoggedIn() -> Bool {
        guard let value = UserDefaults.standard.value(forKey: Constants.Login.LoginUtility.isLoggedIn) as? Bool else { return false }
        return value
    }
}
