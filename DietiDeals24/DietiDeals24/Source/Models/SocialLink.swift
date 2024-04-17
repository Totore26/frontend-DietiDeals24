//
//  File.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//
import Foundation

struct SocialLink: Codable {
    var link: String?

    enum CodingKeys: String, CodingKey {
        case link
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        link = try container.decodeIfPresent(String.self, forKey: .link)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(link, forKey: .link)
    }
}

