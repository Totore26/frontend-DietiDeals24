//
//  CreateIncrementalAuction.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import SwiftUI

class CreateIncrementalAuctionViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var startingPrice: Float = 0.0
    @Published var raisingThreshold: Float = 10.0
    @Published var timer: Int = 1
    @Published var selectedCategory: String = "All"
    @Published var auctionImage: Image? = nil
    
    func createIncrementalAuction() {}
    
}
