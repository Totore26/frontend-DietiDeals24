//
//  Notification.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Alamofire
import Amplify

class NotificationViewModel: ObservableObject {
    
    var api = NotificationRequest()
    let user: AuthUser
    @Published var notifications: [NotificationData] = []
    
    init(user: AuthUser) {
        self.user = user
        fetchBuyerNotifications()
    }
    
    func fetchBuyerNotifications() {
        let username = user.username // Ottieni l'username dell'utente
        api.fetchBuyerNotifications(username: username) { [weak self] (notifications, error) in
            if let notifications = notifications {
                DispatchQueue.main.async {
                    self?.notifications = notifications
                }
            } else if let error = error {
                print("Errore nel recupero delle notifiche: \(error)")
            }
        }
    }
    
    func fetchSellerNotifications() {
        let username = user.username // Ottieni l'username dell'utente
        api.fetchSellerNotifications(username: username) { [weak self] (notifications, error) in
            if let notifications = notifications {
                DispatchQueue.main.async {
                    self?.notifications = notifications
                }
            } else if let error = error {
                print("Errore nel recupero delle notifiche: \(error)")
            }
        }
    }
    
}
