
//
//  manageHomesViews.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 10/11/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            ScrollView() {
                Image("png-logo")
                    .resizable()
                    .frame(width: 240.90546, height: 70.02985, alignment: .center)
                    .padding(.top, 40)

                FormattedSeparator()
                    .padding(.bottom, 40)

                VStack(spacing: 10) {
                    FormattedTextField(title: "Email", text: $email)
                    FormattedSecureTextField(title: "Password", text: $password)

                    NavigationLink("Did you forget your password?", destination: Text("Forgot Password")) // Aggiungi la destinazione corretta
                        .font(
                            Font.custom("SF Pro", size: 12)
                                .weight(.light)
                        )
                        .underline()
                        .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                        .frame(maxWidth: 300, alignment: .leading)
                        .padding(.bottom, 40)
                    
                    //gestione dell'errore
                    if let errorBanner = sessionManager.errorBanner {
                        Text(errorBanner)
                            .foregroundColor(.red)
                            .bold()
                    }
                }

                Button {
                    Task {
                        await sessionManager.logOutLocally()
                        await sessionManager.login(email: email, password: password)
                    }
                } label: {
                    Text("Login")
                        .font(.custom("SF Pro", size: 22))
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .frame(width: 300, height: 44, alignment: .center)
                        .background(Color(red: 0.06, green: 0.45, blue: 0.64))
                        .cornerRadius(14)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }
                .disabled(email.isEmpty || password.isEmpty)

                FormattedSeparator()
                    .padding(.bottom, 15)
                
                SocialLoginButtonsView(presentationAnchor: UIApplication.shared.windows.first)

                NavigationLink("Don't have an account? SignUp!", destination: SignUpView())
                    .font(.caption)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .simultaneousGesture(TapGesture().onEnded {
                        sessionManager.errorBanner = ""
                    })

                
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
