//
//  MenuView.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 09/12/23.
//

import SwiftUI

struct HomeView: View {
    
    // AccountViewmodel, ListAuctionViewModel().
    @State private var searchText = ""
    @State private var selectedPriceRange: String? = "All"
    @State private var selectedCategory: String? = "All"
    @State private var showCreateAuctionBanner = false
    @State private var selectedAuctionType = FormattedAuctionType.null
    @State private var isSeller = true
    
    let priceRanges = ["All", "5-10 €", "10-20 €", "20-50 €","50-100 €", "100-250 €", "250-500 €", "500-1000 €", "1000-2000 €","2000+ €"]
    let categories = ["All", "Technology", "Sport & Free Time", "Home & Garden", "Vehicle", "Service", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Contenuto della ScrollView
                VStack(spacing: 20) {
                    ForEach(0..<20) { index in
                        NavigationLink(destination: AuctionView()) {
                            AuctionsStructures(
                                imageName: "png-sfondo",
                                title: "Titolo dell'elemento \(index)",
                                subtitle: "Sottotitolo dell'elemento \(index)"
                            )
                        }
                    }
                }//VStack
                .padding(.top, 20)
                .padding(.bottom, 100)
                .navigationBarTitle("Home", displayMode: .inline)
                //Logo
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("png-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    }
                }
                //Create Auction Button
                .navigationBarItems(
                    trailing: Button(
                        action: {
                            showCreateAuctionBanner = true
                        }) {
                            
                            if isSeller { //mostro il bottone creaAsta solo se chi lo vede è un venditore
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                )
                //Alert
                .alert(isPresented: $showCreateAuctionBanner) {
                    Alert(
                        title: Text("Choose Auction Type"),
                        message: Text("Select the type of auction you want to create."),
                        primaryButton: .default(
                            Text("Fixed-time"),
                            action: {
                                selectedAuctionType = .fixed
                            }
                        ),
                        secondaryButton: .default(
                            Text("Incremental"),
                            action: {
                                selectedAuctionType = .incremental
                            }
                        )
                    )
                }
                //SearchBar
                .searchable(text: $searchText) {
                    SearchView(
                        priceRanges: priceRanges,
                        selectedPriceRange: $selectedPriceRange,
                        categories: categories,
                        selectedCategory: $selectedCategory
                    )
                }
                // NavLink per indirizzare i pulsanti del banner alle viste (inutile utilizzare metodi come sheet view e cose varie perche non funzionano)
                NavigationLink(
                    destination: CreateFixedTimeAuctionView(),
                    isActive: Binding(
                        get: { selectedAuctionType == .fixed },
                        set: { newValue in
                            if !newValue {
                                selectedAuctionType = .null
                            }
                        }
                    ),
                    label: EmptyView.init
                )
                NavigationLink(
                    destination: CreateIncrementalAuctionView(),
                    isActive: Binding(
                        get: { selectedAuctionType == .incremental },
                        set: { newValue in
                            if !newValue {
                                selectedAuctionType = .null
                            }
                        }
                    ),
                    label: EmptyView.init
                )
                
            }//ScrollView
            .background(
                Color(
                    red: Double(0x90) / 255.0,
                    green: Double(0xC4) / 255.0,
                    blue: Double(0xDA) / 255.0
                )
                .edgesIgnoringSafeArea(.all)
                .clipped()
            )
        }//NavigationView
    }//body
}




struct AuctionsStructures: View {
    let imageName: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            // Immagine a sinistra
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
                
            //TODO: (viewmodel.asta[0].type == "fixed-time" ) ? end : remining-time
            ///qui si gestisce il timer invece che deve scorrere da solo in funzione del tempo!!
                Text("End: 10h" )
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .bold()
                
                Text("2000€")
                    .font(.subheadline)
                    .foregroundColor(.green)
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



struct SearchView: View {
    
    let priceRanges: [String]
    @Binding var selectedPriceRange: String?
    let categories: [String]
    @Binding var selectedCategory: String?

    var body: some View {
        VStack {
            Text("Scroll to select a price range...")
                .foregroundColor(.gray)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(priceRanges, id: \.self) { range in
                        Button(action: {
                            selectedPriceRange = range
                        }) {
                            Text(range)
                                .padding(8)
                                .background(selectedPriceRange == range ? Color.blue.opacity(0.2) : Color(.systemGray6))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .padding()
            }

            Text("Category...")
                .foregroundColor(.black)
                .font(.title2)
                .padding(.leading, -180)
                .bold()

            ScrollView() {
                VStack(alignment: .leading){
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category)
                                .padding(8)
                                .background(selectedCategory == category ? Color.blue.opacity(0.2) : Color(.systemGray6))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.leading, -185)
                .frame(width: 400)
                .padding()
            }
        }
    }
}


#Preview {
    HomeView()
}




