//
//  Fact+CoreDataProperties.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 25.11.2022.
//
//

import Foundation
import CoreData


extension Fact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fact> {
        return NSFetchRequest<Fact>(entityName: "Fact")
    }

    @NSManaged public var fact: String?
    @NSManaged public var factId: Int64
    @NSManaged public var anime: Anime?

}

extension Fact : Identifiable {

}
