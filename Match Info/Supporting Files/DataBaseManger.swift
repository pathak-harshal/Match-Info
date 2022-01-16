//
//  DataBaseManger.swift
//  Match Info
//
//  Created by Harshal Pathak on 15/01/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class DataBaseManger: NSObject {
    
    class func getTitle() -> String {
        var title = ""
        
        let context = CoreDataStack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        
        do {
            let results = try context.fetch(fetchRequest) as! [Team]
            
            title = results.map({ (team: Team) -> String in
                team.team_short_name!
            }).joined(separator: " vs ")
            
        } catch let error as NSError {
            
            print(error)
            
        }
        
        return title
    }
    
    class func fetchPlayers(teamId: Int64) -> [Player] {
        let context = CoreDataStack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let predicate = NSPredicate(format: "team.team_id == \(teamId)")
        fetchRequest.predicate = predicate
        let sorting = NSSortDescriptor(key: "player_position", ascending: true)
        fetchRequest.sortDescriptors = [sorting]
        guard let players = try? context.fetch(fetchRequest) as? [Player] else {
            return [Player]()
            
        }
        
        return players
    }
    
    class func fetchAllTeamswithPlayers() -> [Team] {
        let context = CoreDataStack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        
        do {
            
            let results = try context.fetch(fetchRequest) as! [Team]
            
            return results
            
        } catch let error as NSError {
            
            print(error)
            
        }
        
        return []
    }
    
    class func saveTeamsPlayersToDB(fromUrl: Int, _ completionBlock : @escaping (_ isSuccess: Bool)->()) {
        ServiceManager.loadTeams(fromUrl: fromUrl) { (response, error) in
            let context = CoreDataStack.persistentContainer.viewContext
            CoreDataStack.clearDatabase()
            guard let data = response else {
                completionBlock(false)
                return
            }
            guard let json = try? JSON(data: data) else {
                completionBlock(false)
                return
            }
            let teams = json["Teams"].dictionaryValue
            for teamKey in teams.keys {
                let team = Team(context: context)
                team.team_id = Int64(teamKey)!
                team.team_short_name = teams[teamKey]?["Name_Short"].stringValue
                team.team_name = teams[teamKey]?["Name_Full"].stringValue
                
                guard let players = teams[teamKey]?["Players"].dictionaryValue else {
                    completionBlock(false)
                    return
                    
                }
                for playerKey in players.keys {
                    let player = Player(context: context)
                    player.player_id = Int64(playerKey) ?? 0
                    player.player_name = players[playerKey]?["Name_Full"].stringValue
                    player.player_position = players[playerKey]?["Position"].int64Value ?? 0
                    if let isWicketKeeper = players[playerKey]?["Iskeeper"].bool {
                        player.player_is_wicket_keeper = isWicketKeeper
                    } else {
                        player.player_is_wicket_keeper = false
                    }
                    
                    if let isCaptain = players[playerKey]?["Iscaptain"].bool {
                        player.player_is_captain = isCaptain
                    } else {
                        player.player_is_captain = false
                    }
                    player.team = team
                }
                
                CoreDataStack.saveContext()
            }
            completionBlock(true)
        }
    }
}
