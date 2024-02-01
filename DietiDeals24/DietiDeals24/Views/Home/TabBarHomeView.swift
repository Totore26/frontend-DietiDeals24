//
//  manageHomesViews.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 10/12/23.
//

import SwiftUI

struct TabBarHomeView: View {
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
        }
    }
}

#Preview {
    TabBarHomeView()
}
