//
//  AccountRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/02/24.
//

import Alamofire
import Foundation

class AccountRequest: AccountAPI {
    
    
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
    
    
    
    
    func modifyAccountAttributeAPI(json: Data, completion: @escaping (Result<Account, Error>) -> Void) {
        let url = baseURL.append(path: "account/buyer/modifyAccount")
        
        do {
            guard let parameters = try JSONSerialization.jsonObject(with: json, options: []) as? Parameters else {
                print("Non è possibile convertire i dati JSON in Parameters")
                return
            }
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(authToken)",
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate()
                .responseDecodable(of: Account.self) { response in
                    switch response.result {
                    case .success(let account):
                        completion(.success(account))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        } catch {
            print("Errore durante la serializzazione dei dati JSON: \(error.localizedDescription)")
        }
    }
    
}
