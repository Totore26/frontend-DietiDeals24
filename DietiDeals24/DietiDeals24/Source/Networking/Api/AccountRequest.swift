//
//  AccountRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/02/24.
//

import Alamofire

class AccountRequest: AccountAPI {
    
    //@escaping serve per eseguire la closure in modo asincrono (modo piu semplice e veloce di tutti)
    func getAccountById(accountId: String, resultHandlerCallBack: @escaping (Result<Account, APIError>) -> Void) {
        let url = baseURL.append(path: "accounts/\(accountId)")

        AF.request(url)
            .validate()
            .responseDecodable(of: Seller.self) { response in
                switch response.result {
                case .success(let seller):
                    resultHandlerCallBack(.success(seller))
                case .failure(let error):
                    let apiError = APIError(networkError: error, statusCode: response.response?.statusCode)
                    resultHandlerCallBack(.failure(apiError))
                }
            }
    }
    
    func addAccount(account: Account) {
        
    }
    
    func updateAccount(account: Account) {
        
    }
    
}
