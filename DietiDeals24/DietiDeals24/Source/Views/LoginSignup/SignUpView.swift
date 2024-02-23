import SwiftUI

struct SignUpView: View {
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var telephoneNumber = ""
    @State private var selectedUserType: FormattedUserType = .buyer
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var isConfirmationAlertPresented = false
    @State private var confirmationMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Image("png-signup")
                        .resizable()
                        .frame(width: 143.51051, height: 53)
                        .scaledToFit()
                        .padding(.top, 20)
                    
                    Text("Please enter your details to create your free account.")
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 10) {
                        FormattedTextField(title: "Enter your full Name", text: $fullName)
                        FormattedTextField(title: "Enter your email", text: $email)
                        FormattedSecureTextField(title: "Enter your password", text: $password)
                        FormattedSecureTextField(title: "Repeat your password", text: $repeatPassword)
                        FormattedNumberTextField(title: "Enter your phone number", text: $telephoneNumber)
                        
                        Text("You are a...")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Picker("Select User Type", selection: $selectedUserType) {
                            ForEach(FormattedUserType.allCases, id: \.self) { userType in
                                Text(userType.rawValue).tag(userType)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Button(action: signUp) {
                        Text("Sign Up!")
                            .font(.custom("SF Pro", size: 22))
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .frame(width: 300, height: 44)
                            .background(Color(red: 0.06, green: 0.45, blue: 0.64))
                            .cornerRadius(14)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 10)
                    
                    SocialLoginButtonsView()
                }
                .padding(.horizontal, 20)
                .alert(isPresented: $isConfirmationAlertPresented) {
                    Alert(title: Text("Confirmation Sent"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func signUp() {
        async {
            do {
                try await sessionManager.signUp(
                    username: email,
                    password: password,
                    email: email,
                    fullName: fullName,
                    phoneNumber: telephoneNumber,
                    userType: selectedUserType
                )
                confirmationMessage = "Confirmation sent to email: \(email)"
                isConfirmationAlertPresented = true
            } catch {
                print("Error during sign up:", error)
                // Handle error appropriately
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
