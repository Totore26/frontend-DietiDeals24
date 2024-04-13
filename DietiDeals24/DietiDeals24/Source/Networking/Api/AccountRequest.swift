//
//  AccountRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/02/24.
//

import Alamofire

class AccountRequest: AccountAPI {
    
    
    func getHomeAuctionByUsername(accountUsername: String, resultHandlerCallBack: @escaping (Result<AuctionData, APIError>) -> Void) {
    }
    
    //@escaping serve per eseguire la closure in modo asincrono (modo piu semplice e veloce di tutti)
    func getAccountById(accountId: String, resultHandlerCallBack: @escaping (Result<Account, APIError>) -> Void){
        
    }
    
    func addAccount(account: Account) {
        
    }
    
    func updateAccount(account: Account) {
        
    }
    
}
