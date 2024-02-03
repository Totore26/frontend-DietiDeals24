//
//  BetAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol BetAPI {
    
    func getAllBets() -> [Bet]
    
    func getBetById(betId: String) -> Bet?
    
    func createBet(bet: Bet)
    
    func getMaxBetForAuction(auctionId: String) -> Bet?
    
}
