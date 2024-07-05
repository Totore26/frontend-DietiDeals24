//
//  FixedTimeAuctionView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 29/12/23.
//

import SwiftUI

struct AuctionView: View {
    
    @ObservedObject var viewModel: AuctionViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    init(viewModel: AuctionViewModel) {
        self.viewModel = viewModel
        
        Task {
            //MARK: ATTIVA LA RIGA PER INIZIARE A SCARICARE LE FOTO DELLE ASTE
            //MARK: ATTIVA LA RIGA PER INIZIARE A SCARICARE LE FOTO DELLE ASTE
            //MARK: ATTIVA LA RIGA PER INIZIARE A SCARICARE LE FOTO DELLE ASTE
            //try fetchAuctionPhoto(auctionID: viewModel.auction.id!)
        }
    }
    
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
                    Text(viewModel.auction.title ?? "N/A")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Category: \(viewModel.auction.category ?? "N/A")")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    //MARK: IMMAGINE
                    if let photo = photoMap[viewModel.auction.id!] {
                        Image(uiImage: photo)
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
                    } else {
                        Image("png-defaultImage")
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
                    }
                    
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
                        if viewModel.sellerIsYou() {
                            if viewModel.auction.minimumSecretThreshold != nil {
                                Text("SPECIFIED MINIMUM TRESHOLD:")
                                    .bold()
                                    .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                                Text("\(viewModel.auction.minimumSecretThreshold ?? 0)")
                                    .bold()
                                    .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                            }
                        }
                    } else {
                        if viewModel.auction.endOfAuction != nil {
                            OfferMoreButton(title: "Offer more", fontSize: 18, action: {
                                viewModel.isShowedOfferSheetView.toggle()
                            })
                            .adaptiveSheet(isPresented: $viewModel.isShowedOfferSheetView, detents: [.medium()], smallestUndimmedDetentIdentifier: .large){
                                CofirmFixedTimeOfferView(viewModel: viewModel)
                            }
                        } else {
                            OfferMoreButton(title: "Offer +\(viewModel.auction.raisingThreshold ?? 0)€", fontSize: 18, action: {
                                viewModel.isShowedOfferSheetView.toggle()
                            })
                            .adaptiveSheet(isPresented: $viewModel.isShowedOfferSheetView, detents: [.medium()], smallestUndimmedDetentIdentifier: .large){
                                ConfirmIncrementalOfferView(viewModel: viewModel)
                            }
                        }
                    }
                    
                    Text("Description: ")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.trailing, 250)
                    Text(viewModel.auction.description ?? "")
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
                                    .padding(.trailing, 280)
                                
                                if viewModel.sellerIsYou() {
                                    Text("YOU")
                                        .bold()
                                        .padding(.trailing, 290)
                                        .foregroundColor(.black.opacity(0.5))
                                } else {
                                    // MARK: - DA METTERE IL PROFILO DEL SELLER!!!!
                                    NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user: viewModel.auction.creator.email ,
                                        isSellerSession: sessionManager.isSellerSession, modifyAccount: false)).environmentObject(sessionManager)){
                                        Text(viewModel.auction.creator.email)
                                            .bold()
                                            .padding(.trailing, 160)
                                            .foregroundColor(.black.opacity(0.5))
                                            .underline()
                                            .fixedSize()
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
                FullScreenImageView(auctionID: viewModel.auction.id!, isFullScreen: $viewModel.isFullScreen)
            }
        }
    }
}


struct FullScreenImageView: View {
    let auctionID: String
    @Binding var isFullScreen: Bool
    
    var body: some View {
        if let image = photoMap[auctionID] {
            Image(uiImage: image)
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
        } else {
            Image("png-defaultImage")
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
    
    init(auctionID: String, isFullScreen: Binding<Bool>) {
        self.auctionID = auctionID
        self._isFullScreen = isFullScreen
    }
}


struct CofirmFixedTimeOfferView: View {
    @ObservedObject var viewModel: AuctionViewModel

    var body: some View {
        VStack {
            TextField("Enter your offer", text: $viewModel.offerAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            OfferMoreButton(title: "Confirm", fontSize: 18, action: {
                guard let offerAmount = Decimal(string: viewModel.offerAmount) else { return }
                viewModel.makeBet(finalOffer: offerAmount) { success in
                    if success {
                        viewModel.isShowedOfferSheetView.toggle()
                    } else {
                        // qui si dovrebbe attivare la variabile per mostrare un banner...
                    }
                }
            })

            Spacer().frame(height: 5)

            CancelButton(title: "Cancel", fontSize: 16, action: {
                viewModel.isShowedOfferSheetView.toggle()
            })
        }
    }
}

struct ConfirmIncrementalOfferView: View {

    @ObservedObject var viewModel: AuctionViewModel
    
    var body: some View {
        VStack {
            HStack {
                if let raisingThreshold = viewModel.auction.raisingThreshold {
                    let currentPrice = viewModel.auction.currentPrice ?? Decimal(0.0)
                    let total = raisingThreshold + currentPrice
                    Text("\(NSDecimalNumber(decimal: total).doubleValue, specifier: "%.2f") €")
                        .font(.title)
                        .padding()
                } else {
                    Text("N/A")
                        .font(.title)
                        .padding()
                }
            }

            OfferMoreButton(title: "Confirm", fontSize: 18, action: {
                // Ottieni i valori di raisingThreshold e currentPrice come Decimal.
                let raisingThreshold = viewModel.auction.raisingThreshold ?? Decimal(0.0)
                let currentPrice = viewModel.auction.currentPrice ?? Decimal(0.0)
                
                // Calcola finalOffer come NSDecimalNumber.
                let finalOffer = NSDecimalNumber(decimal: raisingThreshold + currentPrice)
                
                // Chiama la funzione del viewModel corrispondente.
                viewModel.makeBet(finalOffer: finalOffer as Decimal) { success in
                    if success {
                        viewModel.isShowedOfferSheetView.toggle()
                    }
                }
            })

            Spacer().frame(height: 5)

            CancelButton(title: "Cancel", fontSize: 16, action: {
                viewModel.isShowedOfferSheetView.toggle()
            })
        }
    }
}




struct AuctionDataSection: View {
    @ObservedObject var viewModel: AuctionViewModel
    
    var body: some View {
        VStack {
            if viewModel.auction.endOfAuction != nil { // Asta fixed
                HStack {
                    Text("End :")
                        .bold()
                    Text(viewModel.auction.endOfAuction ?? "N/A") // Attributo dell'asta
                        .bold()
                        .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                    Spacer() // Spinge verso sinistra
                }.padding(.leading)
            } else { // Asta incrementale
                HStack {
                    Text("Time to bet:")
                        .bold()
                    Text("\(viewModel.auction.timer ?? 0) h") // Attributo dell'asta
                        .bold()
                        .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                    Spacer() // Spinge verso sinistra
                }.padding(.leading)
            }
            
            HStack {
                Text("Current Offer:")
                    .bold()
                Text("\(viewModel.auction.currentPrice ?? 0) € ") // Attributo dell'asta
                    .bold()
                    .foregroundColor(Color(red: 51/255, green: 204/255, blue: 153/255))
                Spacer() // Spinge verso sinistra
            }.padding(.leading)
            
            if viewModel.auction.endOfAuction != nil { // Attributo dell'asta
                HStack {
                    Text("Type of Auction:")
                        .bold()
                    Text("Fixed-Time")
                        .bold()
                    Spacer() // Spinge verso sinistra
                }.padding(.leading)
            } else {
                HStack {
                    Text("Type of Auction:")
                        .bold()
                    Text("English")
                        .bold()
                    Spacer() // Spinge verso sinistra
                }.padding(.leading)
            }
            
            HStack {
                Text("Location:")
                    .bold()
                Text(viewModel.auction.location ?? "not available") // Attributo dell'asta
                    .bold()
                Spacer() // Spinge verso sinistra
            }.padding(.leading)
        }
    }
}


