//
//  CreateFixedTimeAuctionView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 29/12/23.
//

import SwiftUI

struct CreateIncrementalAuctionView: View {
    let categories = ["All", "Technology", "Sport & Free Time", "Home & Garden", "Vehicle", "Service", "Other"]
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CreateIncrementalAuctionViewModel()
    @State private var isImagePickerPresented = false
    @State private var isAuctionCreated = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image")) {
                    VStack {
                        if let auctionImage = viewModel.auctionImage {
                            auctionImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                        } else {
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
                            get: { String(format: "%.2f", viewModel.startingPrice) },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0)?.floatValue {
                                    viewModel.startingPrice = max(0.0,newValue)
                                }
                            }
                        ))
                        .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Raising threshold (default 10€)")) {
                    HStack {
                        Text("€")
                        TextField("Enter amount", text: Binding(
                            get: { String(format: "%.2f", viewModel.raisingThreshold) },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0)?.floatValue {
                                    viewModel.raisingThreshold = max(10.0,newValue)
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
                        //TODO: aggiusta la chiamata con i parametri.
                        viewModel.createIncrementalAuction()
                        isAuctionCreated.toggle()
                    }) {
                        Text("CREATE AUCTION")
                            .padding(.leading, 85)
                    }
                    .disabled(viewModel.title.isEmpty || viewModel.location.isEmpty || viewModel.description.isEmpty)
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
        }
    }
}

struct CreateIncrementalAuctionView_Preview: PreviewProvider {
    static var previews: some View {
        CreateIncrementalAuctionView()
    }
}
