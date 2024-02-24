//
//  manageHomesViews.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 10/12/23.
//

import SwiftUI
import Amplify
struct TabBarHomeView: View {
    
    let user : AuthUser
    @EnvironmentObject var sessionManager: SessionManager
    
    
    /* 
     TODO: la struct AuthUser specifica l'id del client e la sua mail.
      siccome ci possono essere al piu una mail per due account, cio che dobbiamo tener
     in considerazione è l'id che genera AWS COGNITO; In altre parole quando vengono fatte le richieste http,
     per i dati per ognuna view, bisogna mettere all'inizio della richiesta GET user.ID / ... / ... /
    */
    
    var body: some View {
        TabView{
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill" )
                    Text("HOME")
                }
            
            MyAuctionsView()
                .tabItem {
                    Image(systemName: "eye")
                    Text("MY AUCTIONS")
                }
            
            NotificationView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("NOTICE")
                }
                
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("PROFILE")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("SETTINGS")
                }
                .environmentObject(sessionManager)
        }
    }
}

struct TabBarHomeView_Preview: PreviewProvider {
    struct DummyUser: AuthUser {
        var userId: String = "1"
        var username: String = "dummy"
    }

    static var previews: some View {
        TabBarHomeView(user: DummyUser())
            .environmentObject(SessionManager())
    }
}

