//
//  SellerRepository.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/02/24.
//

protocol SellerRepository {
    
    var sellerAPI: SellerAPI {get}
    
    func getAccountById(accountId: String, resultHandlerCallBack: @escaping (Result<Seller, APIError>) -> Void)
    
    func addAccount(account: Account)
    
    func updateAccount(account: Account)
    
    func getGeneratedAuctions(accountId: String) -> [Auction]
    
}
