//
//  AuthenticationAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

import Foundation


protocol AuthenticationAPI {
    
    func addUserRequest(fullname: String, email: String, telephoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void)
    
}
