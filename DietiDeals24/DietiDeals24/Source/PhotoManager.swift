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
public func uploadImage(imageData: Data, auctionId: String) {
    let key = "auction/\(auctionId).jpg"
    
    Amplify.Storage.uploadData(
        key: key,
        data: imageData
    )
    
}

public func uploadData(imageData: Data, auctionId: String) async {
    /*
     let dataString = "My Data"
     let data = Data(dataString.utf8)
     */
    
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

public func fetchData(key: String) async throws -> UIImage {
    do {
        let downloadTask = Amplify.Storage.downloadData(key: key)
        
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


