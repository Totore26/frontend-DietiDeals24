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
    
    var body: some View {
        TabView{
            /*
                homeViewModel <--> dipendenza dalle aste
                MyAuctionViewModel <--> le mie aste
                notificationViewModel <--> le mie notifiche
                ProfileViewModel <--> le mie info
                SettingsViewModel <--> Auth
            */
            
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
            .environmentObject(SessionManager()) // Assicurati di fornire un oggetto di sessione nell'ambiente
    }
}

