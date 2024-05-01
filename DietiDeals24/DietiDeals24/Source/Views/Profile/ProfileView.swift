//
//  ProfileView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 15/12/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @State private var isRefreshing = false
    @State private var isEditProfileSheetPresented = false

    var body: some View {
        NavigationView {
            ScrollView {
                ProfileStructure(viewModel: viewModel)
                    .padding(.top, 30)
            }
            .background(Color(red: 0x90 / 255.0, green: 0xC4 / 255.0, blue: 0xDA / 255.0)
                .edgesIgnoringSafeArea(.all)
                .clipped()
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                HStack {
                    if viewModel.isPersonalProfile() { // Show the edit button only if the viewer is the owner
                        Button(action: {
                            isEditProfileSheetPresented.toggle()
                        }) {
                            Image(systemName: "pencil.and.outline")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .bold()
                        }
                        .foregroundColor(.black)
                        .sheet(isPresented: $isEditProfileSheetPresented) {
                            EditProfileSheetView(viewModel: viewModel).environmentObject(sessionManager)
                                .onDisappear {
                                    viewModel.getInfoBuyerAccount(username: viewModel.user)
                                }
                        }                    }
                }
            )
            .navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("png-logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.leading, 60)
                }
            }
            .refreshable {
                isRefreshing = true
                if(!sessionManager.isSellerSession){
                    viewModel.getInfoBuyerAccount(username: viewModel.user)
                }
                else{
                    viewModel.getInfoSellerAccount(username: viewModel.user)
                }
            }
        }
    }
}
 


struct ProfileStructure: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            FullnamePhotoNazionalityProfile(viewModel: viewModel)
            DescriptionsProfile(viewModel: viewModel)
            LinksProfile(viewModel: viewModel)
            FormattedSeparator().padding()
            ContactsButtons(viewModel: viewModel)
        }
    }
}

struct FullnamePhotoNazionalityProfile: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
                .padding()
            
            VStack(alignment: .center) {
                Text(viewModel.account?.fullName ?? "")
                    .font(.title2)
                    .bold()
                    .font(Font.custom("SF Pro", size: 20))
                    .padding()
                
                Text(viewModel.account?.country ?? "")
            }
        }
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .frame(width: 460, height: 100)
        .padding(.top, 20)
    }
}

struct DescriptionsProfile: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            Text("Description:")
                .font(Font.custom("SF Compact", size: 22))
                .bold()
                .foregroundColor(.black)
                .padding(.trailing, 260)
                .padding(.top, 20)
            
            Text(viewModel.account?.description ?? "")
                .multilineTextAlignment(.leading)
                .font(Font.custom("SF Compact", size: 16))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                .frame(width: 393)
                .padding(.leading, 10)
        }
        .padding(.bottom, 30)
    }
}

struct ContactsButtons: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                if let phoneNumber = viewModel.account?.telephoneNumber,
                   let phoneURL = URL(string: "tel://\(phoneNumber)") {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                }
            }) {
                ZStack {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
            
            Button(action: {
                // Apri il compositore di posta elettronica
                if let email = viewModel.account?.email,
                   let emailURL = URL(string: "mailto:\(email)") {
                    if UIApplication.shared.canOpenURL(emailURL) {
                        UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                    }
                }
            }) {
                ZStack {
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
        }
        .frame(width: 150, alignment: .center)
        .padding(.horizontal, 50)
        .padding(.top, 10)
        .padding(.bottom, 30)
    }
}

struct LinksProfile: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            if let link1 = viewModel.account?.socialLinks?.first?.link {
                Button(action: {
                    if let url = URL(string: link1) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Visit social 1")
                        .font(Font.custom("SF Compact", size: 18))
                        .lineSpacing(22)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 250, height: 40)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.white))
                }
                .padding(6)
            }
            
            if let link2 = viewModel.account?.socialLinks?.dropFirst().first?.link {
                Button(action: {
                    if let url = URL(string: link2) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Visit social 2")
                        .font(Font.custom("SF Compact", size: 18))
                        .lineSpacing(22)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 250, height: 40)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.white))
                }
                .padding(6)
            }
        }
    }
}

