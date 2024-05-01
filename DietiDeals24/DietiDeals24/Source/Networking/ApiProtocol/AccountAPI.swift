//
//  AccountAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

import Foundation


protocol AccountAPI {
    
    func getInfoBuyerAccountAPI(completion: @escaping (Result<Account, Error>) -> Void, username : String)
    
    func getInfoSellerAccountAPI(completion: @escaping (Result<Account, Error>) -> Void, username : String)
     
    func modifyBuyerAccountAttributeAPI(json: Data, completion: @escaping (Bool) -> Void)
    
    func modifySellerAccountAttributeAPI(json: Data, completion: @escaping (Bool) -> Void)
    
    func upgradeAccountToSellerAPI(email: String, completion: @escaping (Bool) -> Void)
}

