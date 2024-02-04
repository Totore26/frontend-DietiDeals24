//
//
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 08/12/23.
//  Questo file contiene tutte le strutture d'appoggio usate per la creazione delle View.

import SwiftUI
import Foundation

//------------------------------------------ LOGIN & SIGN UP ---------------------------------------------------------//



//Serve a formattare le caselle per inserire i dati in modo omogeneo.
struct FormattedTextField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        TextField(title, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
            .strokeBorder(Color.gray, lineWidth: 1))
            .padding(.horizontal, 20)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
    }
}

//Serve a formattare le caselle per inserire i dati in modo sicuro.
struct FormattedSecureTextField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        SecureField(title, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
            .strokeBorder(Color.gray, lineWidth: 1))
            .padding(.horizontal, 20)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
    }
}


//Serve a formattare le caselle per inserire i dati in modo numerico.
struct FormattedNumberTextField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        TextField(title, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
            .strokeBorder(Color.gray, lineWidth: 1))
            .padding(.horizontal, 20)
            .keyboardType(.numberPad)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

//Un semplice separatore orizzontale formattato con l aiuto di figma
struct FormattedSeparator: View {
    var body: some View {
        Image("png-linea")
            .frame(width: 300.00665, height: 0)
    }
}




//--------------------------------------------------------------------------------------------------------------------//
