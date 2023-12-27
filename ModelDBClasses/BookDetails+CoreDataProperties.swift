//
//  BookDetails+CoreDataProperties.swift
//  
//
//  Created by Mohit Pareek on 27/12/23.
//
//

import Foundation
import CoreData


extension BookDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookDetails> {
        return NSFetchRequest<BookDetails>(entityName: "BookDetails")
    }

    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var author: String?

}
