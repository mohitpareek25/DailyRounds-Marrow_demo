//
//  CoreDataManager.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DRDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    //Core Data Saving support
    private func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveUserNameAndPassword(userName: String, password: String) -> (Bool, String) {
        let userdetails = UserDetails(context: persistentContainer.viewContext)
        if let _ = fetchUserName(userName) {
            return (false, "UserName already exists")
        }
        userdetails.email = userName
        userdetails.password = password
        save()
        return (true, "User signed up successfully")
        
    }
    
    func fetchUserName(_ userName: String) -> UserDetails? {
        let request: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
          request.predicate = NSPredicate(format: "email = %@", userName)
          var userDetailsArr: [UserDetails]?
          do {
              let details = try persistentContainer.viewContext.fetch(request)
              userDetailsArr = details
          } catch let error {
            print("Error fetching songs \(error)")
          }
        return userDetailsArr?.first
    }
    
}
