//
//  League.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import Foundation

class League: Decodable{
    var leagueKey: Int?
    var leagueName: String?
    var countryKey: Int?
    var countryName: String?
    var leagueLogo: String?
    var countryLogo: String?
    
    
    enum CodingKeys: String, CodingKey{
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
    
}
