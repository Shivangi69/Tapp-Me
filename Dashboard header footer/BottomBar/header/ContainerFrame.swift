//
//  ContainerFrame.swift
//
//  Created by codia-figma
//

import SwiftUI

struct ContainerFrame: View {
    @State public var textPpText: String = ""
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(textPpText)
                .foregroundColor(Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00))
                .font(.custom("Poppins-Black-Regular", size: 12))
                .lineLimit(1)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
        }
        .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
        .frame(height: 27)
        .background(Color(red: 0.43, green: 0.64, blue: 1.00, opacity: 1.00))
    }
}

struct ContainerFrame_Previews: PreviewProvider {
    static var previews: some View {
        ContainerFrame()
    }
}
