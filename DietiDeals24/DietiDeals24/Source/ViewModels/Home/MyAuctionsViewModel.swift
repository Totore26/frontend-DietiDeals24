//
//  MyAuctions.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Amplify

class MyAuctionsViewModel: ObservableObject {
    
    let api = AuctionRequest()
    
    var myAuctions = [AuctionData]()
    let user: AuthUser
    
    init(user: AuthUser) {
        self.user = user
        getMyAuctionBuyer(username: user.username)
    }
    
        
    
    func getMyAuctionBuyer(username: String) {
        api.getMyAuctionBuyerAPI(completion: { result in
            switch result {
            case .success(let auctions):
                DispatchQueue.main.async { [weak self] in
                    self?.myAuctions = auctions
                }
                print("\nmy auctions buyer recuperate con successo:")
            case .failure(let error):
                print("Errore nel recupero di my auyctions buyer : \(error)")
            }
        }, username: username)
    }
    
    
    
    func getMyAuctionSeller(username: String) {
        api.getMyAuctionSellerAPI(completion: { result in
            switch result {
            case .success(let auctions):
                DispatchQueue.main.async { [weak self] in
                    self?.myAuctions = auctions
                }
                print("\nmy auctions seller recuperate con successo:")
            case .failure(let error):
                print("Errore nel recupero di my auctions seller : \(error)")
            }
        }, username: username)
    }
    
}
