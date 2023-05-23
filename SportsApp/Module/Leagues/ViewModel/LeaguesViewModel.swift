//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Alaa on 20/05/2023.
//

import Foundation
class LeaguesViewModel{
    var sport: String?
    var network: NetworkProtocol!
    var passArrayToViewController: (()->()) = {}
    var leagues: [League]!{
        didSet{
            passArrayToViewController()
        }
    }
    init(sport: String, network: NetworkProtocol) {
        self.sport = sport
        self.network = network
    }
    
    func getData(){
        
        network.getData(path: "Leagues", sport: sport ?? "") { [weak self] (myResponse: MyResponse!) in
            
            self?.leagues = myResponse.result
        }
    }
}
