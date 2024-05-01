//
//  CreateFixedTimeAuctionView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 29/12/23.
//

import SwiftUI

struct CreateFixedTimeAuctionView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isImagePickerPresented = false
    @State private var isAuctionCreated = false
    @ObservedObject var viewModel: CreateFixedTimeAuctionViewModel
    
    init(viewModel: CreateFixedTimeAuctionViewModel) {
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
                
                Section(header: Text("Auction Details")) {
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
                
                Section(header: Text("End of Auction")) {
                    DisclosureGroup("Date ") {
                        DatePicker("", selection: $viewModel.endOfAuction, displayedComponents: [.date])
                            .datePickerStyle(CompactDatePickerStyle())
                    }
                    .foregroundColor(.primary)
                    .font(.headline)
                }
                
                Section(header: Text("Minimum Secret Threshold")) {
                    HStack {
                        Text("€")
                        TextField("Enter amount", text: Binding(
                            get: { String(format: "%.2f", Double(truncating: viewModel.secretThreshold as NSNumber)) },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0)?.decimalValue {
                                    viewModel.secretThreshold = max(Decimal(0.0), newValue)
                                }
                            }
                        ))
                        .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Enter all missing data to continue")) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        viewModel.createFixedTimeAuction()
                        isAuctionCreated.toggle()
                    }) {
                        Text("CREATE AUCTION")
                        .padding(.leading, 85)
                    }
                    .disabled(viewModel.title.isEmpty || viewModel.location.isEmpty || viewModel.description.isEmpty)
                }
            }
            .navigationBarTitle("Create Fixed-Time Auction", displayMode: .inline)
            .alert(isPresented: $isAuctionCreated) {
                Alert(
                    title: Text("Auction Created"),
                    message: Text("Your auction has been successfully created."),
                    dismissButton: .default(Text("OK")) {
                        // Add any additional logic here after the auction is created
                    }
                )
            }
        }
    }
}
