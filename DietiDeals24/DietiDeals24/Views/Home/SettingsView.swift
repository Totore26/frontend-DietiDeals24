//
//  SettingsView2.0.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 18/12/23.
//

import SwiftUI



struct SettingsView: View {
    
    @State private var isEditProfileSheetPresented = false
    @State private var isInfoAuctionsSheetPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0x90 / 255.0, green: 0xC4 / 255.0, blue: 0xDA / 255.0)
                    .edgesIgnoringSafeArea(.all)
                    .clipped()
                
                VStack {
                    List {
                        // Edit Profile
                        Section {
                            SettingsItem(systemName: "pencil.and.outline", title: "Edit Your Profile")
                                .onTapGesture {
                                    isEditProfileSheetPresented.toggle()
                                }
                                .listRowBackground(Color.white)
                                .sheet(isPresented: $isEditProfileSheetPresented) {
                                    EditProfileSheetView()
                                }
                        }
                        // Info Auctions
                        Section {
                            SettingsItem(systemName: "i.circle", title: "Info Auctions")
                                .onTapGesture {
                                    isInfoAuctionsSheetPresented.toggle()
                                }
                                .listRowBackground(Color.white)
                                .sheet(isPresented: $isInfoAuctionsSheetPresented) {
                                    InfoAuctionsView()
                                    Spacer()
                                }
                        }
                        // LogOut
                        Section {
                            SettingsItem(systemName: "rectangle.portrait.and.arrow.forward", title: "Logout")
                                .onTapGesture {
                                    //TODO: aggiungere la chiamata al viewmodel che cancella dalla memoria i dati dell'utente loggato.
                                    //appState.isLoggedIn = false

                                }
                        }
                    }
                    .frame(width: 350, height: 250)
                    .listRowSpacing(5)
                    .listStyle(PlainListStyle())
                    .cornerRadius(10)
                    
                }
                .scrollDisabled(true)
                .frame(width: .infinity, height: .infinity)
                .navigationBarTitle("Settings", displayMode: .large)
                .navigationBarTitleDisplayMode(.inline)
                .padding(.bottom, 300)
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

#Preview {
    SettingsView()
}
