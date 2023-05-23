//
//  NetworkMock.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import Foundation

@testable import SportsApp

class NetworkMock: NetworkProtocol{
    
    
    static var isSuccess: Bool = true
    var myResponse = MyResponse(success: 1, result: [League(),League(),League()])
    
    static func getData<T>(path: String, sport: String, handler: @escaping (T?) -> Void) where T : Decodable {
        
        if isSuccess{
            print("success")
            handler(MyResponse(success: 1, result: [League(),League(),League()]) as? T)
        }else{
            handler(nil)
        }
        
    }
    
}
