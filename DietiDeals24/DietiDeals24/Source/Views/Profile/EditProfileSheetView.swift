//
//  EditProfileSheetView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 15/12/23.
//
import SwiftUI


struct EditProfileSheetView: View {

    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isImagePickerPresented = false
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Photo")) {
                    VStack(alignment: .center) {
                        //Prova a visualizzare la foto appena caricata se c e
                        if let ImageProfile = viewModel.imageProfile {
                            Image(uiImage: ImageProfile)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                        }
                        //prova ad assegnare la foto salvata in memoria se c e
                        else if let ImageProfile = photoMap["\(viewModel.account?.email ?? "")"] {
                            Image(uiImage: ImageProfile)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                            //altrimenti assegna quella di default
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
                            ImagePicker(image: $viewModel.imageProfile)
                        }
                    }
                }
                .padding(.leading, 100)

                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: Binding(
                        get: { viewModel.account?.fullName ?? "" },
                        set: { newValue in viewModel.account?.fullName = newValue }
                    ))
                    TextField("Nationality", text: Binding(
                        get: { viewModel.account?.country ?? "" },
                        set: { newValue in viewModel.account?.country = newValue }
                    ))
                }

                Section(header: Text("Description")) {
                    TextEditor(text: Binding(
                        get: { viewModel.account?.description ?? "" },
                        set: { newValue in viewModel.account?.description = newValue }
                    ))
                    .frame(height: 100)
                }

                Section(header: Text("Contact")) {
                    TextField("Phone Number", text: Binding(
                        get: { viewModel.account?.telephoneNumber ?? "" },
                        set: { newValue in viewModel.account?.telephoneNumber = newValue }
                    ))
                    TextField("Email", text: Binding(
                        get: { viewModel.account?.email ?? "" },
                        set: { newValue in viewModel.account?.email = newValue }
                    ))
                }

                Section(header: Text("Social Links")) {
                    TextField("Link 1", text: Binding(
                        get: { viewModel.account?.socialLinks?[0].link ?? "" },
                        set: { newValue in viewModel.account?.socialLinks?[0].link = newValue }
                    ))
                    TextField("Link 2", text: Binding(
                        get: { viewModel.account?.socialLinks?[1].link ?? "" },
                        set: { newValue in viewModel.account?.socialLinks?[1].link = newValue }
                    ))
                }

                Section(header: Text("Edit Password")) {
                    NavigationLink(destination: EditPasswordView(showPasswordSavedBanner: $viewModel.showProfileSavedBanner, showPasswordErrorBanner: $viewModel.showPasswordErrorBanner)) {
                        Text("Change Password")
                    }
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                viewModel.saveChanges(isSellerSession: sessionManager.isSellerSession)
                guard let profileImage = viewModel.imageProfile else {
                    return
                }
                guard let imageData = profileImage.jpegData(compressionQuality: 0.2) else {
                    return
                }
                uploadImage(imageData: imageData, path: "profile/\(viewModel.account?.email ?? "").jpg")
            })
            .alert(isPresented: $viewModel.showProfileSavedBanner) {
                Alert(title: Text("Profile Saved"), message: Text("Changes to your profile have been saved successfully."), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct EditPasswordView: View {
    @EnvironmentObject var sessionManager : SessionManager
    @Environment(\.presentationMode) var presentationMode
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @Binding var showPasswordSavedBanner: Bool
    @Binding var showPasswordErrorBanner: Bool

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
                Task {
                    do{
                        try await sessionManager.changePassword(oldPassword: currentPassword, newPassword: confirmPassword)
                        showPasswordSavedBanner = true
                    } catch {
                        print(error.localizedDescription)
                        showPasswordErrorBanner = true
                    }
                }
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
        .alert(isPresented: $showPasswordErrorBanner) {
                    Alert(title: Text("Password not saved"), message: Text("An error occurred, check if old password and new password is correct (8-16 characters)"), dismissButton: .default(Text("OK")))
                }
    }
}
