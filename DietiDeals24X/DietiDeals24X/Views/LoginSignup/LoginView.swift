//
//  ContentView.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 07/12/23.
//


import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ScrollView() {
                
                Image("png-logo")
                    .resizable()
                    .frame(width: 240.90546, height: 70.02985, alignment: .center)
                    .padding( .top, 40)
                
                FormattedSeparator()
                .padding(.bottom, 40)
                
                
                VStack(spacing: 10) {
                    
                    FormattedTextField(title: "Email", text: $email)
                    FormattedSecureTextField(title: "Password", text: $password)
                    
                    
                    NavigationLink("Did you forget your password?",destination: self)
                        .font(
                            Font.custom("SF Pro", size: 12)
                            .weight(.light)
                        )
                        .underline()
                        .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                        .frame(maxWidth: 300, alignment: .leading)
                        .padding(.bottom, 40)
                }
                
                
                LoginButton(
                    title: "Continue!",
                    fontSize: 22,
                    action: {
                        //TODO: Implementa la logica del login
                        print("Continue button tapped")
                        
                        }
                    )
                    
                FormattedSeparator()
                    .padding(.bottom, 15)
                
                SocialLoginButtonsView()
                
                NavigationLink("Don't have an account? SignUp!", destination: SignUpView())
                    .font(.caption)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        /*TODO: inseriscilo nel view model corrispondente
        .onTapGesture {
                   UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // Chiudi la tastiera quando si tocca sullo schermo (MAGICO)
               }
         questo metodo fa buggare un paio di cose
         */
    }
}




#Preview {
    LoginView()
}
