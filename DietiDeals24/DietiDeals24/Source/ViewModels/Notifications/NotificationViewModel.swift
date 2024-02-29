//
//  Notification.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Amplify

class NotificationViewModel: ObservableObject {
    let user: AuthUser
    
    init(user: AuthUser) {
        self.user = user
    }
    
    // Qui potresti aggiungere altre logiche e proprietà specifiche del ViewModel per la vista Notification
}
