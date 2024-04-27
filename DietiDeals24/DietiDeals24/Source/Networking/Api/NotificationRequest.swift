//
//  NotificationRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

class NotificationRequest: NotificationAPI {
    
    var accountType : String = "buyer"
    

    func fetchNotifications(username: String, completion: @escaping ([NotificationData]?, Error?) -> Void) {
        
        if(SessionManager().isSellerSession){
            self.accountType = "seller"
        }
        
        let url = baseURL.append(path: "notification/\(username)/\(accountType)")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: [NotificationData].self) { response in
            switch response.result {
            case .success(let notifications):
                completion(notifications, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getNotificationById(notificationId: String) -> NotificationData? {
        return nil
    }
    
    func updateAllNotifications(updateFunction: (inout NotificationData) -> Void) {
        
    }
}
