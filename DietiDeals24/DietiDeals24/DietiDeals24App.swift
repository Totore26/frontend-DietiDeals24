//
//  DietiDeals24XApp.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 07/12/23.
//

import SwiftUI

// TODO: vai nelle classi del viewmodel
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = true

    // Singleton instance
    static let shared = AppState()

    // Private initializer to prevent multiple instances
    private init() {}
    
}



@main
struct DietiDeals24: App {
    @StateObject private var appState = AppState.shared

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
}
