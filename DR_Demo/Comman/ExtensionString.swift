//
//  ExtensionString.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import Foundation

extension String {
    func isValidEmailAddress() -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func isPasswordValid() -> Bool {
        
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"

        // Create a regular expression object
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)

        // Test the password against the regular expression
        return passwordPredicate.evaluate(with: self)
    }
}
