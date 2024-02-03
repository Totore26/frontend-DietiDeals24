//
//  Auction.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 09/12/23.
//

protocol Auction {
    
    var creator : Seller {get set}
    
    var participants : Array<Buyer>? {get set}
    
    var imageAuction :  String {get set}
    
    var title : String {get set}
    
    var description: String {get set}
    
    var location : String {get set}
    
    var category : String {get set}
    
    
}

