//
//  MyResponse.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import Foundation


struct MyResponse: Decodable{
    let success: Int
    let result: [League]
}

struct EventResponse: Decodable{
    let success: Int
    let result: [Event]
}
