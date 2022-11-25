//
//  Anime+CoreDataProperties.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 25.11.2022.
//
//

import Foundation
import CoreData


extension Anime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Anime> {
        return NSFetchRequest<Anime>(entityName: "Anime")
    }

    @NSManaged public var name: String?
    @NSManaged public var animeFacts: Set<Fact>

}

// MARK: Generated accessors for animeFacts
extension Anime {

    @objc(addAnimeFactsObject:)
    @NSManaged public func addToAnimeFacts(_ value: Fact)

    @objc(removeAnimeFactsObject:)
    @NSManaged public func removeFromAnimeFacts(_ value: Fact)

    @objc(addAnimeFacts:)
    @NSManaged public func addToAnimeFacts(_ values: NSSet)

    @objc(removeAnimeFacts:)
    @NSManaged public func removeFromAnimeFacts(_ values: NSSet)

}

extension Anime : Identifiable {

}
