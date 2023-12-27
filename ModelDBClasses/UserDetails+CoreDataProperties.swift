//
//  UserDetails+CoreDataProperties.swift
//  
//
//  Created by Mohit Pareek on 27/12/23.
//
//

import Foundation
import CoreData


extension UserDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetails> {
        return NSFetchRequest<UserDetails>(entityName: "UserDetails")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}
