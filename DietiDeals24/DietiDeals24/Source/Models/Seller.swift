//
//  Seller.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

class Seller: Account, Codable {

    var notifications: Array<Notification>?
    var socialLinks: Array<SocialLink>?
    var auctionGenerated: Array<Auction>?
    var fullName: String
    var imageAccount: String?
    var email: String
    var password: String
    var description: String?
    var telephoneNumber: String
    var country: String?

    enum CodingKeys: String, CodingKey {
        case notifications
        case socialLinks
        case auctionGenerated
        case fullName
        case imageAccount
        case email
        case password
        case description
        case telephoneNumber
        case country
    }

    init(fullName: String, imageAccount: String? = nil, email: String, password: String, description: String? = nil, telephoneNumber: String, country: String? = nil) {
        self.fullName = fullName
        self.imageAccount = imageAccount
        self.email = email
        self.password = password
        self.description = description
        self.telephoneNumber = telephoneNumber
        self.country = country
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
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

            try container.encode(fullName, forKey: .fullName)
            try container.encodeIfPresent(imageAccount, forKey: .imageAccount)
            try container.encode(email, forKey: .email)
            try container.encode(password, forKey: .password)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encode(telephoneNumber, forKey: .telephoneNumber)
            try container.encodeIfPresent(country, forKey: .country)
        }
}

