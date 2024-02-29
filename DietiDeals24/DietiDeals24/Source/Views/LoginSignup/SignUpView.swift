import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var telephoneNumber = ""
    @State private var otp = ""
    @State private var isConfirmationAlertPresented = false
    @State private var confirmationMessage = ""
    @State private var passwordMatchError = false // Aggiunta variabile per gestire l'errore
    
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
                    
                    // Gestione dell'errore
                    if let errorBanner = sessionManager.errorBanner {
                        Text(errorBanner)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    VStack(spacing: 10) {
                        FormattedTextField(title: "Enter your full Name", text: $fullName)
                        FormattedTextField(title: "Enter your email", text: $email)
                        FormattedSecureTextField(title: "Enter your password", text: $password)
                        FormattedSecureTextField(title: "Repeat your password", text: $repeatPassword)
                            .onChange(of: repeatPassword, perform: { _ in
                                passwordMatchError = !passwordsMatch() // Verifica se le password corrispondono quando viene modificato il campo di ripetizione password
                            })
                        FormattedNumberTextField(title: "Enter your phone number", text: $telephoneNumber)
                        
                        // Visualizzazione dell'errore se le password non corrispondono
                        if passwordMatchError {
                            Text("Passwords do not match")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    Button(action: signUp) {
                        Text("Signup")
                            .font(.custom("SF Pro", size: 22))
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .frame(width: 300, height: 44)
                            .background(Color(red: 0.06, green: 0.45, blue: 0.64))
                            .cornerRadius(14)
                            .foregroundColor(.white)
                    }
                    .disabled(email.isEmpty || password.isEmpty || fullName.isEmpty || repeatPassword.isEmpty || telephoneNumber.isEmpty || passwordMatchError)
                    .padding(.bottom, 10)
                    
                    SocialLoginButtonsView()
                }
                .padding(.horizontal, 20)
                .adaptiveSheet(isPresented: $isConfirmationAlertPresented, detents: [.medium()], smallestUndimmedDetentIdentifier: .large) {
                    // Contenuto della sheet con campo per inserimento del codice di verifica e bottone per confermare
                    VStack {
                        Spacer()
                        Text("Insert OTP code sent by mail")
                        FormattedTextField(title: "Enter OTP", text: $otp)
                        Spacer()
                        Button(action: continueSignUp ) {
                            Text("Continue")
                                .font(.custom("SF Pro", size: 22))
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .frame(width: 300, height: 44)
                                .background(Color(red: 0.06, green: 0.45, blue: 0.64))
                                .cornerRadius(14)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 70)
                    }
                }
            }
        }
        .onDisappear {
            // Imposta l'errore a stringa vuota quando si torna alla schermata di login
            sessionManager.errorBanner = ""
        }
    }
    
    private func signUp() {
        Task(priority: .userInitiated) {
                await sessionManager.signUp(
                username: email,
                password: password,
                email: email,
                fullName: fullName,
                phoneNumber: telephoneNumber
            )
        }
        isConfirmationAlertPresented = true
    }

    private func continueSignUp() {
        Task(priority: .userInitiated) {
            await sessionManager.confirmSignUp(for: email, with: otp)
            print("Sign up confirmed successfully")
            confirmationMessage = "REGISTRATION COMPLETE"
            sessionManager.showLogin()
            isConfirmationAlertPresented = false
            sessionManager.showLogin()
        }
    }
    
    private func passwordsMatch() -> Bool {
        return password == repeatPassword
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
