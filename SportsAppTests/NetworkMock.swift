//
//  NetworkMock.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import Foundation

@testable import SportsApp

class NetworkMock: NetworkProtocol{
    
    var isSuccess: Bool!
    init(isSuccess: Bool!) {
        self.isSuccess = isSuccess
    }
    var myResponse = MyResponse(success: 1, result: [League(),League(),League()])
    
    func getData<T>(path: String, sport: String, handler: @escaping (T?) -> Void) where T : Decodable {
        
        if isSuccess{
            handler(MyResponse(success: 1, result: [League(),League(),League()]) as? T)
        }else{
            handler(nil)
        }
        
    }
    
}
