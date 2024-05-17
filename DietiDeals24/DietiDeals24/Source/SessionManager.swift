//
//  SessionManager.swift
//  DietiDeals24
//
//  Created by Francesco Terrecuso on 21/02/24.
//

import Amplify
import AWSCognitoAuthPlugin
import Foundation
import AuthenticationServices

enum AuthState {
    case signUp
    case login
    case session(user: AuthUser)
}

class SessionManager : ObservableObject {
    
    @Published var authState : AuthState = .login
    @Published var errorBanner : String? = ""
    @Published var isSellerSession = false

    public func getCurrentAuthUser() async {
        do {
            let user = try await Amplify.Auth.getCurrentUser()
            DispatchQueue.main.async {
                self.authState = .session(user: user)
            }
        } catch {
            DispatchQueue.main.async {
                self.authState = .login
            }
            print("Errore durante il caricamento dell'utente attuale: \(error)")
        }
    }
    
    func showSignUp(){
        DispatchQueue.main.async {
            self.authState = .signUp
        }
    }
    
    func showLogin(){
        DispatchQueue.main.async {
            self.authState = .login
        }
    }
    
    
    func signUp(username: String, password: String, fullName: String, phoneNumber: String) async throws {
        let userAttributes = [
            AuthUserAttribute(.email, value: username),
            AuthUserAttribute(.name, value: fullName),
            AuthUserAttribute(.phoneNumber, value: phoneNumber),
        ]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)

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
    }   

    func login(email: String, password: String) async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: email,
                password: password
                )
            if signInResult.isSignedIn {
                print("Sign in succeeded ... ")
                await self.getCurrentAuthUser()
            }
        } catch let error as AuthError {
            print("Sign in failed: \(self.errorMessage(for: error))")
            DispatchQueue.main.async {
                self.errorBanner = self.errorMessage(for: error)
            }
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
            print("An error occurred while confirming sign up: \(self.errorMessage(for: error))")
            DispatchQueue.main.async {
                self.errorBanner = self.errorMessage(for: error)
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func logOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult else {
            print("Signout failed")
            return
        }
        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult {
            case .complete:
                print("Signed out successfully")
                DispatchQueue.main.async {
                    self.authState = .login
                }
            case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
                if let hostedUIError = hostedUIError {
                    print("HostedUI error: \(hostedUIError)")
                }
                if let globalSignOutError = globalSignOutError {
                    print("GlobalSignOut error: \(globalSignOutError)")
                }
                if let revokeTokenError = revokeTokenError {
                    print("Revoke token error: \(revokeTokenError)")
                }
            case .failed(let error):
                print("SignOut failed with \(error)")
        }
    }
    
    func signInWithGoogle(presentationAnchor: ASPresentationAnchor) async {
        do {
            let signInResult = try await Amplify.Auth.signInWithWebUI(for: .google, presentationAnchor: presentationAnchor)
            if signInResult.isSignedIn {
                print("Sign in succeeded")
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    func signInWithFacebook(presentationAnchor: ASPresentationAnchor) async {
        do {
            let signInResult = try await Amplify.Auth.signInWithWebUI(for: .facebook, presentationAnchor: presentationAnchor)
            if signInResult.isSignedIn {
                print("Sign in succeeded")
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func changePassword(oldPassword: String, newPassword: String) async throws {
        if passwordIsValid(oldPassword: oldPassword, newPassword: newPassword) {
            do {
                try await Amplify.Auth.update(oldPassword: oldPassword, to: newPassword)
                print("Password changed successfully")
            } catch let error as AuthError {
                print("Password change failed: \(self.errorMessage(for: error))")
                throw error
            } catch {
                print("Password change failed: \(error)")
                throw error
            }
        } else {
            throw ValidationError.passwordsNotValid
        }
    }
    
    func passwordIsValid(oldPassword: String, newPassword: String) -> Bool {
        let isPasswordValid1 = (oldPassword.count >= 8 && oldPassword.count <= 16)
        let isPasswordValid2 = (newPassword.count >= 8 && newPassword.count <= 16)
        
        return isPasswordValid1 && isPasswordValid2 && (oldPassword != newPassword)
    }
    
    
    private func errorMessage(for error: AuthError) -> String {
        switch error {
            case .configuration(let errorDescription, _, _):
                return "error: \(errorDescription)"
            case .service(let errorDescription, _, _):
                return "error: \(errorDescription)"
            case .validation(_, let errorDescription, _, _):
                return "error: \(errorDescription)"
            case .notAuthorized(let errorDescription, _, _):
                return "Not authorized: \(errorDescription)"
            case .signedOut(let errorDescription, _, _):
                return "Signed out error: \(errorDescription)"
            case .sessionExpired(let errorDescription, _, _):
                return "Session expired: \(errorDescription)"
            case .invalidState(let errorDescription, _, _):
                return "Invalid state error: \(errorDescription)"
            case .unknown(let errorDescription, _):
                return "Unknown error: \(errorDescription)"
        }
    }
}

public enum ValidationError: Error {
    case passwordsNotValid
}

