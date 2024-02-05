//
//  Pin+CoreDataProperties.swift
//  Projekt1
//
//  Created by Mikołaj Starczewski on 18/06/2022.
//
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var id: UUID?
    @NSManaged public var place: Place?

}

extension Pin : Identifiable {

}
