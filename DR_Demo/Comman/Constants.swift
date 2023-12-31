//
//  Constants.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//

import Foundation


struct Constants {
    struct MedBooks {
        static let title = "Med Books"
        static let viewController = "MedBookListViewController"
        struct TableView {
            static let booksListCell = "BooksListTableViewCell"
            static let customHeaderCell = "CustomHeaderTableViewCell"
        }
        
    }
    
    struct Signup {
        static let viewController = "SignupViewController"
    }
    
    struct Login {
        static let viewController = "LoginViewController"
        
        struct LoginUtility {
            static let isLoggedIn = "isLoggedInUser"
        }
    }
    
    struct MedBookDetails {
        static let viewController = "MedBookDetailsViewController"
    }
    
}
