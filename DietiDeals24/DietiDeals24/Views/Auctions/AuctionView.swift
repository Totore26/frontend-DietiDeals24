//
//  FixedTimeAuctionView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 29/12/23.
//

import SwiftUI

struct AuctionView: View {
    
    @State private var isFullScreen = false
    @State private var isSeller = false
    @State private var isPersonalSellerAuction = false
    @State private var auctionType = FormattedAuctionType.incremental
    @State private var isShowedOfferSheetView = false
    @State private var isShowedSellerProfileSheetView = false
    @State private var offerAmount: String = ""
    @State var raisingThreshold: Float = 10
    @State var currentOffer: Float = 100
    
    
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
                    
                    Text("VM Name")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.trailing, 220)
                    
                    
                    // Immagine cliccabile
                    Image("png-defaultImage")
                        .resizable()
                        .onTapGesture {
                            withAnimation {
                                self.isFullScreen.toggle()
                            }
                        }
                        .frame(width: isFullScreen ? UIScreen.main.bounds.width : 350,
                               height: isFullScreen ? UIScreen.main.bounds.height : 220)
                        .clipped()
                        .cornerRadius(10)
                    
                    //rettangolo invisibile per far funzionare lo sfondo
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 1000, height: 0)
                     
                    Text("Category: " + String("VM Category"))
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing, 110)
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 350, height: 120)
                        .cornerRadius(10)
                        .overlay(
                            AuctionDataSection(auctionType: $auctionType)
                        )
                    
                    if isSeller {
                            if isPersonalSellerAuction && auctionType == FormattedAuctionType.fixed {
                                //caso in cui l'asta è del venditore che la vede e di tipo fixed mostro la soglia segreta
                                
                                Text("SPECIFIED MINIMUM TRESHOLD:")
                                    .bold()
                                    .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                                Text(" 30,000.00€")
                                    .bold()
                                    .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                            } else {
                                //caso in cui il venditore è uno qualsiasi o l asta non è fixed non mostro nulla
                            }
                    } else {
                        //caso in cui sono un compratore visualizzo il bottone offer more
                        
                        //se è fixed
                        if auctionType == FormattedAuctionType.fixed {
                            OfferMoreButton(title: "Offer more", fontSize: 18, action: {
                                //OfferMoreAction
                                isShowedOfferSheetView.toggle()
                            })
                            .adaptiveSheet(isPresented: $isShowedOfferSheetView, detents: [.medium()], smallestUndimmedDetentIdentifier: .large){
                                CofirmFixedTimeOfferView(offerAmount: $offerAmount, isShowedOfferSheetView: $isShowedOfferSheetView)
                            }
                        //se è english
                        } else {
                            OfferMoreButton(title: "Offer +" + "10€" , fontSize: 18, action: {
                                //OfferMoreAction
                                isShowedOfferSheetView.toggle()
                            })
                            .adaptiveSheet(isPresented: $isShowedOfferSheetView, detents: [.medium()], smallestUndimmedDetentIdentifier: .large){
                                ConfirmIncrementalOfferView(raisingThreshold: $raisingThreshold, currentOffer: $currentOffer, isShowedOfferSheetView: $isShowedOfferSheetView)
                            }
                        }
                    }
                    
                    Text("Description: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing, 220)
                    Text("""
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, diam sit amet lacinia lacinia, nisl enim aliquam diam, ut faucibus odio ante nec sem. Cras quis nunc et nisl venenatis ultrices. Nulla facilisi. Donec vitae eros sed leo ultricies aliquet. Sed sed semper magna. Sed sed mauris vel ipsum ultricies pharetra. Vivamus in dolor at lacus aliquam ultrices. Donec auctor, nisl quis aliquam luctus, magna quam tincidunt mauris, sit amet volutpat quam magna quis lectus. Sed auctor, nisl quis aliquam luctus, magna quam tincidunt mauris, sit amet volutpat quam magna quis lectus.
                        """)
                    .padding(.horizontal, 330)
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 350, height: 80)
                        .cornerRadius(10)
                        .overlay(
                            VStack {
                                Text("Seller:")
                                    .bold()
                                    .padding(.trailing,280)
                                
                                if isPersonalSellerAuction {
                                    Text("YOU")
                                        .bold()
                                        .padding(.trailing,290)
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                else {
                                    Button(action: {
                                        isShowedSellerProfileSheetView.toggle()
                                    }) {
                                        Text("Giampiero Esposito")
                                            .bold()
                                            .padding(.trailing,175)
                                            .foregroundColor(.black.opacity(0.5))
                                            .underline()
                                    }
                                    .sheet(isPresented: $isShowedSellerProfileSheetView) {
                                        // Contenuto dello sheet del profilo del venditore
                                        ProfileView()
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
            .fullScreenCover(isPresented: $isFullScreen) {
                // Contenuto a schermo intero
                FullScreenImageView(imageName: "png-defaultImage", isFullScreen: $isFullScreen)
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
    @Binding var auctionType: FormattedAuctionType
    var body: some View {
        VStack {
            if auctionType == FormattedAuctionType.fixed { //asta fixed
                HStack {
                    Text("End of the auction:")
                        .bold()
                    Text("2d 4h 37m")
                        .bold()
                        .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                        .padding(.trailing, 83)
                }
            } else { //Asta incrementale
                HStack {
                    Text("Time to bet:")
                        .bold()
                    Text("0d 4h 0m")
                        .bold()
                        .foregroundColor(Color(red: 195/255, green: 0/255, blue: 0/255))
                }
                .padding(.trailing, 150)
            }
            
            HStack {
                Text("Current Offer:")
                    .bold()
                Text("100,00€")
                    .bold()
                    .foregroundColor(Color(red: 51/255, green: 204/255, blue: 153/255))
            }.padding(.trailing, 160)
            
            if auctionType == FormattedAuctionType.fixed {
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
                Text("London")
                    .bold()
            }.padding(.trailing, 180)
            
        }
    }
}
