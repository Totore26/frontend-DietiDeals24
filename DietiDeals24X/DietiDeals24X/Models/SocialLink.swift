//
//  File.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation


class SocialLink {
    
    private(set) var accountAssociato: Account
    
    private(set) var link : String
    
    init(accountAssociato: Account, link: String) {
        self.accountAssociato = accountAssociato
        self.link = link
    }
    
}
