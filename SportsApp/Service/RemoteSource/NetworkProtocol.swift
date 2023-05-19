//
//  NetworkProtocol.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import Foundation

protocol NetworkProtocol{
   static func getData<T: Decodable>(path: String, handler: @escaping (T?)-> Void)
}