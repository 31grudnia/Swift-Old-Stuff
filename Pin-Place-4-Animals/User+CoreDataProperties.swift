//
//  User+CoreDataProperties.swift
//  Projekt1
//
//  Created by Mikołaj Starczewski on 18/06/2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var id: UUID?
    @NSManaged public var place: NSSet?

    public var placeArray: [Place] {
        let set = place as? Set<Place> ?? []
        return set.sorted {
            $0.title! < $1.title!
        }
    }
    
}

extension User : Identifiable {

}
