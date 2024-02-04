//
//  NotificationRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

class NotificationRequest: NotificationAPI {
    
    func getAllNotifications(accountId: String) -> [Notification] {
        return []
    }
    
    func getNotificationById(notificationId: String) -> Notification? {
        return nil
    }
    
    func updateAllNotifications(updateFunction: (inout Notification) -> Void) {
        
    }
}
