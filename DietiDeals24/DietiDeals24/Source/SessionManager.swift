//
//  SessionManager.swift
//  DietiDeals24
//
//  Created by Francesco Terrecuso on 21/02/24.
//

import Amplify
import Foundation


enum AuthState {
    case signUp
    case login
    case session(user: AuthUser)
}


class SessionManager : ObservableObject {
    @Published var authState : AuthState = .login
    
    
    /*
        La seguente funzione serve a controllare se l'utente attuale è loggato, nel caso in cui lo sui mostra
        la sessione dell'utente, altrimenti se l'utente non è loggato mostra la schermata di login.
    */
    public func getCurrentAuthUser() async throws {
        do{
            let user = try await Amplify.Auth.getCurrentUser()
            authState = .session(user: user)
        } catch {
            print("errore durante caricamento ... \(error) ")
            authState = .login
        }
    }
    
    func showSignUp(){
        authState = .signUp
    }
    
    func showLogin(){
        authState = .login
    }
    
    
    func signUp(username: String, password: String, email: String, fullName: String, phoneNumber: String, userType: FormattedUserType) async {
        let userTypeAttribute = AuthUserAttribute(.custom("userType"), value: userType.rawValue)
        let userAttributes = [
            AuthUserAttribute(.email, value: email),
            AuthUserAttribute(.name, value: fullName),
            AuthUserAttribute(.phoneNumber, value: phoneNumber),
            userTypeAttribute
        ]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)

        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )

            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
            } else {
                print("SignUp Complete")
            }

        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    
    
    func login(email: String, password: String) async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: email,
                password: password
                )
            if signInResult.isSignedIn {
                print("Sign in succeeded")
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    
    func confirmSignUp(for username: String, with confirmationCode: String) async {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    
}
