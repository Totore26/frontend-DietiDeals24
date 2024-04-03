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
            
            HomeView(homeViewModel: HomeViewModel(user: user))
                .tabItem {
                    Image(systemName: "house.fill" )
                    Text("HOME")
                }
                .environmentObject(sessionManager)
            
            MyAuctionsView(myAuctionViewModel: MyAuctionsViewModel(user: user))
                .tabItem {
                    Image(systemName: "eye")
                    Text("MY AUCTIONS")
                }
                .environmentObject(sessionManager)
            
            NotificationView(notificationViewModel: NotificationViewModel(user: user))
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("NOTICE")
                }
                .environmentObject(sessionManager)
                
            ProfileView(viewModel: ProfileViewModel(user: user))
                .tabItem{
                    Image(systemName: "person")
                    Text("PROFILE")
                }
                .environmentObject(sessionManager)
            
            SettingsView(viewModel: SettingsViewModel(user: user))
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

