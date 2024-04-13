//
//  AuctionRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire
import Foundation

class AuctionRequest: AuctionAPI {
    
    func getAuctionById(auctionId: String) -> Auction? {
        return nil
    }
    
    func createAuction(auction: Auction) {
        
    }
    
    func updateAuction(auction: Auction) {
        
    }

    func getAllActiveAuctions(completion: @escaping (Result<[AuctionProtocol], Error>) -> Void) {
        let url = baseURL.append(path: "auction/home")
        AF.request(url)
            .validate()
            .responseDecodable(of: AuctionResponse.self) { response in
                switch response.result {
                case .success(let auctionResponse):
                        
                    let auctions = auctionResponse.auctions.map { auctionData -> AuctionProtocol in
                        if let endOfAuctionString = auctionData.endOfAuction {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                            guard let endOfAuctionDate = formatter.date(from: endOfAuctionString) else {
                                fatalError("Errore nel formattare la data di fine asta.")
                            }
                            let minimumSecretThreshold = auctionData.minimumSecretThreshold ?? 0.0
                            return FixedTimeAuction(id: auctionData.id, creator: auctionData.creator["email"]!, title: auctionData.title, description: auctionData.description, location: auctionData.location, category: auctionData.category, endOfAuction: endOfAuctionDate, minimumSecretThreshold: minimumSecretThreshold)
                        } else {
                            let raisingThreshold = auctionData.raisingThreshold ?? 0.0
                            let startingPrice = auctionData.startingPrice ?? 0.0
                            return IncrementalAuction(id: auctionData.id, creator: auctionData.creator["email"]!, title: auctionData.title, description: auctionData.description, location: auctionData.location, category: auctionData.category, raisingThreshold: raisingThreshold, startingPrice: startingPrice, timeToBet: auctionData.timer!)
                        }
                    }
                    completion(.success(auctions))
                        
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    
    
    struct AuctionData: Decodable {
        let id: String
        let creator: [String: String]
        let title: String
        let description: String
        let location: String
        let category: String
        let endOfAuction: String?
        let minimumSecretThreshold: Float?
        let raisingThreshold: Float?
        let startingPrice: Float?
        let timer: Data?
    }

    struct AuctionResponse: Decodable {
        let auctions: [AuctionData]
    }



    
}
 
