//
//  NfcCheckin.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 16/01/24.
//

import SwiftUI

struct NfcCheckin: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                
                VStack {
                    Spacer()
                    
                    Image("Group 359")
                        .resizable()
                        .frame(width: ConstantClass.verybiglogo.logoWidth, height: ConstantClass.verybiglogo.logoHeight)
                        .padding()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(ConstantClass.verybiglogo.logoWidth/2)
                    Spacer()
                }
                
                .onTapGesture {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Showworkercheckin"), object: self)
                }
                
                
            } .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    NfcCheckin()
}


