//
//  SocialLinkAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol SocialLinkAPI {
    
    func getSocialLinks(accountId: String) -> [SocialLink]
    
    func addSocialLink(accountId: String, link: String)
    
    func updateSocialLink(accountId: String, oldLink: String, newLink: String)
    
}
