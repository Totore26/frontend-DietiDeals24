//
//  PhotoManager.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 09/03/24.
//

import Foundation
import SwiftUI
import Amplify
import UIKit

//per le aste utilizzo l id dell asta come nome dell immagine, cosi posso recuperarla facilmente
//per l'account invece ho pensato di utilizzare sempre l'id/mail e aggiungere una lettera finale per capire se ci riferiamo a buyer o seller (visto che nel dabatase sono 2 profili diversi)
//key = "user/\(userId)" + "b.jpg" per i compratori
//key = "user/\(userId)" + "s.jpg" per i venditori

var photoMap:[String: UIImage] = [:]

public func uploadImage(imageData: Data, path: String) {
    Amplify.Storage.uploadData(
        key: path,
        data: imageData
    )
}

public func fetchAuctionPhoto(auctionID: String) throws {
    let downloadTask = Amplify.Storage.downloadData(key: "auction/\(auctionID).jpg")
    Task {
        do {
            let data = try await downloadTask.value
            print("Completed: foto asta!")
            
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "fetchData", code: 0, userInfo: [NSLocalizedDescriptionKey: "data conversion error"])
            }
            photoMap[auctionID] = image
        } catch {
            print("Error downloading data: \(error)")
            throw error
        }
    }
}

public func fetchProfilePhoto(email: String) throws {
    print("\n\nSONO DENTRO CAZZO\n\n")
    let downloadTask = Amplify.Storage.downloadData(key: "profile/\(email).jpg")
    Task {
        do {
            let data = try await downloadTask.value
            print("\n\n\nCompleted: download foto profilo!\n\n\n")
            
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "fetchData", code: 0, userInfo: [NSLocalizedDescriptionKey: "data conversion error"])
            }
            photoMap["\(email)"] = image
        } catch {
            print("Error downloading data: \(error)")
            throw error
        }
    }
}

/*

func loadAllAuctionsPhotos(auctionList: [AuctionData]) async {
    print("DENTOR LA FUNZIONE LOAD ALL AUCTION PHOTOS")
    for index in 0..<auctionList.count {
        let auctionID = auctionList[index].id ?? ""
        print( "\n\n\nLoading photo for auction with ID \(auctionID)\n\n\n\n")

        do {
            //let photo =
            try fetchAuctionPhoto(auctionID: auctionID)
            //photoMap[auctionID] = photo
        } catch {
            print("Error loading photo for auction with ID \(auctionID): \(error)")
        }
    }
}

func updateAllAuctionsPhotos(auctionList: [AuctionData]) async {
    for index in 0..<auctionList.count {
        let currentID = auctionList[index].id ?? ""
        if photoMap[currentID] == nil {
            do {
                //let photo =
                try fetchAuctionPhoto(auctionID: currentID)
                //photoMap[currentID] = photo
            }
            catch {
                print("Error update photo for auction with ID \(currentID): \(error)")
            }
        }
    }
}
 */


public func nextID() -> String {
    var largestNumericValue = 0
    
    // Trova il valore numerico più grande nelle chiavi della mappa photoMap
    for key in photoMap.keys {
        if let numericValue = Int(key.components(separatedBy: "-").last ?? "") {
            largestNumericValue = max(largestNumericValue, numericValue)
        }
    }
    
    // Calcola il prossimo valore numerico aggiungendo uno al più grande
    let nextNumericValue = largestNumericValue + 1
    
    // Costruisci l'ID con tre cifre zero-padded
    let nextID = String(format: "ID-%03d", nextNumericValue)
    
    return nextID
}
