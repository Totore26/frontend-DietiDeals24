//
//  MyAuctionView.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 10/12/23.
//

import SwiftUI

struct MyAuctionsView: View {
    
    @ObservedObject var myAuctionViewModel: MyAuctionsViewModel
    @State private var searchText = ""
    @EnvironmentObject var sessionManager : SessionManager
    @State private var isRefreshing = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    if myAuctionViewModel.myAuctions.isEmpty {
                        Text("You are not following any auctions.")
                            .foregroundColor(.gray)
                            .italic()
                            .padding()
                    }
                    
                    
                    LazyVStack{
                        ForEach(myAuctionViewModel.myAuctions.prefix(8), id: \.id) { myAuction in
                            NavigationLink(destination: AuctionView(
                                viewModel: AuctionViewModel(user: myAuctionViewModel.user.username , auction: myAuction)
                            )) {
                                AuctionsStructures(auction : myAuction)
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
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
            .searchable(text: $searchText)
        }
        .refreshable {
            isRefreshing = true
            if(!sessionManager.isSellerSession){
                myAuctionViewModel.getMyAuctionBuyer(username: myAuctionViewModel.user.username)
            }
            else{
                myAuctionViewModel.getMyAuctionSeller(username: myAuctionViewModel.user.username)
            }
            isRefreshing = false
        }
    }
}


struct MyAuctionsView_Previews: PreviewProvider {
    static var previews: some View {
        let myAuctionViewModel = MyAuctionsViewModel(user: DummyUser())
        return MyAuctionsView(myAuctionViewModel: myAuctionViewModel)
    }
}
