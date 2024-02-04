//
//  MyAuctionView.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 10/12/23.
//

import SwiftUI

struct MyAuctionsView: View {
    
    //TODO: AccountViewmodel, ListAuctionViewModel().
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                VStack(spacing: 20) {
                    ForEach(0..<20) { index in
                        
                        //TODO: Inserisco i dati dell'asta specifica per creare l'oggetto ViewAuctions,
                        ///mentre come imageName, title e subtitle gli passo gli attributi.
                        NavigationLink(destination: self) {
                            MyAuctionsStructures(
                                  imageName: "png-sfondo",
                                  title: "Titolo dell'elemento \(index)",
                                  subtitle: "Sottotitolo dell'elemento \(index)"
                            )
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 100)
            }
            
            .background(
                    Color(
                        red: Double(0x90) / 255.0,
                        green: Double(0xC4) / 255.0,
                        blue: Double(0xDA) / 255.0
                    )
                    .edgesIgnoringSafeArea(.all)
                    .clipped()
            )
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("png-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                }
                
                
            }
            .navigationBarItems(
                trailing: Button(action: {
                    
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .bold()
                    
                    //TODO: INSERIRE IL TIPO DI UTENTE PER AGGIUNGERE O MENO IL BOTTONE PER CREARE L'ASTA
                } .foregroundColor((true) ? .black : .clear)
                
            )
            

            .searchable(text: $searchText)
        }
    }
}



// TODO: Gestisce cosa mostrare a seconda se è buyer o seller!!
struct MyAuctionsStructures: View {
    let imageName: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            
            // Immagine
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .padding(.trailing, 10)

            // Titolo e sottotitolo
            VStack(alignment: .leading, spacing: 4) {
                Text("\(title)")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("Auction close" )
                    .font(.headline)
                    .foregroundColor(.gray)
                    .bold()
                
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}



#Preview {
    MyAuctionsView()
}
