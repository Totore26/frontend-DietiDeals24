//
//  LoginViewModel.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 09/12/23.
//
import Foundation
import Alamofire
import Combine

//ALL IN ONE PER ORA ( DA SISTEMARE UNA VOLTA CAPITO COME FARE TUTTI I LOGIN )

//VIEWMODEL
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogged = false
    @Published var error = ""
    
    private var cancellables: Set<AnyCancellable> = []
    private let authService = AuthService()  // Crea una istanza del tuo servizio di autenticazione

    func login() {
        let credentials = UserCredentials(email: email, password: password)

        authService.login(credentials: credentials)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break  // Gestisci eventuali logiche aggiuntive in caso di completamento
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            } receiveValue: { isLoggedIn in
                self.isLogged = isLoggedIn
            }
            .store(in: &cancellables)
    }
}

//SERVIZIO DI AUTENTICAZIONE
class AuthService {
    //ritorna un Publisher, che è un booleano in caso di successo o un errore in caso di fallimento
    func login(credentials: UserCredentials) -> AnyPublisher<Bool, Error> {
        let url = "http://localhost:8080/auth/login" // Sostituisci con il tuo URL effettivo
        
        //DataResponse è il tipo di ritorno dalla request, convertito in Future (è un Publisher final) e poi in Publisher con il modificatore
        //DataResponse (UpCast) -> Future (UpCast) -> AnyPublisher, è il tipo effettivo ritornato
        return Future<Bool, Error> { promise in

            AF.request(url, method: .post, parameters: credentials, encoder: JSONParameterEncoder.default)
                .validate(statusCode: 200..<300)
                .response { response in
                    switch response.result {
                    case .success:
                        promise(.success(true))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}

//MODEL DELLA RISPOSTA
struct YourResponseModel: Codable {
    let versione: String
    let stato: String
    let lunghezzaMessaggio: Int
    let corpo: String?
}


//MODEL
struct UserCredentials: Codable {
    let email: String
    let password: String
}

