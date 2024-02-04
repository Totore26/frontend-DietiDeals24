import SwiftUI




struct SignUpView: View {
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var telephoneNumber = ""
    @State private var selectedUserType: FormattedUserType = .buyer

    var body: some View {
        NavigationView {
            ScrollView() {
                
                Image("png-signup")
                    .resizable()
                    .frame(width: 143.51051, height: 53, alignment: .center)
                    .padding(.top, 5)
                    .scaledToFit()

                FormattedSeparator()
                    .padding(.bottom, 10)

                Text("Please enter your details to create your free account.")
                    .font(
                        Font.custom("SF Pro", size: 13)
                        .weight(.light)
                    )
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
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    Picker("Select User Type", selection: $selectedUserType) {
                        ForEach(FormattedUserType.allCases, id: \.self) { userType in
                            Text(userType.rawValue).tag(userType)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                    LoginButton(title: "Sign Up!",
                        fontSize: 22,
                        action: {
                            //TODO: Implementa la logica di registrazione qui
                            print("Sign Up button tapped")
                            print( "fullName: \(fullName)")
                            }
                        )
                
                FormattedSeparator()
                    .padding(.bottom, 20)
                
                SocialLoginButtonsView()
                
            }
            .padding(.horizontal, 20)
        }
        /*TODO: inseriscilo nel viewmodel corrispondente
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // Chiudi la tastiera quando si tocca sullo schermo (MAGICO)
        }
         Anche se questo metodo fa buggare il pulsante di ritorno e anche la scelta del buyer seller!!
         */
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
