//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Alaa on 20/05/2023.
//

import Foundation
class LeaguesViewModel{
    var sport: String?
    var passArrayToViewController: (()->()) = {}
    var leagues: [League]!{
        didSet{
            passArrayToViewController()
        }
    }
    init(sport: String ) {
        self.sport = sport
    }
    
    func getData(){
        
        Network.getData(path: "Leagues", sport: sport ?? "") { [weak self] (myResponse: MyResponse!) in
             
            self?.leagues = myResponse.result
        }
    }
}
