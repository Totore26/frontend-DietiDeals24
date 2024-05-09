//
//  SettingsView2.0.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 18/12/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @State private var prove = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0x90 / 255.0, green: 0xC4 / 255.0, blue: 0xDA / 255.0)
                    .edgesIgnoringSafeArea(.all)
                    .clipped()
                
                VStack {
                    List {
                        Section {
                            SettingsItem(systemName: "pencil.and.outline", title: "Edit Your Profile")
                                .onTapGesture { viewModel.isEditProfileSheetPresented.toggle() }
                                .listRowBackground(Color.white)
                                .sheet(isPresented: $viewModel.isEditProfileSheetPresented) {
                                    EditProfileSheetView(viewModel: profileViewModel)
                                }
                        }
                        Section {
                            SettingsItem(systemName: "i.circle", title: "Info Auctions")
                                .onTapGesture { viewModel.isInfoAuctionsSheetPresented.toggle() }
                                .listRowBackground(Color.white)
                                .sheet(isPresented: $viewModel.isInfoAuctionsSheetPresented) {
                                    InfoAuctionsView()
                                    Spacer()
                                }
                        }
                        Section {
                            SettingsItem(systemName: "rectangle.portrait.and.arrow.forward", title: "Logout")
                                .onTapGesture {
                                    Task {
                                        await sessionManager.logOutLocally()
                                    }
                                }
                        }
                    }
                    .frame(width: 350, height: 250)
                    .listRowSpacing(5)
                    .listStyle(PlainListStyle())
                    .cornerRadius(10)
                    
                    VStack {
                        //TODO: cambiare prove con sessionManager.isBuyerSession
                        Toggle(isOn: $sessionManager.isSellerSession) {
                            Text("Switch to Seller Account")
                                .font(Font.custom("SF Pro", size: 17))
                                .foregroundColor(.black)
                                .padding()
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        .padding(.horizontal, 30)
                        .onChange(of: sessionManager.isSellerSession) { newValue in
                            if newValue {
                                viewModel.upgradeAccount(email: viewModel.user.username)
                            }
                        }
                        
                        // Spiegazione per passare all'account venditore
                        Text("Activate the Seller Premium Account to access exclusive features and enhance your selling experience.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    .padding()
                    
                    if viewModel.isLoading {
                        ProgressView() // Visualizza la rotellina di caricamento quando isLoading è true
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Nascondi l'indicatore dopo 5 secondi
                                    viewModel.isLoading = false
                                }
                            }
                    }
                }
                .scrollDisabled(true)
                .navigationBarTitle("Settings", displayMode: .large)
                .navigationBarTitleDisplayMode(.inline)
                .padding(.bottom, 200)
            }
        }
        .onChange(of: prove) { newValue in
            viewModel.isLoading = true // Mostra la rotellina di caricamento quando il valore del toggle cambia
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Nascondi l'indicatore dopo 5 secondi
                viewModel.isLoading = false
            }
        }
    }
}

struct SettingsItem: View {
    var systemName: String
    var title: String

    var body: some View {
        HStack {
            Image(systemName: systemName)
                .resizable()
                .scaledToFill()
                .frame(width: 26, height: 26)
            Text(title)
                .font(Font.custom("SF Pro", size: 17))
                .lineSpacing(22)
                .foregroundColor(.black)
                .padding()
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundColor(.gray)
        }
        .padding(.bottom, 10)
    }
}
