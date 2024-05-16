//
//  SignUpViewModel.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/03/24.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    let api = AuthenticationRequest.singleton
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    @Published var telephoneNumber: String = ""
    @Published var otp: String = ""
    @Published var isConfirmationAlertPresented: Bool = false
    @Published var confirmationMessage: String = ""
    @Published var passwordMatchError: Bool = false
    
    func addUser() {
        api.addUserRequest(
            fullname: fullName,
            email: email,
            telephoneNumber: telephoneNumber
        ) { result in
            switch result {
            case .success:
                print("Utente inserito correttamente nel DB.")
            case .failure(let error):
                print("Errore durante l'inserimento dell'utente nel DB o nella richiesta http: \(error.localizedDescription)")
            }
        }
    }
    
    func checkEmailAndPassword() -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        let isEmailValid = emailPredicate.evaluate(with: email)
        let isPasswordValid = (password.count >= 8 && password.count <= 16)
        
        return isEmailValid && isPasswordValid
    }
    
}
