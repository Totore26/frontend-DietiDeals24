//
//  BetRequest.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

import Alamofire

class BetRequest: BetAPI {
    
    func getAllBets() -> [Bet] {
        return []
    }
    
    func getBetById(betId: String) -> Bet? {
        return nil
    }
    
    func createBet(bet: Bet) {
        
    }
    
    func getMaxBetForAuction(auctionId: String) -> Bet? {
        return nil
    }
    
}
