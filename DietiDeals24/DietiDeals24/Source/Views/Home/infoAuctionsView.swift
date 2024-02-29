//
//  infoAuctions.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 19/12/23.
//

import SwiftUI

struct Auctions {
    let type: String
    let description: String
}

struct InfoAuctionsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let auctions: [Auctions] = [
        Auctions(
            type: "Fixed-Time Auction",
            description: "In a fixed-time auction, a seller can set a deadline and a secret minimum threshold for the product. Buyers can view the current highest bid but are unaware of the minimum threshold. They can submit competitive bids until the deadline. The buyer with the highest bid at the deadline wins the item or service. If the minimum threshold is not reached, the auction is considered failed, and both the seller and buyers receive a notification."
        ),
        Auctions(
            type: "English Auction",
            description: "In an English auction, a seller sets a public initial price, a fixed time interval for submitting new bids (default is 1 hour), and a bidding increment threshold (default is €10. Buyers can bid for the current price. Each time a bid is placed, the timer for new bids is reset. If no new bid is made before the timer reaches zero, the last bidder wins the item or service. Both the seller and buyers receive a notification of the auction's conclusion."
        )
    ]

    var body: some View {
        NavigationView {
            VStack {
                
                Text("Informations")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                List(auctions, id: \.type) { auction in
                    NavigationLink(destination: AuctionDetailsView(auction: auction)) {
                        Text(auction.type)
                    }
                }

                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
        }
    }
}

struct AuctionDetailsView: View {
    let auction: Auctions
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(auction.description)
                .multilineTextAlignment(.leading)
                .padding()

            Spacer()

            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .navigationTitle(auction.type)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoAuctionsView_Previews: PreviewProvider {
    static var previews: some View {
        InfoAuctionsView()
    }
}
