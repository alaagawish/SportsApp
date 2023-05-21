//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Alaa on 21/05/2023.
//

import Foundation

class LeagueDetailsViewModel{
    var sport: String?
    var upComingArrayToViewController: (()->()) = {}
    var upComingEvents: [Event]!{
        didSet{
            upComingArrayToViewController()
        }
    }
    var latestArrayToViewController: (()->()) = {}
    var latestEvents: [Event]!{
        didSet{
            latestArrayToViewController()
        }
    }
    var teamArrayToViewController: (()->()) = {}
    var teams: [Event]!{
        didSet{
            teamArrayToViewController()
        }
    }
    init(sport: String ) {
        self.sport = sport
    }
    
    func getUpComingEvents(){
        Network.getData(path: "", sport: sport ?? "") { [weak self] (myResponse: EventResponse!) in
             print("upcoming events done")
            self?.upComingEvents = myResponse.result
        }
        
    }
    func getLatestEvents(){
        
        Network.getData(path: "", sport: sport ?? "") { [weak self] (myResponse: EventResponse!) in
             print("latest events done")
            self?.latestEvents = myResponse.result
        }
    }
    func getTeams(){
        
//        Network.getData(path: "", sport: sport ?? "") { [weak self] (myResponse: MyResponse!) in
//
//            self?.leagues = myResponse.result
//        }
    }
    
}
