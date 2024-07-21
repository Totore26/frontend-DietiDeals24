//
//  CreateFixedTimeAuctionView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 29/12/23.
//

import SwiftUI
import UIKit

struct CreateIncrementalAuctionView: View {
    
    @EnvironmentObject var sessionManager : SessionManager
    @ObservedObject var viewModel : CreateIncrementalAuctionViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isImagePickerPresented = false
    @State private var isAuctionCreated = false
    

    
    init( viewModel: CreateIncrementalAuctionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image")) {
                    VStack {
                        if let auctionImage = viewModel.auctionImage {
                            Image(uiImage: auctionImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                        } else {
                            // Gestisci il caso in cui viewModel.auctionImage è nil
                            // Potresti visualizzare un segnaposto o fornire un comportamento predefinito
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.black)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                        }
                        
                        Button(action: {
                            isImagePickerPresented.toggle()
                        }) {
                            Text("Edit")
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                    .padding(.leading, 90)
                }
                
                Section(header: Text("auction details")) {
                    TextField("Insert Title", text: $viewModel.title)
                    TextField("Insert Location", text: $viewModel.location)
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $viewModel.description)
                        .frame(minHeight: 100)
                }
                
                Section(header: Text("Starting Price")) {
                    HStack {
                        Text("€")
                        TextField("Enter amount", text: Binding(
                            get: {
                                String(format: "%.2f", Double(truncating: viewModel.startingPrice as NSNumber))
                            },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0)?.doubleValue {
                                    viewModel.startingPrice = Decimal(max(0.0, newValue))
                                }
                            }
                        ))
                        .keyboardType(.decimalPad)
                    }
                }

                Section(header: Text("Raising Threshold (default 10€)")) {
                    HStack {
                        Text("€")
                        TextField("Enter amount", text: Binding(
                            get: {
                                String(format: "%.2f", Double(truncating: viewModel.raisingThreshold as NSNumber))
                            },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0)?.doubleValue {
                                    viewModel.raisingThreshold = Decimal(max(10.0, newValue))
                                }
                            }
                        ))
                        .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Timer")) {
                    Stepper(value: $viewModel.timer, in: 1...48, step: 1) {
                        Text("Hours: \(viewModel.timer) ")
                    }
                    .foregroundColor(.primary)
                    .font(.headline)
                }
                
                Section(header: Text("Enter all missing data to continue")) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                        // Verifica se è stata selezionata un'immagine per l'asta
                        guard let auctionImage = viewModel.auctionImage else {
                            // Gestisci il caso in cui non sia stata selezionata un'immagine
                            return
                        }
                        
                        // Converte l'immagine in dati JPEG
                        guard let imageData = auctionImage.jpegData(compressionQuality: 0.2) else {
                            // Gestisci il caso in cui la conversione in dati JPEG fallisce
                            return
                        }
                        
                        // Effettua la chiamata alla funzione per creare l'asta incrementale nel view model
                        
                        viewModel.createIncrementalAuction { success, error in
                            if let error = error {
                                // Se si verifica un errore durante la chiamata API, stampalo
                                print("Error creating auction:", error.localizedDescription)
                            } else {
                                // Imposta il flag per mostrare l'alert in base al risultato della chiamata
                                uploadImage(imageData: imageData, path: "auction/\(nextID()).jpg")
                                isAuctionCreated = success
                                
                            }
                        }
                        
                    }) {
                        Text("CREATE AUCTION")
                            .padding(.leading, 85)
                    }
                    .disabled(viewModel.title.isEmpty || viewModel.location.isEmpty || viewModel.description.isEmpty || viewModel.auctionImage == nil)
                }
            }
            .navigationBarTitle("Create Incremental Auction", displayMode: .inline)
            .alert(isPresented: $isAuctionCreated) {
                Alert(
                    title: Text("Auction Created"),
                    message: Text("Your auction has been successfully created."),
                    dismissButton: .default(Text("OK")) {
                        // Aggiungi qui la logica aggiuntiva dopo la creazione dell'asta
                    }
                )
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $viewModel.auctionImage)
            }
        }
    }
}
