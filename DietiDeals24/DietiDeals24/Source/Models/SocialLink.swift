//
//  File.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation

struct SocialLink: Codable {
    
    var accountAssociato: Account
    var link: String
    
    // Aggiunto un enum CodingKeys per personalizzare la codifica e la decodifica delle proprietà.
    enum CodingKeys: String, CodingKey {
        case accountAssociato, link
    }

    // Aggiunte implementazioni dei metodi per la codifica e la decodifica.
    init(accountAssociato: Account, link: String) {
        self.accountAssociato = accountAssociato
        self.link = link
    }

    // Aggiunto init(from:) per la decodifica dei dati
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountAssociato = try container.decode(Account.self, forKey: .accountAssociato)
        link = try container.decode(String.self, forKey: .link)
    }

    // Aggiunto encode(to:) per la codifica dei dati
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountAssociato, forKey: .accountAssociato)
        try container.encode(link, forKey: .link)
    }
}

