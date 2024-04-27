//
//  AccountRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/02/24.
//

import Alamofire
import Foundation

class AccountRequest: AccountAPI {
    
    var accountType : String = "buyer"
    
    func getInfoBuyerAccountAPI(completion: @escaping (Result<Account, Error>) -> Void, username : String) {
        let url = baseURL.append(path: "account/info/buyer/\(username)")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)"
        ]
        // Effettua la richiesta HTTP utilizzando Alamofire
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Account.self) { response in
                switch response.result {
                case .success(let account):
                    completion(.success(account))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getInfoSellerAccountAPI(completion: @escaping (Result<Account, Error>) -> Void, username : String) {
        let url = baseURL.append(path: "account/info/seller/\(username)")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)"
        ]
        // Effettua la richiesta HTTP utilizzando Alamofire
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Account.self) { response in
                switch response.result {
                case .success(let account):
                    completion(.success(account))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    
    
    func modifyAccountAttributeAPI(json: Data, completion: @escaping (Bool) -> Void) {
        if(SessionManager().isSellerSession){
            self.accountType = "seller"
        }
        
        let url = baseURL.append(path: "account/\(accountType)/modifyAccount")
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        
        AF.request(request)
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
