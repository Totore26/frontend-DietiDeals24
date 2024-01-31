//
//  Buffer.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 10/12/23.
//

import SwiftUI

struct TabViewManagment: View {
    @State private var searchText = ""

    var body: some View {
        

            // Barra inferiore con quattro bottoni
            
            TabView {
                HomeView()
                .tabItem {
                    Label("Bottone 1", systemImage: "1.circle")
                }
                
                
                Text("Contenuto 2")
                    .tabItem {
                        Label("Bottone 2", systemImage: "2.circle")
                    }

                Text("Contenuto 3")
                    .tabItem {
                        Label("Bottone 3", systemImage: "3.circle")
                    }

                Text("Contenuto 4")
                    .tabItem {
                        Label("Bottone 4", systemImage: "4.circle")
                    }
            }
            .padding(.bottom, 30)
            
    }
}

#Preview {
    TabViewManagment()
}

