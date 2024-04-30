//
//  AuctionAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol AuctionAPI {
    
    func getAllActiveAuctionsAPI(completion: @escaping (Result<[AuctionData], Error>) -> Void)
    
    func getMyAuctionBuyerAPI(completion: @escaping (Result<[AuctionData], Error>) -> Void, username: String)
    
    func getMyAuctionSellerAPI(completion: @escaping (Result<[AuctionData], Error>) -> Void, username: String)
    
    func createIncrementalAuctionAPI(auction: AuctionData, completion: @escaping (Bool, Error?) -> Void)

    func filterAuctions(
        searchText: String?,
        category: String?,
        startingPrice: String?,
        endingPrice: String?,
        completion: @escaping (Result<[AuctionData], Error>) -> Void
    ) 
    
    func getAuctionById(auctionId: String) -> AuctionData?
    
    func updateAuction(auction: AuctionData)
    
}
