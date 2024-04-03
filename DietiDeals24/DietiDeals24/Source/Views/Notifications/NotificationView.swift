//
//  NotificationView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 16/12/23.
//

import SwiftUI

struct NotificationView: View {
    
    @ObservedObject var notificationViewModel : NotificationViewModel
    
    @State private var isDetailViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<20) { index in
                            Button(action: {
                                isDetailViewPresented.toggle()
                            }) {
                                    NotificationStructures(
                                        imageName: "png-sfondo",
                                        title: "Titolo della notifica \(index)",
                                        subtitle: "Sottotitolo della notifica \(index)",
                                        timestamp: "2 minuti fa"
                                    )
                                }
                                .sheet(isPresented: $isDetailViewPresented) {
                                    NotificationDetailView()
                                }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
            }
            .navigationBarTitle("Notice", displayMode: .large)
            .background(
                Color(
                    red: Double(0x90) / 255.0,
                    green: Double(0xC4) / 255.0,
                    blue: Double(0xDA) / 255.0
                )
                .edgesIgnoringSafeArea(.all)
                .clipped()
        )
        }
    }
}


struct NotificationStructures: View {
    let imageName: String
    let title: String
    let subtitle: String
    let timestamp: String

    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                    .padding(.trailing, 10)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)


                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .bold()

                    Text(timestamp)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
        }
    }
}



//TODO: DA FARE BENE NEL PACKAGE AUCTIONS
struct NotificationDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Detail")
                .padding()

            Spacer()

            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        let notificationViewModel = NotificationViewModel(user: DummyUser())
        return NotificationView(
            notificationViewModel: notificationViewModel
        )
    }
}
