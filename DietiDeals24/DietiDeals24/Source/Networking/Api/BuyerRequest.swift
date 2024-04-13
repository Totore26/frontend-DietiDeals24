//
//  BuyerRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

class BuyerRequest: BuyerAPI {
 
    func getAccountById(accountId: String, resultHandlerCallBack: @escaping (Result<Seller, APIError>) -> Void) {
        
    }
    
    func addAccount(account: Account) {
        
    }
    
    func updateAccount(account: Account) {
        
    }
    
    func getFollowedAuctions(accountId: String) -> [AuctionData] {
        return []
    }
    
}
