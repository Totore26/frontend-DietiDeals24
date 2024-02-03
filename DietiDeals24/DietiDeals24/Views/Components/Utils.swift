//
//  Utils.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

// VARI DATI UTILI PER IL PACKAGE VIEW

//tipi di utente
enum FormattedUserType: String, CaseIterable {
    case buyer = "Buyer"
    case seller = "Seller"
}

//tipi di aste diverse
enum FormattedAuctionType: String, CaseIterable {
    case fixed = "fixed time"
    case incremental = "incremental"
    case null = ""
}

