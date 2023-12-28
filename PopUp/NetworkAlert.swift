//
//  NetworkAlert.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 06/02/24.
//

import SwiftUI

struct NetworkAlert: View {
    @ObservedObject var networkManager = NetworkViewModel()

    var body: some View {
        VStack {
            Image(systemName: networkManager.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            
            Text(networkManager.connectionDescription)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            if !networkManager.isConnected {
                Button {
                    print("Handle action..")
                } label: {
                    Text("Retry")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color(.systemBlue))
                }
                .frame(width: 140)
                .background(Color.white)
                .clipShape(Capsule())
                .padding()
            }
        }
    }
}

#Preview {
    NetworkAlert()
}
