//
//  LeagueDetailsViewModelMock.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import XCTest
@testable import SportsApp

class LeagueDetailsViewModelMock: LeagueDetailsViewModel {

    let myResponse = EventResponse(success: 1, result: [Event(eventKey: 0, eventDay: "", eventTime: "", eventHomeTeam: "", homeTeamKey: 0, eventAwayTeam: "", awayTeamKey: 0, eventHalftimeResult: "", leagueLogo: "", homeTeamLogo: "", awayTeamLogo: "", leagueKey: 0, leagueName: "", eventStadium: "", leagueSeason: "", finalResult: ""),
                                                        Event(eventKey: 0, eventDay: "", eventTime: "", eventHomeTeam: "", homeTeamKey: 0, eventAwayTeam: "", awayTeamKey: 0, eventHalftimeResult: "", leagueLogo: "", homeTeamLogo: "", awayTeamLogo: "", leagueKey: 0, leagueName: "", eventStadium: "", leagueSeason: "", finalResult: ""),
                                                         Event(eventKey: 0, eventDay: "", eventTime: "", eventHomeTeam: "", homeTeamKey: 0, eventAwayTeam: "", awayTeamKey: 0, eventHalftimeResult: "", leagueLogo: "", homeTeamLogo: "", awayTeamLogo: "", leagueKey: 0, leagueName: "", eventStadium: "", leagueSeason: "", finalResult: "")])

     
    override func getUpComingEvents(){
        
        upComingEvents = myResponse.result

     }
    override func getLatestEvents(){
       
         latestEvents = myResponse.result
         
     }
     
    override func deleteLeague(name: String, key: Int){
         localSource.deleteFromLocal(name: name, key: key)
     }
     
    override func getSelectedLeague(name: String, key: Int) -> LeagueLocal?{
         print("Return selected league")
         
         return localSource.getLeagueFromLocal(name: name, key: key) ?? nil
     }
    override func addToFav(l: LeagueLocal){
         localSource.insertLeague(l: l)
     }
     

}
