import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            ScrollView() {
                Image("png-logo")
                    .resizable()
                    .frame(width: 240.90546, height: 70.02985, alignment: .center)
                    .padding(.top, 40)

                FormattedSeparator()
                    .padding(.bottom, 40)

                VStack(spacing: 10) {
                    FormattedTextField(title: "Email", text: $viewModel.email)
                    FormattedSecureTextField(title: "Password", text: $viewModel.password)

                    NavigationLink("Did you forget your password?", destination: Text("Forgot Password")) // Aggiungi la destinazione corretta

                        .font(
                            Font.custom("SF Pro", size: 12)
                                .weight(.light)
                        )
                        .underline()
                        .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                        .frame(maxWidth: 300, alignment: .leading)
                        .padding(.bottom, 40)
                }

                LoginButton(
                    title: "Continue!",
                    fontSize: 22,
                    action: {
                        viewModel.login()
                    }
                )
                .alert(isPresented: Binding<Bool>(get: { viewModel.error != "" }, set: { _ in viewModel.error = "" })) {
                    Alert(title: Text("Error"), message: Text(viewModel.error), dismissButton: .default(Text("OK")))
                }

                FormattedSeparator()
                    .padding(.bottom, 15)

                SocialLoginButtonsView()

                NavigationLink("Don't have an account? SignUp!", destination: SignUpView())
                    .font(.caption)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}