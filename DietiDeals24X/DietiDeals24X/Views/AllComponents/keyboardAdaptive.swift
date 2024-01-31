//
//  keyboardAdaptive.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 08/12/23.
//

import Foundation
import SwiftUI

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, keyboardHeight)
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            keyboardHeight = keyboardSize.height
                        }
                    }

                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        keyboardHeight = 0
                    }
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(self)
                }
        }
    }
}



