import SwiftUI

struct ContentView: View {
    @State private var isAlertPresented = false
    @State private var selectedAuctionType = FormattedAuctionType.null

    var body: some View {
        NavigationView {
            VStack {
                Button("Show Alert") {
                    isAlertPresented.toggle()
                }
                .alert(isPresented: $isAlertPresented) {
                    Alert(
                        title: Text("Choose Auction Type"),
                        message: Text("Select the type of auction you want to create."),
                        primaryButton: .default(
                            Text("Fixed-time"),
                            action: {
                                selectedAuctionType = .fixed
                            }
                        ),
                        secondaryButton: .default(
                            Text("Incremental"),
                            action: {
                                selectedAuctionType = .incremental
                            }
                        )
                    )
                }

                // Use NavigationLink directly in the layout
                NavigationLink(
                    destination: getAuctionView(),
                    isActive: Binding(
                        get: { selectedAuctionType == .fixed },
                        set: { newValue in
                            if !newValue {
                                selectedAuctionType = .null
                            }
                        }
                    ),
                    label: EmptyView.init
                )

                NavigationLink(
                    destination: getIncrementalView(),
                    isActive: Binding(
                        get: { selectedAuctionType == .incremental },
                        set: { newValue in
                            if !newValue {
                                selectedAuctionType = .null
                            }
                        }
                    ),
                    label: EmptyView.init
                ) 
            }
        }
    }

    func getAuctionView() -> some View {
        // Implementa la vista per l'asta a tempo fisso
        return Text("Fixed Auction View")
    }

    func getIncrementalView() -> some View {
        // Implementa la vista per l'asta incrementale
        return Text("Incremental Auction View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
