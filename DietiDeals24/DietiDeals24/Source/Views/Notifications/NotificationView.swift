//
//  NotificationView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 16/12/23.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var notificationViewModel: NotificationViewModel
    @State private var isRefreshing = false
    @EnvironmentObject var sessionManager : SessionManager

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    NotificationListView(notificationViewModel: notificationViewModel)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .background(
                Color(
                    red: Double(0x90) / 255.0,
                    green: Double(0xC4) / 255.0,
                    blue: Double(0xDA) / 255.0
                )
                .edgesIgnoringSafeArea(.all)
                .clipped()
            )
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("png-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                }
            }
            .refreshable {
                isRefreshing = true
                if(!sessionManager.isSellerSession){
                    notificationViewModel.fetchBuyerNotifications()
                }
                else {
                    notificationViewModel.fetchSellerNotifications()
                }
                isRefreshing = false
            }
        }
    }
}

struct NotificationListView: View {
    @ObservedObject var notificationViewModel: NotificationViewModel

    var body: some View {
        VStack(spacing: 20) {
            if notificationViewModel.notifications.isEmpty {
                Text("You have no notifications.")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                ForEach(notificationViewModel.notifications.indices, id: \.self) { index in
                    NavigationLink(destination: NotificationDetailView()) {
                        NotificationStructures(notification: notificationViewModel.notifications[index])
                            .padding(.bottom, 20)
                    }
                }
            }
        }
    }
}

struct NotificationStructures: View {
    let notification: NotificationData
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy" // Formato data desiderato
        return formatter
    }()

    var body: some View {
        HStack { // Aggiunto spacing tra i componenti
            Image("png-defaultImage")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) { 
                Text(notification.title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(notification.status)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .bold()

                Text(notification.timeOfNotification)
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
    }
}


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
        return NotificationView(notificationViewModel: notificationViewModel)
    }
}

