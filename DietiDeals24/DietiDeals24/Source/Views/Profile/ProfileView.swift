//
//  ProfileView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 15/12/23.
//

import SwiftUI


struct ProfileView: View {
    
    
    @ObservedObject var viewModel : ProfileViewModel
    @EnvironmentObject var sessionManager : SessionManager
    
    init(viewModel: ProfileViewModel ) {
        self.viewModel = viewModel
    }
    
    
    @State var isEditProfileSheetPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ProfileStructure(viewModel: viewModel)
                    .padding(.top, 30)
            }
            .background(Color(
                       red: Double(0x90) / 255.0,
                       green: Double(0xC4) / 255.0,
                       blue: Double(0xDA) / 255.0
                   )
                .edgesIgnoringSafeArea(.all)
                .clipped()
            )
           .navigationBarTitleDisplayMode(.inline)
           .navigationBarItems(trailing:
                HStack {
               if (viewModel.isPersonalProfile()) { //mostro il tasto di modifica solo se chi lo vede è il proprietario
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
                           EditProfileSheetView().environmentObject(sessionManager)
                       }
                   }
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
        }
    }
}



struct ProfileStructure: View {
    var viewModel : ProfileViewModel
    
    var body: some View {
        VStack {
            
            FullnamePhotoNazionalityProfile(viewModel : viewModel)
            
            DescriptionsProfile(viewModel : viewModel)
            
            //TODO: la logica per aprire l'url va messa nel viewmodel
            LinksProfile(viewModel : viewModel)
            
            FormattedSeparator().padding()
            //TODO: gestire il click sul viewmodel
            ContactsButtons(viewModel : viewModel)
        }
    }
}



struct FullnamePhotoNazionalityProfile: View {
    var viewModel : ProfileViewModel
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
                .padding()
            
            VStack(alignment: .center) {
                Text("\(viewModel.fullName)")
                    .font(.title2)
                    .bold()
                    .font(Font.custom("SF Pro", size: 20))
                    .padding()
                
                Text("\(viewModel.country)")
                
            }
            
        }
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .frame(width: 460, height: 100)
        .padding(.top, 20)

    }
}


struct DescriptionsProfile: View {
    
    var viewModel : ProfileViewModel
    var body: some View {
        VStack {
            Text("Description:")
                .font(Font.custom("SF Compact", size: 22))
                .bold()
                .foregroundColor(.black)
                .padding(.trailing, 260)
                .padding(.top, 20)
            
            Text("\(viewModel.description)")
                .multilineTextAlignment(.leading)
                .font(Font.custom("SF Compact", size: 16))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                .frame(width: 393)
        }
        .padding(.bottom, 30)
    }
}


struct ContactsButtons: View {
    var viewModel : ProfileViewModel
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                if let phoneURL = URL(string: "tel://\(viewModel.phoneNumber)") {
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
                if let emailURL = URL(string: "\(viewModel.email)") {
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
    var viewModel : ProfileViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                // TODO: Inserisci la logica nel viewmodel
                if let url = URL(string: "\(viewModel.link1)") {
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

            Button(action: {
                // TODO: Inserisci la logica nel viewmodel
                if let url = URL(string: "\(viewModel.link2)") {
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


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel(user : DummyUser())
        return ProfileView(viewModel: viewModel)
    }
}


