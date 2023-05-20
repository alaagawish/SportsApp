//
//  FavouriteViewModel.swift
//  SportsApp
//
//  Created by Alaa on 20/05/2023.
//

import Foundation

class FavouriteViewModel{
    var refreshFavouriteLeagues: (()->()) = {}
    var leagues: [LeagueLocal]?{
        didSet{
            print("Refreshing fav table")
//            refreshFavouriteLeagues()
        }
    }
    var returnFavouriteLeague: (()->()) = {}
    var league: LeagueLocal?{
        didSet{
            print("Return selected league")
//            returnFavouriteLeague()
        }
    }
    
    var localSource: LocalSourceProtocol
    init( localSource: LocalSourceProtocol) {
        self.localSource = localSource
    }
    
    func getLeagues() -> [LeagueLocal]{
        leagues = localSource.getDataFromLocal()
        print("Refreshing fav table")
        refreshFavouriteLeagues()
       return leagues ?? []
    }
    
    func deleteLeague(name: String){
        localSource.deleteFromLocal(name: name)
        let _ = getLeagues()
    }
    
    func getSelectedLeague(name: String) -> LeagueLocal{
        league = localSource.getLeagueFromLocal(name: name)
        print("Return selected league")
        returnFavouriteLeague()
        return league!
    }
}
