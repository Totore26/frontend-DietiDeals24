//
//  Notification.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

struct Notification: Codable {
    
    var accountAssociato: Account
    var imageNotification: String
    var title: String
    var status: String
    var timeOfNotification: Date
    
    // Aggiunto un enum CodingKeys per personalizzare la codifica e la decodifica delle proprietà.
    enum CodingKeys: String, CodingKey {
        case accountAssociato, imageNotification, title, status, timeOfNotification
    }

    // Aggiunte implementazioni dei metodi per la codifica e la decodifica.
    init(accountAssociato: Account, imageNotification: String, title: String, status: String, timeOfNotification: Date) {
        self.accountAssociato = accountAssociato
        self.imageNotification = imageNotification
        self.title = title
        self.status = status
        self.timeOfNotification = timeOfNotification
    }

    // Aggiunto init(from:) per la decodifica dei dati
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountAssociato = try container.decode(Account.self, forKey: .accountAssociato)
        imageNotification = try container.decode(String.self, forKey: .imageNotification)
        title = try container.decode(String.self, forKey: .title)
        status = try container.decode(String.self, forKey: .status)
        timeOfNotification = try container.decode(Date.self, forKey: .timeOfNotification)
    }

    // Aggiunto encode(to:) per la codifica dei dati
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountAssociato, forKey: .accountAssociato)
        try container.encode(imageNotification, forKey: .imageNotification)
        try container.encode(title, forKey: .title)
        try container.encode(status, forKey: .status)
        try container.encode(timeOfNotification, forKey: .timeOfNotification)
    }
}


