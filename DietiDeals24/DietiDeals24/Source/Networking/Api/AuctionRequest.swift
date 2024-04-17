//
//  AuctionRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire
import Foundation

import Alamofire
import Foundation

class AuctionRequest: AuctionAPI {
    
    
    
    
    
    func getAuctionById(auctionId: String) -> AuctionData? {
        return nil
    }
    
    
    
    func createAuction(auction: AuctionData) {
        
    }
    
    
    
    func updateAuction(auction: AuctionData) {
        
    }
    
    
    

    func getAllActiveAuctionsAPI(completion: @escaping (Result<[AuctionData], Error>) -> Void) {
        let url = baseURL.append(path: "auction/home")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: [AuctionData].self) { response in
            switch response.result {
            case .success(let auctions):
                completion(.success(auctions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMyAuctionBuyerAPI(completion : @escaping (Result<[AuctionData], Error>) -> Void, username : String) {
        let url = baseURL.append(path: "auction/\(username)/buyer/myAuction")
        print("\n\n \(username) \n\n")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: [AuctionData].self) { response in
            switch response.result {
            case .success(let auctions):
                completion(.success(auctions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getMyAuctionSellerAPI(completion : @escaping (Result<[AuctionData], Error>) -> Void, username : String) {
        let url = baseURL.append(path: "auction/\(username)/seller/myAuction")
  
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: [AuctionData].self) { response in
            switch response.result {
            case .success(let auctions):
                completion(.success(auctions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
    
    
    
    
    
    func getMyAuctionBuyer(){
        
    }
    
    func getMyAuctionSeller(){
        
    }
    
    func filterAuctions() {
        
    }
    
    
    
    
    
    
    
}

    
    

 
