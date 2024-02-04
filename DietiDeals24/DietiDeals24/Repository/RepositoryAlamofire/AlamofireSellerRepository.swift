//
//  AlamofireSellerRepository.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/02/24.
//

class AlamofireSellerRepository: SellerRepository {
    
    var sellerAPI: SellerAPI
    
    init(sellerAPI: SellerAPI) {
        self.sellerAPI = sellerAPI
    }
    
    func getAccountById(accountId: String, resultHandlerCallBack: @escaping (Result<Seller, APIError>) -> Void) {
        sellerAPI.getAccountById(accountId: accountId, resultHandlerCallBack: resultHandlerCallBack)
    }
    
    func addAccount(account: Account) {
        sellerAPI.addAccount(account: account)
    }
    
    func updateAccount(account: Account) {
        sellerAPI.updateAccount(account: account)
    }
    
    func getGeneratedAuctions(accountId: String) -> [Auction] {
        return sellerAPI.getGeneratedAuctions(accountId: accountId)
    }
    
}
