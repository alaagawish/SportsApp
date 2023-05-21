//
//  LocalSourceProtocol.swift
//  SportsApp
//
//  Created by Alaa on 20/05/2023.
//

import Foundation
protocol LocalSourceProtocol{
    func insertLeague(l: LeagueLocal)
    
    func getDataFromLocal() -> [LeagueLocal]
    
    func getLeagueFromLocal(name: String, key: Int)  -> LeagueLocal?
    
    func deleteFromLocal(name: String, key: Int)
}
