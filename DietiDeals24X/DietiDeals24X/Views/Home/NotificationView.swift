//
//  NotificationView.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 14/12/23.
//

import SwiftUI

struct NotificationView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                // SFONDO
                Image("png-sfondo")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .rotationEffect(.degrees(-180))
                    .frame(width: 650, height: 875)
                    .padding(.top, 210)

                VStack {
                    List {
                        ForEach(0..<15) { index in
                            NavigationLink(destination: self) {
                                NotificationStructures(
                                    title: "Titolo dell'elemento",
                                    subtitle: "Sottotitolo dell'elemento"
                                )
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                            }
                            .padding(.bottom, -7)
                        }
                    }
                    .padding(.bottom, 220)
                    .frame(width: 370)
                    .listRowSpacing(5)
                    .listStyle(PlainListStyle())
                    .cornerRadius(10)
                }
                .padding(.top, 230)
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("png-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .searchable(text: $searchText)
    }
}

struct NotificationStructures: View {
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            // Titolo e sottotitolo
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .bold()
                
                Text("Congratulation, you won the auction!")
                    .font(.system(size: 12))
                    .foregroundColor(.green)
                    .bold()
            }
            .padding(.leading, 10)
            Spacer()

            // Tempo trascorso dalla notifica
            Text("1h")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 5)
        }
        .cornerRadius(10)
        .padding(10)
        .background(Color.white)
    }
}


#Preview {
    NotificationView()
}
