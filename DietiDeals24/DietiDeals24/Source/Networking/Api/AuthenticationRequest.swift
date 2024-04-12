import Alamofire
import Foundation

class AuthenticationRequest: AuthenticationAPI {
    
    static let singleton = AuthenticationRequest()
    var url: String = ""

    private init() {
    }

    func addUserRequest(fullname: String, email: String, telephoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        url = baseURL.append(path: "account/user")
        let parameters: [String: Any] = [
            "fullname": fullname,
            "email": email,
            "telephoneNumber": telephoneNumber
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

     
    func getTokenRequest(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL.append(path: "auth/login")
        let parameters = ["email": email,
                          "fullname": "",
                          "telephoneNumber": ""
                        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let tokenResponse):
                    autenticationToken = tokenResponse
                    print("\n\n \(autenticationToken) \n\n")
                    completion(.success(()))
                        
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }


    
    
    
    
    
}
