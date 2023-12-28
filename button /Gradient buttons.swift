//
//  Gradient buttons.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 02/01/24.
//

import SwiftUI

struct Gradient_buttons: View {
    var body: some View {
        Button(action: {
            // Add your sign-in action here
        }) {
            HStack {
                Spacer()
                Text("Sign In")
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Black", size: 16).weight(.semibold))
                Spacer()
            }
        }
        .frame(width: 350, height: 50)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.11764705882352941, green: 0.45098039215686275, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.42745098039215684, green: 0.6431372549019608, blue: 1, alpha: 1))]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(6)
    }
}




#Preview {
    Gradient_buttons()
}
