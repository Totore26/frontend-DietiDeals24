//
//  DietiDeals24XApp.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 07/12/23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin

@main
struct DietiDeals24: App {
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
                    .preferredColorScheme(.light)
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
                    .preferredColorScheme(.light)
            case .session(let user):
                TabBarHomeView(user: user)
                    .environmentObject(sessionManager)
                    .preferredColorScheme(.light)
            }
        }
    }
    
    private func configureAmplify() {
        do{
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
            print("Amplify correctly configured!")
        } catch {
            print("Coud not configure amplify!", error)
        }
    }
}
 
