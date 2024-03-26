//
//  CreateFixedTimeAuctionView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 29/12/23.
//

import SwiftUI
import UIKit

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
                        if let auctionImage = viewModel.auctionImage {
                            if let imageData = auctionImage.jpegData(compressionQuality: 0.2) {
                                Task {
                                    await viewModel.createIncrementalAuction(imageData: imageData)
                                    isAuctionCreated.toggle()
                                }
                            } else {
                                // Gestisci il caso in cui la conversione dei dati fallisce
                            }
                        } else {
                            // Gestisci il caso in cui viewModel.auctionImage è nil
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


struct CreateIncrementalAuctionView_Preview: PreviewProvider {
    static var previews: some View {
        CreateIncrementalAuctionView()
    }
}




//MARK: ROBA PER CONVERTIRE FORMATO IMAGE IN UIIMAGE, IN MODO DA CONVERTIRLA IN DATA CON METODO .JPEGDATA E PASSABILE A AWS S3

/*

 extension View {
 // This function changes our View to UIView, then calls another function
 // to convert the newly-made UIView to a UIImage.
     public func asUIImage() -> UIImage {
         let controller = UIHostingController(rootView: self)
         
  // Set the background to be transparent incase the image is a PNG, WebP or (Static) GIF
         controller.view.backgroundColor = .clear
         
         controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
         UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
         
         let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
         controller.view.bounds = CGRect(origin: .zero, size: size)
         controller.view.sizeToFit()
         
 // here is the call to the function that converts UIView to UIImage: `.asUIImage()`
         let image = controller.view.asUIImage()
         controller.view.removeFromSuperview()
         return image
     }
 }

 extension UIView {
 // This is the function to convert UIView to UIImage
     public func asUIImage() -> UIImage {
         let renderer = UIGraphicsImageRenderer(bounds: bounds)
         return renderer.image { rendererContext in
             layer.render(in: rendererContext.cgContext)
         }
     }
 }

 */
