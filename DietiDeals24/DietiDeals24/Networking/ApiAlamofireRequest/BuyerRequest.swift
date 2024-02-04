//
//  BuyerRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

class BuyerRequest: BuyerAPI {
 
    func getAccountById(accountId: String) -> Account? {
        return nil
    }
    
    func addAccount(account: Account) {
        
    }
    
    func updateAccount(account: Account) {
        
    }
    
    func getFollowedAuctions(accountId: String) -> [Auction] {
        return []
    }
    
}
