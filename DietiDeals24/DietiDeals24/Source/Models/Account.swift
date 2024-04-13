//
//  Account.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

struct Account: Codable {
    
    var notifications: [Notification]?
    var socialLinks: [SocialLink]?
    var fullName: String
    var imageAccount: String?
    var email: String
    var password: String
    var description: String?
    var telephoneNumber: String
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case notifications, socialLinks, fullName, imageAccount, email, password, description, telephoneNumber, country
    }
    
    // Aggiunto un init personalizzato per inizializzare le proprietà richieste.
    init(fullName: String, email: String, password: String, telephoneNumber: String) {
        self.notifications = nil
        self.socialLinks = nil
        self.fullName = fullName
        self.imageAccount = nil
        self.email = email
        self.password = password
        self.description = nil
        self.telephoneNumber = telephoneNumber
        self.country = nil
    }
    
    // Aggiunte implementazioni dei metodi per la codifica e la decodifica.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        notifications = try container.decodeIfPresent([Notification].self, forKey: .notifications)
        socialLinks = try container.decodeIfPresent([SocialLink].self, forKey: .socialLinks)
        fullName = try container.decode(String.self, forKey: .fullName)
        imageAccount = try container.decodeIfPresent(String.self, forKey: .imageAccount)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        telephoneNumber = try container.decode(String.self, forKey: .telephoneNumber)
        country = try container.decodeIfPresent(String.self, forKey: .country)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(notifications, forKey: .notifications)
        try container.encodeIfPresent(socialLinks, forKey: .socialLinks)
        try container.encode(fullName, forKey: .fullName)
        try container.encodeIfPresent(imageAccount, forKey: .imageAccount)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(telephoneNumber, forKey: .telephoneNumber)
        try container.encodeIfPresent(country, forKey: .country)
    }
}
