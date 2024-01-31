//
//  Notification.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

class Notification {

    private(set) var accountAssociato: Account
    
    private(set) var imageNotification : String
    
    private(set) var title: String
    
    private(set) var status: String
    
    private(set) var timeOfNotification: Date

    init(accountAssociato: Account, imageNotification: String, title: String, status: String, timeOfNotification: Date) {
        self.accountAssociato = accountAssociato
        self.imageNotification = imageNotification
        self.title = title
        self.status = status
        self.timeOfNotification = timeOfNotification
    }
}

