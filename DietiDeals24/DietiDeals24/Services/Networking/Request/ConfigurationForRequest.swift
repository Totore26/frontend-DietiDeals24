//
//  Configuration.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

struct baseURL {
    static let baseURL = "https://localhost:8080/api/"
    
    static func append(path: String) -> String {
        return baseURL + path
    }
}

/*
    esempio utilizzo:
    
    var CustomURL = baseURL.append(path: "auctions")
 
    AF.request(baseURL.append(path: "/auctions"), method: .get)       <---- credo sia meglio cosi piu diretto e capibile
 
*/

    
