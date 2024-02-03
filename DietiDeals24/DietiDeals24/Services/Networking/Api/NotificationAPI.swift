//
//  NotificationAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol NotificationAPI {
    
    func getAllNotifications(accountId: String) -> [Notification]
    
    func getNotificationById(notificationId: String) -> Notification?
    
    func updateAllNotifications(updateFunction: (inout Notification) -> Void)
    
}

