//
//  IncrementalAuction.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

class IncrementalAuction: AuctionProtocol {
    
    var creator: String
    
    var imageAuction: String
    
    var title: String
    
    var description: String
    
    var location: String
    
    var category: String
    
    var raisingThreshold : Float
    
    var startingPrice: Float
    
    var timer : Data

    init(creator: String, imageAuction: String, title: String, description: String, location: String, category: String, raisingThreshold: Float, startingPrice: Float, timeToBet: Data) {
        self.creator = creator
        self.imageAuction = imageAuction
        self.title = title
        self.description = description
        self.location = location
        self.category = category
        self.raisingThreshold = raisingThreshold
        self.startingPrice = startingPrice
        self.timer = timeToBet
    }
    
}

