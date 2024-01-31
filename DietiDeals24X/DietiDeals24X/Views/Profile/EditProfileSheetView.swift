//
//  EditProfileSheetView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 15/12/23.
//
import SwiftUI

struct EditProfileSheetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var profileImage: Image?
    @State private var isImagePickerPresented = false
    @State private var fullName = "Giampiero Esposito"
    @State private var nationality = "Italy"
    @State private var description = "Welcome to my profile as a passionate collector and auction participant! I'm Giampiero, a lover of art, antiques, and rarities."
    @State private var showProfileSavedBanner = false //serve per visualizzare il banner

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Photo")) {
                    VStack(alignment: .center){
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                        } else {
                            Image(systemName: "person.crop.circle.fill")
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
                        }
                        .padding(.top, 5)
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(image: $profileImage)
                        }
                    }
                }
                .padding(.leading, 100)

                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Nationality", text: $nationality)
                }

                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }

                Section(header: Text("Contact")) {
                    NavigationLink(destination: EditContactView(contactType: "Phone Number")) {
                        Text("Change Phone Number")
                    }
                }

                Section(header: Text("Social Links")) {
                    NavigationLink(destination: EditLinkView(linkType: "link 1")) {
                        Text("Link 1:  www.facebook/account.com")
                    }

                    NavigationLink(destination: EditLinkView(linkType: "link 2")) {
                        Text("Link 2:  www.twitter/account.com")
                    }
                }

                Section(header: Text("Edit password")) {
                    NavigationLink(destination: EditPasswordView(showPasswordSavedBanner: $showProfileSavedBanner)) {
                        Text("Change Password")
                    }
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                // TODO: Implementa l'azione per salvare le modifiche al profilo
                showProfileSavedBanner = true
            })
            .alert(isPresented: $showProfileSavedBanner) {
                Alert(title: Text("Profile Saved"), message: Text("Changes to your profile have been saved successfully."), dismissButton: .default(Text("OK")))
            }
        }
        Spacer()

        Button("Close") {
            presentationMode.wrappedValue.dismiss()
        }
        .padding()
    }
}


struct EditLinkView: View {
    var linkType: String
    @State private var link = ""

    var body: some View {
        Form {
            Section(header: Text("Social Links")) {
                TextField("\(link)", text: $link)
            }
            }
        .navigationBarTitle(" Link", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save"){
            
            //TODO: gestire il salvataggio del nuovo link
        }
            
        )
    }
}


struct EditContactView: View {
    @State private var newContact = ""
    @State private var isEditing = false
    let contactType: String

    var body: some View {
        Form {
            Section(header: Text("New \(contactType)")) {
                TextField("Enter \(contactType)", text: $newContact)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(contactType == "Phone Number" ? .phonePad : .default)
            }
        }
        .navigationBarTitle("Edit \(contactType)", displayMode: .inline)
        .navigationBarItems(
            trailing: Button("Save") {
                //TODO: Implementa l'azione per salvare il nuovo contatto
            }
            .disabled(newContact.isEmpty)
        )
    }
}


struct EditPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @Binding var showPasswordSavedBanner: Bool

    var body: some View {
        Form {
            Section(header: Text("Current Password")) {
                SecureField("Enter current password", text: $currentPassword)
            }

            Section(header: Text("New Password")) {
                SecureField("Enter new password", text: $newPassword)
            }

            Section(header: Text("Confirm Password")) {
                SecureField("Confirm new password", text: $confirmPassword)
            }
            
            Text("If you cannot save, check that the password is the same as the confirmed one")
                .font(.caption)
                .foregroundColor(.gray) // Puoi personalizzare il colore del testo
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Save") {
                // TODO: Implementa l'azione per salvare la nuova password
                showPasswordSavedBanner = true
            }
            .disabled(newPassword.isEmpty || confirmPassword.isEmpty || newPassword != confirmPassword)
            .frame(minWidth: 0, maxWidth: .infinity)
            .contentShape(Rectangle())



        }
        .navigationBarTitle("Change Password", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
        HStack {
                Button(action: {
                    // azione per tornare indietro
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.blue)
                }
                .frame(width: 30, height: 30)
            }
        )
        .alert(isPresented: $showPasswordSavedBanner) {
            Alert(title: Text("Password Saved"), message: Text("Your password has been changed successfully."), dismissButton: .default(Text("OK")))
        }
    }
}

//TODO: da mettere nel view model dell'EditProfile.
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: Image?

        init(image: Binding<Image?>) {
            _image = image
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = Image(uiImage: uiImage)
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



#Preview {
    EditProfileSheetView()
}

