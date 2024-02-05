//
//  Place+CoreDataProperties.swift
//  Projekt1
//
//  Created by Mikołaj Starczewski on 18/06/2022.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var user: User?
    @NSManaged public var pin: Pin?
    
    

}

// MARK: Generated accessors for user
extension Place {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension Place : Identifiable {

}
