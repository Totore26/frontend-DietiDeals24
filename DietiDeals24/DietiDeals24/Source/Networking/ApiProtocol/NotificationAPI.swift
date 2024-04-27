//
//  NotificationAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol NotificationAPI {
    
    func fetchNotifications(username: String, completion: @escaping ([NotificationData]?, Error?) -> Void)
    
    func getNotificationById(notificationId: String) -> NotificationData?
    
    func updateAllNotifications(updateFunction: (inout NotificationData) -> Void)
    
}

