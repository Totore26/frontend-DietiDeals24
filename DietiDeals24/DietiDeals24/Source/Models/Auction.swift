//
//  Auction.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 09/12/23.
//
import Foundation


class AuctionData: Decodable, Identifiable {
    let id: String?
    let creator: Seller
    var participants: [Buyer]?
    let title: String?
    let description: String?
    let imageAuction: String?
    let category: String?
    let location: String?
    var currentPrice: Decimal?
    let startingPrice: Decimal?
    let raisingThreshold: Decimal?
    let endOfAuction: String?
    let minimumSecretThreshold: Decimal?
    let timer : Int?

    // Implementazione dell'inizializzatore richiesto
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
