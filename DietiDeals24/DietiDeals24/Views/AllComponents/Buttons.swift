//
//  login:signupButton.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 08/12/23.
//

import Foundation
import SwiftUI

//------------------------------------------ LOGIN & SIGN UP ---------------------------------------------------------//

//bottone per Login e SignUp
struct LoginButton: View {
    var title: String
    var fontSize: CGFloat
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("SF Pro", size: fontSize))
                .bold()
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .frame(width: 300, height: 44, alignment: .center)
                .background(Color(red: 0.06, green: 0.45, blue: 0.64))
                .cornerRadius(14)
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
    }
}

struct OfferMoreButton: View {
    var title: String
    var fontSize: CGFloat
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("SF Pro", size: fontSize))
                .bold()
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .frame(width: 350, height: 44, alignment: .center)
                .background(Color(red: 51/255, green: 204/255, blue: 153/255))
                .cornerRadius(14)
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
    }
}

struct CancelButton: View {
    var title: String
    var fontSize: CGFloat
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("SF Pro", size: fontSize))
                .bold()
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .frame(width: 250, height: 44, alignment: .center)
                .background(Color(red: 195/255, green: 0/255, blue: 0/255))
                .cornerRadius(14)
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
    }
}


// bottone login con Social
struct SocialLoginButton: View {
    let imageName: String
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)

                Text(title)
                    .font(Font.custom("SF Pro", size: 18))
                    .bold()
                    .font(.headline)
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 6)
            .padding(.horizontal, 30)
            .background(backgroundColor)
            .cornerRadius(100)
            .frame(width: 262, height: 34, alignment: .center)
        }
    }
}


//--------------------------------------------------------------------------------------------------------------------//
