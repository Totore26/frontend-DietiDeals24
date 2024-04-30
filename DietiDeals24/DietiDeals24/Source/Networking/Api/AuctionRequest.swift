//
//  AuctionRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire
import Foundation

class AuctionRequest: AuctionAPI {
    
    
    
    
    
    func getAuctionById(auctionId: String) -> AuctionData? {
        return nil
    }
    
    
    
    func createIncrementalAuctionAPI(auction: AuctionData, completion: @escaping (Bool, Error?) -> Void) {
        let url = baseURL.append(path: "auction/createAuction/incremental")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)",
            "Content-Type": "application/json"
        ]
        
        do {
            let jsonData = try JSONEncoder().encode(auction)
            
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "PUT"
            request.headers = headers
            request.httpBody = jsonData
            
            AF.request(request)
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        completion(true, nil)
                    case .failure(let error):
                        // Passa l'errore alla chiusura di completamento
                        completion(false, error)
                    }
                }
        } catch {
            // Se si verifica un errore durante la codifica dei dati, passalo alla chiusura di completamento
            completion(false, error)
        }
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
    
    func filterAuctions(
        searchText: String?,
        category: String?,
        startingPrice: String?,
        endingPrice: String?,
        completion: @escaping (Result<[AuctionData], Error>) -> Void
    ) {
        let url = baseURL.append(path: "auction/home/search")
        
        var parameters: [String: Any] = [:]
        if let searchText = searchText {
            parameters["toSearch"] = searchText
        }
        if let category = category {
            parameters["category"] = category
        }
        if let startingPrice = startingPrice {
            parameters["startingPrice"] = startingPrice
        }
        if let endingPrice = endingPrice {
            parameters["endingPrice"] = endingPrice
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: [AuctionData].self) { response in
                switch response.result {
                case .success(let auctions):
                    completion(.success(auctions))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}

    
    

 
