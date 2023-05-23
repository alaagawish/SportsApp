//
//  NetworkProtocol.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import Foundation

protocol NetworkProtocol{
     func getData<T: Decodable>(path: String, sport: String, handler: @escaping (T?)-> Void)
}
