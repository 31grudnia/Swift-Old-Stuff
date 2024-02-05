
import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "QuizzModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to laod data \(error.localizedDescription)")
            }
            
        }
    }   //  init()
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully!")
        }   catch {
            print("Data NOT saved!")
        }
    }   //  save()
    
    func addUser(login: String, password: String, context: NSManagedObjectContext) {
        let user = User(context: context)
        user.id = UUID()
        user.login = login
        user.password = password
        
        save(context: context)
    }   //  adduser()
    
    func addHighScore(user: User, highScore: Int, context: NSManagedObjectContext) {
        user.highScore = Int32(highScore)
        
        save(context: context)
    }   //  addHighScore()
    
    func logIn(user: User, context: NSManagedObjectContext) {
        user.isLogged = true
        
        save(context: context)
    }   //logIn
    
    func logOut(user: User, context: NSManagedObjectContext) {
        user.isLogged = false
        
        save(context: context)
    }   //logOut
    
}
