//
//  RemoteSourceMock.swift
//  SportsAppTests
//
//  Created by Alaa on 25/05/2023.
//

import Foundation
@testable import SportsApp

class RemoteSourceMock: NetworkProtocol{
    
    var isSuccess: Bool!
    init(isSuccess: Bool!) {
        self.isSuccess = isSuccess
    }
    var myResponse = EventResponse(success: 1, result: [Event(eventKey: 0, eventDay: "", eventTime: "", eventHomeTeam: "", homeTeamKey: 0, eventAwayTeam: "", awayTeamKey: 0, eventHalftimeResult: "", leagueLogo: "", homeTeamLogo: "", awayTeamLogo: "", leagueKey: 0, leagueName: "", eventStadium: "", leagueSeason: "", finalResult: ""),
                                                                         Event(eventKey: 0, eventDay: "", eventTime: "", eventHomeTeam: "", homeTeamKey: 0, eventAwayTeam: "", awayTeamKey: 0, eventHalftimeResult: "", leagueLogo: "", homeTeamLogo: "", awayTeamLogo: "", leagueKey: 0, leagueName: "", eventStadium: "", leagueSeason: "", finalResult: ""),
                                                                          Event(eventKey: 0, eventDay: "", eventTime: "", eventHomeTeam: "", homeTeamKey: 0, eventAwayTeam: "", awayTeamKey: 0, eventHalftimeResult: "", leagueLogo: "", homeTeamLogo: "", awayTeamLogo: "", leagueKey: 0, leagueName: "", eventStadium: "", leagueSeason: "", finalResult: "")])
    
    func getData<T>(path: String, sport: String, handler: @escaping (T?) -> Void) where T : Decodable {
        
        if isSuccess{
            handler(myResponse as? T)
        }else{
            handler(nil)
        }
        
    }
    
}
