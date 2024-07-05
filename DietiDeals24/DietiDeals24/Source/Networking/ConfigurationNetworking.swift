//
//  ConfigurationNetworking.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

import Alamofire


var authToken: String = ""

struct baseURL {
    static let baseURL = "http://3.254.58.212/"
    
    static func append(path: String) -> String {
        return baseURL + path
    }
}

struct APIError: Error {
    
    let networkError: AFError
    
    let statusCode: Int?
    
}
