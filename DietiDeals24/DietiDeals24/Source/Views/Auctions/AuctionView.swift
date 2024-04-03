//
//  FixedTimeAuctionView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 29/12/23.
//

import SwiftUI

struct AuctionView: View {
    
    @StateObject var viewModel = AuctionViewModel()
    @EnvironmentObject var sessionManager : SessionManager
    
    var body: some View {
        VStack() {
            
            Image("png-logo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            
            ScrollView {
                VStack {
                    
                    Spacer()
                        .frame(height: 20)
                    
                    //MARK: TITOLO E CATEGORIA
                    Text(viewModel.auction.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Category: \(viewModel.auction.category)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    //MARK: IMMAGINE
                    Image(viewModel.auction.imageName)
                        .resizable()
                        .onTapGesture {
                            withAnimation {
                                self.viewModel.isFullScreen.toggle()
                            }
                        }
                        .frame(width: viewModel.isFullScreen ? UIScreen.main.bounds.width : 350,
                               height: viewModel.isFullScreen ? UIScreen.main.bounds.height : 220)
                        .clipped()
                        .cornerRadius(10)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 1000, height: 0)
                    
                    //MARK: attributi dell'asta
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 350, height: 120)
                        .cornerRadius(10)
                        .overlay(
                            AuctionDataSection(viewModel: viewModel)
                        )
                    
                    if sessionManager.isSellerSession {
                        if viewModel.auction.sellerIsYou {
                            if viewModel.auction.auctionType == .fixed {
                                Text("SPECIFIED MINIMUM TRESHOLD:")
                                    .bold()
                                    .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                                Text(viewModel.auction.specifiedMinimumThreshold ?? "")
                                    .bold()
                                    .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                            }
                        }
                    } else {
                        if viewModel.auction.auctionType == .fixed {
                            OfferMoreButton(title: "Offer more", fontSize: 18, action: {
                                viewModel.isShowedOfferSheetView.toggle()
                            })
                            .adaptiveSheet(isPresented: $viewModel.isShowedOfferSheetView, detents: [.medium()], smallestUndimmedDetentIdentifier: .large){
                                CofirmFixedTimeOfferView(offerAmount: $viewModel.offerAmount,
                                                         isShowedOfferSheetView: $viewModel.isShowedOfferSheetView
                                )
                            }
                        } else {
                            OfferMoreButton(title: "Offer +\(viewModel.raisingThreshold)€", fontSize: 18, action: {
                                viewModel.isShowedOfferSheetView.toggle()
                            })
                            .adaptiveSheet(isPresented: $viewModel.isShowedOfferSheetView, detents: [.medium()], smallestUndimmedDetentIdentifier: .large){
                                ConfirmIncrementalOfferView(raisingThreshold: $viewModel.raisingThreshold, 
                                                            currentOffer: $viewModel.currentOffer,
                                                            isShowedOfferSheetView: $viewModel.isShowedOfferSheetView
                                )
                            }
                        }
                    }
                    
                    Text("Description: ")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.trailing, 250)
                    Text(viewModel.auction.description)
                        .padding(.horizontal, 330)
                        .padding(.leading, -40)
                    
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 350, height: 80)
                        .cornerRadius(10)
                        .overlay(
                            VStack {
                                Text("Seller:")
                                    .bold()
                                    .padding(.trailing,280)
                                
                                if viewModel.auction.sellerIsYou {
                                    Text("YOU")
                                        .bold()
                                        .padding(.trailing,290)
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                else {
                                    Button(action: {
                                        // Action per visualizzare il profilo del venditore
                                    }) {
                                        Text(viewModel.auction.sellerName)
                                            .bold()
                                            .padding(.trailing,175)
                                            .foregroundColor(.black.opacity(0.5))
                                            .underline()
                                    }
                                }
                            }
                        )
                        .padding(.bottom, 70)
                }//VStack
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
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $viewModel.isFullScreen) {
                // Contenuto a schermo intero
                FullScreenImageView(imageName: viewModel.auction.imageName, isFullScreen: $viewModel.isFullScreen)
            }
        }
    }
}

struct FullScreenImageView: View {
    let imageName: String
    @Binding var isFullScreen: Bool

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                withAnimation {
                    self.isFullScreen.toggle()
                }
            }
    }
}

struct CofirmFixedTimeOfferView: View {
    @Binding var offerAmount: String
    @Binding var isShowedOfferSheetView: Bool

    var body: some View {
        VStack {
            TextField("Enter your offer", text: $offerAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            OfferMoreButton(title: "Confirm", fontSize: 18, action: {
                isShowedOfferSheetView.toggle()
            })

            Spacer().frame(height: 5)

            CancelButton(title: "Cancel", fontSize: 16, action: {
                isShowedOfferSheetView.toggle()
            })
        }
    }
}

struct ConfirmIncrementalOfferView: View {
    @Binding var raisingThreshold: Float
    @Binding var currentOffer: Float
    @Binding var isShowedOfferSheetView: Bool

    var body: some View {
        VStack {
            HStack {
                Text("\(raisingThreshold+currentOffer, specifier: "%.2f") €")
                    .font(.title)
                    .padding()
            }

            OfferMoreButton(title: "Confirm", fontSize: 18, action: {
                //MARK: chiama la funzione del viewModel corrispondente.
                isShowedOfferSheetView.toggle()
            })

            Spacer().frame(height: 5)

            CancelButton(title: "Cancel", fontSize: 16, action: {
                isShowedOfferSheetView.toggle()
            })
        }
    }
}


struct FixedTimeAuctionView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionView()
    }
}


struct AuctionDataSection: View {
    @ObservedObject var viewModel: AuctionViewModel
    
    var body: some View {
        VStack {
            if viewModel.auction.auctionType == .fixed { // Asta fixed
                HStack {
                    Text("End of the auction:")
                        .bold()
                    Text(viewModel.auction.endTime) // Attributo dell'asta
                        .bold()
                        .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                        .padding(.trailing, 83)
                }
            } else { // Asta incrementale
                HStack {
                    Text("Time to bet:")
                        .bold()
                    Text("0d 4h 0m") // Attributo dell'asta
                        .bold()
                        .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                }
                .padding(.trailing, 150)
            }
            
            HStack {
                Text("Current Offer:")
                    .bold()
                Text(viewModel.auction.currentOffer) // Attributo dell'asta
                    .bold()
                    .foregroundColor(Color(red: 51/255, green: 204/255, blue: 153/255))
            }.padding(.trailing, 143)
            
            if viewModel.auction.auctionType == .fixed { // Attributo dell'asta
                HStack {
                    Text("Type of Auction:")
                        .bold()
                    Text("Fixed-Time")
                        .bold()
                }.padding(.trailing, 100)
            } else {
                HStack {
                    Text("Type of Auction:")
                        .bold()
                    Text("English")
                        .bold()
                }.padding(.trailing, 130)
            }
            
            HStack {
                Text("Location:")
                    .bold()
                Text(viewModel.auction.location) // Attributo dell'asta
                    .bold()
            }.padding(.trailing, 180)
            
        }
    }
}


