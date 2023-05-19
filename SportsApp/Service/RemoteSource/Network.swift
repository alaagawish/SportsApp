//
//  Network.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import Foundation
import Alamofire

class Network: NetworkProtocol{
    static func getData<T>(path: String, handler: @escaping (T?) -> Void) where T : Decodable {
        
        AF.request("https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=56eb8e9b98b07e7b09bee4217bb82621b88ff72ad858cb1bbd8eac1ff36db88b", method: .get).responseDecodable(of: T.self) { response in

            switch response.result {
                    case .success(let data):
                        print("done")
                        handler(data )
                    case .failure(let error):
                        print("Error: \(error)")
                    }
           
  
        }
       
        
    }
    
    
    
}
