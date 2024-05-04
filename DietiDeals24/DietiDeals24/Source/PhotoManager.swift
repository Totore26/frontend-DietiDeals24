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


public func uploadImage(imageData: Data, auctionId: String) {
    let key = "auction/\(auctionId).jpg"
    
    Amplify.Storage.uploadData(
        key: key,
        data: imageData
    )
    
}

//MEGLIO QUELLA SU CREDO
public func uploadData(imageData: Data, auctionId: String) async {
    
    do {
        let uploadTask = Amplify.Storage.uploadData(
            key: "auction/\(auctionId).jpg",
            data: imageData
        )

        for await progress in await uploadTask.progress {
            print("Progress: \(progress)")
        }

        let value = try await uploadTask.value
        print("Completed: \(value)")

    } catch {
        print("Error uploading data: \(error)")
    }
}

public func fetchAuctionPhoto(auctionID: String) async throws -> UIImage {
    do {
        let downloadTask = Amplify.Storage.downloadData(key: "auction/\(auctionID).jpg")
        
        for await progress in await downloadTask.progress {
            print("Progress: \(progress)")
        }
        
        let data = try await downloadTask.value
        print("Completed: \(data)")
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "fetchData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Impossibile convertire i dati in un'immagine."])
        }
        
        return image
    } catch {
        print("Error fetching data: \(error)")
        throw error
    }
}

func loadAllAuctionsPhotos(auctionList: [AuctionData]) async {
    for index in 0..<auctionList.count {
        let auctionID = auctionList[index].id ?? ""
        print( "\n\n\nLoading photo for auction with ID \(auctionID)\n\n\n\n")

        do {
            let photo = try await fetchAuctionPhoto(auctionID: auctionID)
            photoMap[auctionID] = photo
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
                let photo = try await fetchAuctionPhoto(auctionID: currentID)
                photoMap[currentID] = photo
            }
            catch {
                print("Error update photo for auction with ID \(currentID): \(error)")
            }
        }
    }
}


func nextID() -> String {
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


