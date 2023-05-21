//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Alaa on 21/05/2023.
//

import Foundation

class LeagueDetailsViewModel{
    var sport: String?
    var leagueId: Int?
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
    init(sport: String, leagueId: Int ) {
        self.sport = sport
        self.leagueId = leagueId
    }
    
    func getUpComingEvents(){
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let formattedDate = dateFormatter.string(from: currentDate)
        
        print("Current date: \(formattedDate)")
        var dateComponents = DateComponents()
        dateComponents.year = 1
        
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        let nextDateFormatter = DateFormatter()
        nextDateFormatter.dateFormat = "yyyy-MM-dd"
        nextDateFormatter.locale = Locale(identifier: "en_US")
        var newFormattedDate = "2025-05-27"
        if let newDate = newDate{
            newFormattedDate = nextDateFormatter.string(from: newDate)
        }
        Network.getData(path: "Fixtures&leagueId=\(leagueId ?? 4)&from=\(formattedDate)&to=\(newFormattedDate)", sport: sport ?? "") { [weak self] (myResponse: EventResponse!) in
            print("upcoming events done")
            self?.upComingEvents = myResponse.result
        }
        
    }
    func getLatestEvents(){
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let formattedDate = dateFormatter.string(from: currentDate)
        
        var dateComponents = DateComponents()
        dateComponents.year = -1
        
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        let nextDateFormatter = DateFormatter()
        nextDateFormatter.dateFormat = "yyyy-MM-dd"
        nextDateFormatter.locale = Locale(identifier: "en_US")
        var newFormattedDate = "2025-05-27"
        if let newDate = newDate{
            newFormattedDate = nextDateFormatter.string(from: newDate)
        }
        Network.getData(path: "Fixtures&leagueId=\(leagueId ?? 4)&from=\(newFormattedDate)&to=\(formattedDate)", sport: sport ?? "") { [weak self] (myResponse: EventResponse!) in
            print("latest events done")
            print(myResponse.result.count)
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
