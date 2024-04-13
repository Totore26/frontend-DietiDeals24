//
//  AuctionAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol AuctionAPI {
    
    func getAllActiveAuctions(completion: @escaping (Result<[AuctionProtocol], Error>) -> Void)
    
    func getAuctionById(auctionId: String) -> Auction?
    
    func createAuction(auction: Auction)
    
    func updateAuction(auction: Auction)
    
}
 
