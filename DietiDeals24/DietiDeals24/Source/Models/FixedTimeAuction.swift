//
//  FixedTimeAuction.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

class FixedTimeAuction: AuctionProtocol {
    
    var creator: String
    
    var imageAuction: String
    
    var title: String
    
    var description: String
    
    var location: String
    
    var category: String
    
    var endOfAuction: Date
    
    var minimumSecretThreshold: Float
    
    init(creator: String, imageAuction: String, title: String, description: String, location: String, category: String, endOfAuction: Date, minimumSecretThreshold: Float) {
        self.creator = creator
        self.imageAuction = imageAuction
        self.title = title
        self.description = description
        self.location = location
        self.category = category
        self.endOfAuction = endOfAuction
        self.minimumSecretThreshold = minimumSecretThreshold
    }
}
