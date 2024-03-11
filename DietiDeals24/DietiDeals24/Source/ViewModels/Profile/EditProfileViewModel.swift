//
//  EditProfile.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import SwiftUI

import SwiftUI

class EditProfileViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var fullName: String
    @Published var nationality: String
    @Published var description: String
    @Published var showProfileSavedBanner: Bool
    @Published var link1 : String
    @Published var link2 : String
    
    init() {
        self.profileImage = nil
        self.fullName = "Giampiero Esposito"
        self.nationality = "Italy"
        self.description = "Welcome to my profile as a passionate collector and auction participant! I'm Giampiero, a lover of art, antiques, and rarities."
        self.showProfileSavedBanner = false
        self.link1 = "facebook/account.com"
        self.link2 = "tweeter/account.com"
    }
    
    func saveProfileChanges() {
        // Implementa qui la logica per salvare le modifiche al profilo
        showProfileSavedBanner = true
    }
    
    

}




struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?

        init(image: Binding<UIImage?>) {
            _image = image
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = uiImage
            }

            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        viewController.view.backgroundColor = .clear

        // Presenta il picker come foglio modale
        viewController.present(picker, animated: true)

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
