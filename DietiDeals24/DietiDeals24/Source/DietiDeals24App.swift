//
//  DietiDeals24XApp.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 07/12/23.
//

import SwiftUI
import Amplify

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
    
    init(){
        configureAmplify()
    }

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabBarHomeView()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
    
    
    private func configureAmplify() {
        do{
            try Amplify.configure()
            print("Amplify correctly configured!")
        } catch {
            print("Coud not configure amplify!", error)
        }
    }
}
