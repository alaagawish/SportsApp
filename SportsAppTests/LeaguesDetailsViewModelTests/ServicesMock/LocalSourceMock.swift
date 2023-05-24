//
//  LocalSourceTest.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import Foundation
@testable import SportsApp
class LocalSourceMock: LocalSourceProtocol{
    var leagues: [LeagueLocal]!
    init(){
        leagues = [ LeagueLocal(sport: "football", youtube: "", name: "sport1", logo: "sport1", key: 0),
                    LeagueLocal(sport: "basketball", youtube: "", name: "sport2", logo: "sport2", key: 1),
                    LeagueLocal(sport: "tennis", youtube: "", name: "sport3", logo: "sport3", key: 2),
                    LeagueLocal(sport: "football", youtube: "", name: "sport4", logo: "sport4", key: 3),
                    LeagueLocal(sport: "basketball", youtube: "", name: "sport5", logo: "sport5", key: 4),
                    LeagueLocal(sport: "cricket", youtube: "", name: "sport6", logo: "sport6", key: 5),
                    LeagueLocal(sport: "cricket", youtube: "", name: "sport7", logo: "sport7", key: 6)]
        
    }
    func insertLeague(l: LeagueLocal){
        leagues.append(l)
        
    }
    
    func getDataFromLocal() -> [LeagueLocal]{
        
        return leagues
    }
    
    func getLeagueFromLocal(name: String,key: Int) -> LeagueLocal?{
        
        for i in leagues{
            if   i.key == key{
                return i
            }
        }
        
        return  nil
    }
    
    func deleteFromLocal(name: String, key: Int) {
        
        for i in 0..<leagues.count{
            
            if  leagues[i].key == key{
                leagues.remove(at: i)
                break
            }
        }
    }
    
}

