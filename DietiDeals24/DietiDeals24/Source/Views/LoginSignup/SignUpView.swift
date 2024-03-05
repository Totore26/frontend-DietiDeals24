import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject private var viewModel = SignUpViewModel() // Crea un'istanza del tuo ViewModel
    
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
                        FormattedTextField(title: "Enter your full Name", text: $viewModel.fullName)
                        FormattedTextField(title: "Enter your email", text: $viewModel.email)
                        FormattedSecureTextField(title: "Enter your password", text: $viewModel.password)
                        FormattedSecureTextField(title: "Repeat your password", text: $viewModel.repeatPassword)
                            .onChange(of: viewModel.repeatPassword, perform: { _ in
                                viewModel.passwordMatchError = !passwordsMatch()
                            })
                        FormattedNumberTextField(title: "Enter your phone number", text: $viewModel.telephoneNumber)
                        
                        // Visualizzazione dell'errore se le password non corrispondono
                        if viewModel.passwordMatchError {
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
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.fullName.isEmpty || viewModel.repeatPassword.isEmpty || viewModel.telephoneNumber.isEmpty || viewModel.passwordMatchError)
                                        .padding(.bottom, 10)
                    
                    SocialLoginButtonsView()
                }
                .padding(.horizontal, 20)
               .adaptiveSheet(isPresented: $viewModel.isConfirmationAlertPresented, detents: [.medium()], smallestUndimmedDetentIdentifier: .large) {
                   // Contenuto della sheet con campo per inserimento del codice di verifica e bottone per confermare
                   VStack {
                       Spacer()
                       Text("Insert OTP code sent by mail")
                       FormattedTextField(title: "Enter OTP", text: $viewModel.otp)
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
                username: viewModel.email,
                password: viewModel.password,
                email: viewModel.email,
                fullName: viewModel.fullName,
                phoneNumber: viewModel.telephoneNumber
            )
        }
        viewModel.isConfirmationAlertPresented = true
    }

    private func continueSignUp() {
        Task(priority: .userInitiated) {
            
            await sessionManager.confirmSignUp(for: viewModel.email, with: viewModel.otp)
            print("Sign up confirmed successfully")
            viewModel.confirmationMessage = "REGISTRATION COMPLETE"
            //aggiungo al DB
            viewModel.addUser()
            // Mostra la schermata di login solo se l'inserimento nel database va a buon fine
            sessionManager.showLogin()
            viewModel.isConfirmationAlertPresented = false
            sessionManager.showLogin()
        }
    }

    private func passwordsMatch() -> Bool {
        return viewModel.password == viewModel.repeatPassword
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
