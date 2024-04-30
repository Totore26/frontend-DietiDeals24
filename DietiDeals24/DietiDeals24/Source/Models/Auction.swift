//
//  Auction.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 09/12/23.
//
import Foundation


class AuctionData: Codable, Identifiable {
    let id: String?
    var creator: Seller
    var participants: [Buyer]?
    var title: String?
    var description: String?
    var imageAuction: String?
    var category: String?
    var location: String?
    var currentPrice: Decimal?
    var startingPrice: Decimal?
    var raisingThreshold: Decimal?
    var endOfAuction: String?
    var minimumSecretThreshold: Decimal?
    var timer : Int?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(creator, forKey: .creator)
        try container.encode(participants, forKey: .participants)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(imageAuction, forKey: .imageAuction)
        try container.encode(category, forKey: .category)
        try container.encode(location, forKey: .location)
        try container.encode(currentPrice, forKey: .currentPrice)
        try container.encode(startingPrice, forKey: .startingPrice)
        try container.encode(raisingThreshold, forKey: .raisingThreshold)
        try container.encode(endOfAuction, forKey: .endOfAuction)
        try container.encode(minimumSecretThreshold, forKey: .minimumSecretThreshold)
        try container.encode(timer, forKey: .timer)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        creator = try container.decode(Seller.self, forKey: .creator)
        participants = try container.decodeIfPresent([Buyer].self, forKey: .participants)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        imageAuction = try container.decodeIfPresent(String.self, forKey: .imageAuction)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        currentPrice = try container.decodeIfPresent(Decimal.self, forKey: .currentPrice)
        startingPrice = try container.decodeIfPresent(Decimal.self, forKey: .startingPrice)
        raisingThreshold = try container.decodeIfPresent(Decimal.self, forKey: .raisingThreshold)
        endOfAuction = try container.decodeIfPresent(String.self, forKey: .endOfAuction)
        minimumSecretThreshold = try container.decodeIfPresent(Decimal.self, forKey: .minimumSecretThreshold)
        timer = try container.decodeIfPresent(Int.self, forKey: .timer)
    }

    init(id: String? = nil,
         creator: Seller = Seller(email: ""),
         participants: [Buyer]? = [],
         title: String? = "",
         description: String? = "",
         imageAuction: String? = "",
         category: String? = "All",
         location: String? = "",
         currentPrice: Decimal? = Decimal(0.0),
         startingPrice: Decimal? = Decimal(0.0),
         raisingThreshold: Decimal? = Decimal(0.0),
         endOfAuction: String? = "",
         minimumSecretThreshold: Decimal? = Decimal(0.0),
         timer: Int? = 0) {
        self.id = id
        self.creator = creator
        self.participants = participants
        self.title = title
        self.description = description
        self.imageAuction = imageAuction
        self.category = category
        self.location = location
        self.currentPrice = currentPrice
        self.startingPrice = startingPrice
        self.raisingThreshold = raisingThreshold
        self.endOfAuction = endOfAuction
        self.minimumSecretThreshold = minimumSecretThreshold
        self.timer = timer
    }
    
    // Definizione delle chiavi di decodifica
    private enum CodingKeys: String, CodingKey {
        case currentPrice
        case id
        case creator
        case participants
        case title
        case description
        case imageAuction
        case category
        case location
        case startingPrice
        case raisingThreshold
        case endOfAuction
        case minimumSecretThreshold
        case timer
    }
}
