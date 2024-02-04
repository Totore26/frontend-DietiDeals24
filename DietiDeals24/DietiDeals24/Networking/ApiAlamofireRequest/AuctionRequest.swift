//
//  AuctionRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

class AuctionRequest: AuctionAPI {
    
    func getAllActiveAuctions() -> [Auction] {
        return []
    }
    
    func getAuctionById(auctionId: String) -> Auction? {
        return nil
    }
    
    func createAuction(auction: Auction) {
        
    }
    
    func updateAuction(auction: Auction) {
        
    }
    
}
/*
 GET /api/auctions: Ottiene l'elenco delle aste correntemente attive.
 GET /api/auctions/{auctionId}: Ottiene i dettagli di un'asta specifica.
 POST /api/auctions: Crea una nuova asta.
 PUT /api/auctions/{auctionId}: Modifica un'asta esistente.
 DELETE /api/auctions/{auctionId}: Cancella un'asta.
*/

 
 
