//
//  BetRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire
import SwiftUI

class BetRequest: BetAPI {
    
    func getAllBets() -> [Bet] {
        return []
    }
    
    func getBetById(betId: String) -> Bet? {
        return nil
    }
    
    func createBet(bet: Bet) {
        
    }
    
    func getMaxBetForAuction(auctionId: String) -> Bet? {
        return nil
    }
    
    
    func betAPI(emailBuyer: String, idAuction: String, betValue: Decimal, completion: @escaping (Bool) -> Void)  {
        let url = baseURL.append(path: "bet/makeBet")
        
        let parameters: [String: Any] = [
            "emailBuyer": emailBuyer,
            "idAuction": idAuction,
            "betValue": betValue
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
    }

    
    
}
