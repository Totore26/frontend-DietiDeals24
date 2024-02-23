//
//  DietiDeals24XApp.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 07/12/23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

// TODO: vai nelle classi del viewmodel
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false

    // Singleton instance
    static let shared = AppState()

    // Private initializer to prevent multiple instances
    private init() {}
    
}



@main
struct DietiDeals24: App {
    @StateObject private var appState = AppState.shared
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
    }

    var body: some Scene {
        WindowGroup {
            
            //bisogna passare i vari viewmodel nel caso di sessione.
            switch sessionManager.authState {
            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
            case .session(let user):
                TabBarHomeView(user: user)
                    .environmentObject(sessionManager)
            }
        }
    }
    
    
    private func configureAmplify() {
        do{
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify correctly configured!")
        } catch {
            print("Coud not configure amplify!", error)
        }
    }
}
