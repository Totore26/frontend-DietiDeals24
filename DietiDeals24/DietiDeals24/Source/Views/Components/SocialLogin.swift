//
//  
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 08/12/23.
//  Questo file contiene la formattazione ndei bottoni di login per github, google e Apple

import Foundation
import SwiftUI

//View per i 3 bottoni di login with social
// View per i 3 bottoni di login con social

struct SocialLoginButtonsView: View {
    var presentationAnchor: UIWindow? // Utilizziamo ASPresentationAnchor come parametro
    
    var body: some View {
        VStack(spacing: 15) {
            SocialLoginButton(imageName: "png-apple", title: "Login with Apple", backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.97), textColor: .black, action: {})
            
            SocialLoginButton(imageName: "png-google", title: "Login with Google", backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.97), textColor: .black) {
                if let anchor = presentationAnchor {
                    Task{
                        await SessionManager().signInWithGoogle(presentationAnchor: anchor)
                    }
                }
            }
            
            SocialLoginButton(imageName: "png-facebook", title: "Login with Facebook", backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.97), textColor: .black) {
                if let anchor = presentationAnchor {
                    Task{
                        await SessionManager().signInWithFacebook(presentationAnchor: anchor)
                    }
                }
            }
        }
    }
}
