//
//  SellerRepository.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 04/02/24.
//

//SellerRepository deve implementare tutti i metodi di SellerAPI e deve avere un oggetto che ne esprime la dipendenza

protocol SellerRepository: SellerAPI {
    var sellerAPI: SellerAPI { get }
}

protocol BuyerRepository: BuyerAPI {
    var BuyerAPI: BuyerAPI { get }
}
