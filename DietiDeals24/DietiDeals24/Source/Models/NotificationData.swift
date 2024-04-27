//
//  Notification.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

struct NotificationData: Codable {
    
    var accountAssociato: AccountAssociated
    var timeOfNotification: String
    var status: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case accountAssociato = "accountAssociated"
        case date, status, title
    }

    init(accountAssociato: AccountAssociated, date: String, status: String, title: String) {
        self.accountAssociato = accountAssociato
        self.timeOfNotification = date
        self.status = status
        self.title = title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountAssociato = try container.decode(AccountAssociated.self, forKey: .accountAssociato)
        timeOfNotification = try container.decode(String.self, forKey: .date)
        status = try container.decode(String.self, forKey: .status)
        title = try container.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountAssociato, forKey: .accountAssociato)
        try container.encode(timeOfNotification, forKey: .date)
        try container.encode(status, forKey: .status)
        try container.encode(title, forKey: .title)
    }
}

struct AccountAssociated: Codable {
    var email: String
    var socialLinks: [String]
}


