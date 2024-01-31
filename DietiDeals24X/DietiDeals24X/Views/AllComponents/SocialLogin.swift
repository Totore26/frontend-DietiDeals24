//
//  
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 08/12/23.
//  Questo file contiene la formattazione ndei bottoni di login per github, google e Apple

import Foundation
import SwiftUI

//View per i 3 bottoni di login with social
struct SocialLoginButtonsView: View {
    var body: some View {
        VStack(spacing: 15) {
            SocialLoginButton(imageName: "png-apple", title: "Login with Apple", backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.97), textColor: .black, action: loginWithAppleAction)
            
            SocialLoginButton(imageName: "png-google", title: "Login with Google", backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.97), textColor: .black, action: loginWithGoogleAction)
            
            SocialLoginButton(imageName: "png-facebook", title: "Login with Facebook", 
                              backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.97), textColor: .black, action: loginWithFacebookbAction)
        }
    }
}

//Implementazione dei login con i social:

func loginWithAppleAction() {
    /// ToDo: Azione per il login con Apple
    print("Login with Apple action")
}

func loginWithGoogleAction() {
    /// ToDo: Azione per il login con Google
    print("Login with Google action")
}

func loginWithFacebookbAction() {
    /// ToDo: Azione per il login con GitHub
    print("Login with GitHub action")
}
