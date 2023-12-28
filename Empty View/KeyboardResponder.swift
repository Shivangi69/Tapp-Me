//
//  KeyboardResponder.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 21/02/24.
//


import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { notification in
                withAnimation {
                    notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                }
            }
            .map { rect in
                rect.height
            }
            .assign(to: \.keyboardHeight, on: self)
    }
}
