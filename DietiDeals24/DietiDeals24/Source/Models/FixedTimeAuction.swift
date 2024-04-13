//
//  FixedTimeAuction.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

class FixedTimeAuction: AuctionProtocol, Decodable {
    
    var id: String
    
    var creator: String
    
    var title: String
    
    var description: String
    
    var location: String
    
    var category: String
    
    var endOfAuction: Date
    
    var minimumSecretThreshold: Float
    
    init(id: String, creator: String, title: String, description: String, location: String, category: String, endOfAuction: Date, minimumSecretThreshold: Float) {
        self.id = id
        self.creator = creator
        self.title = title
        self.description = description
        self.location = location
        self.category = category
        self.endOfAuction = endOfAuction
        self.minimumSecretThreshold = minimumSecretThreshold
    }
}
