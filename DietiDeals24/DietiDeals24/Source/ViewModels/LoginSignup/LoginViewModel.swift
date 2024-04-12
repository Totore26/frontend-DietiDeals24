//
//  LoginViewModel.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/04/24.
//
import Foundation

class LoginViewModel: ObservableObject {
    
    let api = AuthenticationRequest.singleton
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorBanner: String = ""
    
    
    
    func getToken() {
        api.getTokenRequest(
            email: email
        ) { result in
            switch result {
            case .success:
                print("Token ricevuto correttamente.")
            case .failure(let error):
                print("\n\nErrore durante la richiesta del token: \n\n\(error.localizedDescription)")
            }
        }
    }

}
