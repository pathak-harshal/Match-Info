//
//  Player+CoreDataProperties.swift
//  Match Info
//
//  Created by Harshal Pathak on 15/01/22.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var player_id: Int64
    @NSManaged public var player_name: String?
    @NSManaged public var player_position: Int64
    @NSManaged public var player_is_wicket_keeper: Bool
    @NSManaged public var player_is_captain: Bool
    @NSManaged public var team: Team?

}

extension Player : Identifiable {

}
