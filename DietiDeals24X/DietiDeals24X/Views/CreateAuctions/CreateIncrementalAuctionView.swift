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
    @State private var selectedCategory: String = "All"
    @State private var isImagePickerPresented = false
    @State private var title: String = ""
    @State private var auctionImage: Image? = nil
    @State private var category: String = ""
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var timer: Int = 1
    @State private var startingPrice: Float = 0.0
    @State private var raisingThreshold: Float = 10.0
    @State private var isAuctionCreated = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image")) {
                    VStack {
                        if let auctionImage = auctionImage {
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
                                .sheet(isPresented: $isImagePickerPresented) {
                                    //TODO: ricordarsi di mettere nel viewModel il tutto.
                                    ImagePicker(image: $auctionImage)
                                }
                        }
                    }
                    .padding()
                    .padding(.leading, 90)
                }
                
                Section(header: Text("auction details")) {
                    TextField("Insert Title", text: $title)
                    TextField("Insert Location", text: $location)
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)
                }
                
                Section(header: Text("Starting Price")) {
                    HStack {
                        Text("€")
                        TextField("Enter amount", text: Binding(
                            get: { String(format: "%.2f", startingPrice) },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0)?.floatValue {
                                    startingPrice = max(0.0,newValue)
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
                            get: { String(format: "%.2f", raisingThreshold) },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0)?.floatValue {
                                    raisingThreshold = max(10.0,newValue)
                                }
                            }
                        ))
                        .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Timer")) {
                        Stepper(value: $timer, in: 1...48, step: 1) {
                            Text("Hours: \(timer) ")
                    }
                    .foregroundColor(.primary)
                    .font(.headline)
                }
                                
                Section(header: Text("Enter all missing data to continue")) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        isAuctionCreated.toggle()
                        //TODO: inserire la logica per creare l'asta
                    }) {
                        Text("CREATE AUCTION")
                            .padding(.leading, 85)
                    }
                    .disabled(title.isEmpty || location.isEmpty || description.isEmpty)
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
