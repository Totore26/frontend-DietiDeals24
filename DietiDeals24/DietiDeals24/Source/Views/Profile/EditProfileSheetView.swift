//
//  EditProfileSheetView.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 15/12/23.
//
import SwiftUI

struct EditProfileSheetView: View {
    
    @ObservedObject var viewModel = EditProfileViewModel()
    @EnvironmentObject var sessionManager : SessionManager
    
    @State private var isImagePickerPresented = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Photo")) {
                    VStack(alignment: .center){
                        if let profileImage = viewModel.profileImage {
                            Image(uiImage: profileImage)
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
                            ImagePicker(image: $viewModel.profileImage)
                        }
                    }
                }
                .padding(.leading, 100)

                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: $viewModel.fullName)
                    TextField("Nationality", text: $viewModel.nationality)
                }

                Section(header: Text("Description")) {
                    TextEditor(text: $viewModel.description)
                        .frame(height: 100)
                }

                Section(header: Text("Contact")) {
                    NavigationLink(destination: EditContactView(contactType: "Phone Number")) {
                        Text("Change Phone Number")
                    }
                }

                Section(header: Text("Social Links")) {
                    TextField("Link 1", text: $viewModel.link1)
                    TextField("Link 2", text: $viewModel.link2)
                }

                Section(header: Text("Edit password")) {
                    NavigationLink(destination: EditPasswordView(showPasswordSavedBanner: $viewModel.showProfileSavedBanner).environmentObject(sessionManager)) {
                        Text("Change Password")
                    }
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                //MARK: LOGICA PER SALVARE IL PROFILO.
                viewModel.saveProfileChanges()
            })
            .alert(isPresented: $viewModel.showProfileSavedBanner) {
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
    @EnvironmentObject var sessionManager : SessionManager
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
                Task {
                    await sessionManager.changePassword(oldPassword: currentPassword, newPassword: confirmPassword)
                }
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


#Preview {
    EditProfileSheetView()
}

