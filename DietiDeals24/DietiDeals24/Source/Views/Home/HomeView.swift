//
//  MenuView.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 09/12/23.
//

import SwiftUI
import Amplify

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @EnvironmentObject var sessionManager : SessionManager
    @State var isSearchViewPresented : Bool = false
    @State private var isRefreshing = false
    
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    let priceRanges = ["All", "5-10 €", "10-20 €", "20-50 €","50-100 €", "100-250 €", "250-500 €", "500-1000 €", "1000-2000 €","2000+ €"]
    let categories = ["All", "Technology", "Sport & Free Time", "Home & Garden", "Vehicle", "Service", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Text("Category: \(homeViewModel.selectedCategory ?? "All")")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        Text("Price Range: \(homeViewModel.selectedPriceRange ?? "All")")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        if !homeViewModel.searchText.isEmpty {
                            Text("Search: \(homeViewModel.searchText)")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                    LazyVStack{
                        ForEach(homeViewModel.auctions.prefix(100), id: \.id) { auction in
                            NavigationLink(destination: AuctionView(viewModel : AuctionViewModel(user: homeViewModel.user.username, auction: auction))
                                .environmentObject(sessionManager)) {
                                    AuctionsStructures (auction: auction)
                                }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.top, 20)
                .padding(.bottom, 100)
                .navigationBarTitle("Home", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("png-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            // Mostra la SearchView quando viene cliccato l'icona del filtro
                            isSearchViewPresented = true
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                        }
                    }
                }
                .navigationBarItems(
                    trailing: Group {
                        if sessionManager.isSellerSession {
                            Button(action: {
                                homeViewModel.showCreateAuctionBanner.toggle()
                            }) {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .bold()
                                    .foregroundColor(.blue)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                )
                .alert(isPresented: $homeViewModel.showCreateAuctionBanner) {
                    Alert(
                        title: Text("Choose Auction Type"),
                        message: Text("Select the type of auction you want to create."),
                        primaryButton: .default(
                            Text("Fixed-time"),
                            action: {
                                homeViewModel.selectedAuctionType = .fixed
                            }
                        ),
                        secondaryButton: .default(
                            Text("Incremental"),
                            action: {
                                homeViewModel.selectedAuctionType = .incremental
                            }
                        )
                    )
                }
                // Naviga alla SearchView quando la variabile di stato isSearchViewPresented è true
                NavigationLink(
                    destination: SearchView(
                        priceRanges: priceRanges,
                        selectedPriceRange: $homeViewModel.selectedPriceRange,
                        categories: categories,
                        selectedCategory: $homeViewModel.selectedCategory,
                        searchText: $homeViewModel.searchText,
                        homeViewModel: homeViewModel,
                        onClose: {
                            // Aggiorna lo stato per chiudere la schermata di ricerca
                            isSearchViewPresented = false
                        }
                    ),
                    isActive: $isSearchViewPresented,
                    label: { EmptyView() }
                )
                NavigationLink(
                    destination: CreateFixedTimeAuctionView(viewModel: CreateFixedTimeAuctionViewModel(user: homeViewModel.user.username)),
                    isActive: Binding(
                        get: { homeViewModel.selectedAuctionType == .fixed },
                        set: { newValue in
                            if !newValue {
                                homeViewModel.selectedAuctionType = .null
                            }
                        }
                    ),
                    label: EmptyView.init
                )
                NavigationLink(
                    destination: CreateIncrementalAuctionView(viewModel: CreateIncrementalAuctionViewModel(user: homeViewModel.user.username)),
                    isActive: Binding(
                        get: { homeViewModel.selectedAuctionType == .incremental },
                        set: { newValue in
                            if !newValue {
                                homeViewModel.selectedAuctionType = .null
                            }
                        }
                    ),
                    label: EmptyView.init
                )
            }
            .refreshable {
                isRefreshing = true
                homeViewModel.getAllAuctions()
                isRefreshing = false
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
        }
    }
}


struct AuctionsStructures: View {
    let auction: AuctionData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(auction.title ?? "N/A")")
                    .font(.headline)
                    .foregroundColor(.black)
                
                if let endOfAuction = auction.endOfAuction {
                    Text("End : \(endOfAuction)")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .bold()
                } else if let timer = auction.timer {
                    Text("Timer : \(timer) h")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .bold()
                }
                
                Text("\(auction.currentPrice ?? 0)€")
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
    @Binding var searchText: String
    @ObservedObject var homeViewModel: HomeViewModel
    var onClose: () -> Void // Funzione per chiudere la schermata

    var body: some View {
        VStack {
            // Barra di ricerca
            HStack {
                TextField("Search...", text: $searchText)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.leading, 10)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }

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
            Button(action: {
                homeViewModel.filterAuctions()
                onClose() // Chiudi la schermata quando viene premuto il pulsante di ricerca
            }) {
                Text("Search")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard, edges: .all)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homeViewModel = HomeViewModel(user: DummyUser())
        return HomeView(homeViewModel: homeViewModel)
    }
}
