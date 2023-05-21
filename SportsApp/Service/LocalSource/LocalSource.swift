//
//  LocalSource.swift
//  SportsApp
//
//  Created by Alaa on 20/05/2023.
//

import Foundation
import UIKit
import CoreData

class LocalSource: LocalSourceProtocol{
    
    var managedContext: NSManagedObjectContext
    init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    func insertLeague(l: LeagueLocal){
        let entity = NSEntityDescription.entity(forEntityName: "LeagueLoc", in: managedContext)
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        league.setValue(l.name, forKey: "name")
        league.setValue(l.youtube, forKey: "youtube")
        league.setValue(l.sport, forKey: "sport")
        league.setValue(l.logo, forKey: "logo")
        league.setValue(l.key, forKey: "key")
        do{
            try managedContext.save()
            print("\nInserting a league done...\n")
        }catch let error as NSError{
            print("\nerror in adding to favourite: \(error)\n")
        }
    }
    
    func getDataFromLocal() -> [LeagueLocal]{
        var leaguesL: [LeagueLocal] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueLoc")
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            for i in leagues{
                let l = LeagueLocal(sport: i.value(forKey: "sport") as! String,
                                    youtube: i.value(forKey: "youtube") as! String,
                                    name: i.value(forKey: "name") as! String,
                                    logo: i.value(forKey: "logo") as! String,
                                    key: i.value(forKey: "key") as! Int)
                leaguesL.append(l)
            }
            print("\nGetting all leagues done...\n")
        }catch let error as NSError{
            print("\nerror in fetching all leagues: \(error)\n")
        }
        
        return leaguesL
    }
    
    func getLeagueFromLocal(name: String,key: Int) -> LeagueLocal?{
        var leagueL: LeagueLocal?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueLoc")
        
        let myPredicate = NSPredicate(format: "name == %@ and key == %d", name, key)
        fetchRequest.predicate = myPredicate
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            if leagues.count > 0{
                let i = leagues[0]
                leagueL = LeagueLocal(sport: i.value(forKey: "sport") as! String,
                                      youtube: i.value(forKey: "youtube") as! String,
                                      name: i.value(forKey: "name") as! String ,
                                      logo: i.value(forKey: "logo") as! String,
                                      key: i.value(forKey: "key") as! Int)
                print("\nGetting league done...\n")
            }else{
                print("no such itemmmmmmå")
            }
        }catch let error as NSError{
            print("\nerror in fetching all leagues: \(error)\n")
        }
        
        return leagueL ?? nil
    }
    
    func deleteFromLocal(name: String, key: Int) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueLoc")
        
        let myPredicate = NSPredicate(format: "key == %d", key)
        //        let myPredicate = NSPredicate(format: "name == %@ and key == %d", name, key)
        fetchRequest.predicate = myPredicate
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            print(leagues.count)
            if leagues.count > 0{
                managedContext.delete(leagues[0])
                try managedContext.save()
                print("\nDelete league done...\n")
            }
        }catch let error as NSError{
            print("\nerror in deleteting a league : \(error)\n")
        }
    
    }
    
}
