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
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    let priceRanges = ["All", "5-10 €", "10-20 €", "20-50 €","50-100 €", "100-250 €", "250-500 €", "500-1000 €", "1000-2000 €","2000+ €"]
    let categories = ["All", "Technology", "Sport & Free Time", "Home & Garden", "Vehicle", "Service", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<20) { index in
                        NavigationLink(destination: AuctionView().environmentObject(sessionManager)) {
                            AuctionsStructures (
                                imageName: nil,
                                title: "Titolo dell'elemento \(index)",
                                subtitle: "Sottotitolo dell'elemento \(index)"
                            )
                        }
                    }
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
                }
                .navigationBarItems(
                    trailing: Button(action: {
                        homeViewModel.showCreateAuctionBanner.toggle()
                    }) {
                        if (sessionManager.isSellerSession) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .bold()
                                .foregroundColor(.black)
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
                .searchable(text: $homeViewModel.searchText) {
                    SearchView (
                        priceRanges: priceRanges,
                        selectedPriceRange: $homeViewModel.selectedPriceRange,
                        categories: categories,
                        selectedCategory: $homeViewModel.selectedCategory,
                        searchText: $homeViewModel.searchText,
                        homeViewModel: homeViewModel
                    )
                }
                NavigationLink(
                    destination: CreateFixedTimeAuctionView(),
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
                    destination: CreateIncrementalAuctionView(),
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
    let imageName: UIImage?
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            if let image = imageName {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
            } else {
                // Immagine predefinita quando imageName è nil
                Image("png-defaultImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(title)")
                    .font(.headline)
                    .foregroundColor(.black)
                
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
    @Binding var searchText: String
    @ObservedObject var homeViewModel: HomeViewModel

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
            .onSubmit {
                _ = homeViewModel.searchAuctions (
                    category: selectedCategory ?? "All",
                    princeRange: selectedPriceRange ?? "All",
                    searchText: searchText
                )
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homeViewModel = HomeViewModel(user: DummyUser())
        return HomeView(homeViewModel: homeViewModel)
    }
}
