//
//  AuctionAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol AuctionAPI {
    
    func getAllActiveAuctions(completion: @escaping (Result<[AuctionData], Error>) -> Void)
    
    func getAuctionById(auctionId: String) -> AuctionData?
    
    func createAuction(auction: AuctionData)
    
    func updateAuction(auction: AuctionData)
    
}
 
