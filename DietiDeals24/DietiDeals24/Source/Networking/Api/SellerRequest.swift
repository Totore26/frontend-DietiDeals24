//
//  SellerRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

//questa classe eredita i metodi di AccountRequest e deve implementare SellerAPI
class SellerRequest: AccountRequest, SellerAPI {
    
    func getGeneratedAuctions(accountId: String) -> [AuctionData] {
        return []
    }
    
}
