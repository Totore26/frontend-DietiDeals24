//
//  AccountAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

import Foundation


protocol AccountAPI {
    
    
    func getHomeAuctionByUsername(accountUsername : String, resultHandlerCallBack: @escaping (Result<Auction, APIError>) -> Void)
    
    func getAccountById(accountId: String, resultHandlerCallBack: @escaping (Result<Account, APIError>) -> Void)
    
    func addAccount(account: Account) 
    
    func updateAccount(account: Account)
    
}

