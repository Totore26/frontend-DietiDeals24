//
//  NotificationRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

class NotificationRequest: NotificationAPI {
    
    var accountType : String = "buyer"
    

    func fetchBuyerNotifications(username: String, completion: @escaping ([NotificationData]?, Error?) -> Void) {
        
        let url = baseURL.append(path: "notification/buyer/\(accountType)")
        
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
    
    func fetchSellerNotifications(username: String, completion: @escaping ([NotificationData]?, Error?) -> Void) {
        
        let url = baseURL.append(path: "notification/seller/\(accountType)")
        
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
