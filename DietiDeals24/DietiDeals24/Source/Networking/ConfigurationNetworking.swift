//
//  ConfigurationNetworking.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 03/02/24.
//

import Alamofire

struct baseURL {
    static let baseURL = "https://localhost:8080/"
    
    static func append(path: String) -> String {
        return baseURL + path
    }
}

struct APIError: Error {
    
    let networkError: AFError
    
    let statusCode: Int?
    
}

/*
    esempio utilizzo:
    
    var CustomURL = baseURL.append(path: "auctions")
 
    AF.request(baseURL.append(path: "/auctions"), method: .get)       <---- credo sia meglio cosi piu diretto e capibile
 
 
 ACCOUNT:
 
 GET /api/accounts/{accountId}: Ottiene i dettagli di un account specifico.
 POST /api/accounts: Crea un nuovo account.
 PUT /api/accounts/{accountId}: Modifica un account esistente.
 
 SELLER:
 
 GET /api/sellers/{accountId}/auctions: Ottiene l'elenco delle aste generate da un venditore.
 
 BUYER:
 
 GET /api/buyers/{accountId}/followed-auctions: Ottiene l'elenco delle aste seguite da un acquirente.
 
 AUCTION:
 
 GET /api/auctions: Ottiene l'elenco delle aste correntemente attive.
 GET /api/auctions/{auctionId}: Ottiene i dettagli di un'asta specifica.
 POST /api/auctions: Crea una nuova asta.
 PUT /api/auctions/{auctionId}: Modifica un'asta esistente.
 
 SOCIAL LINK:
 
 GET /api/social-links/{accountId}: Ottiene l'elenco dei link social di un account.
 POST /api/social-links/{accountId}: Aggiunge un nuovo link sociale all'account.
 PUT /api/social-links/{accountId}/{oldLink}: Modifica un link sociale esistente dell'account.

 NOTIFICATION:
 
 GET /api/notifications/{accountId}: Ottiene l'elenco di tutte le notifiche di un account.
 GET /api/notifications/{notificationId}: Ottiene i dettagli di una notifica specifica.
 PUT /api/notifications: Aggiorna tutte le notifiche dell'account.

 BET:
 
 GET /api/bets/{auctionId}: Ottiene l'elenco delle puntate di un'asta.
 
 
 */

