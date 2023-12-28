//
//  NotificationCell.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/01/24.
//

import SwiftUI

struct NotificationCell: View {
    var body: some View {
 ZStack {
        VStack(spacing: 15) {
            
            
            HStack {
                Image("Ellipse 20")

                Text("Request is Approved!")
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    .foregroundColor(Color.greenapp)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            HStack{
                Text("You can go outside geofence.")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            
        }
        .padding()

        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(9))
             .background(Color.white) // Set the background color if needed
             .cornerRadius(8) // Adjust the corner radius as needed
             .overlay(
                 RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.17), lineWidth: 0.5) // Border color and width
             )
             .shadow(color: Color.gray.opacity(0.15), radius: 5, x: 0, y: 2) // Outer shadow
       

    }

    }
}

#Preview {
    NotificationCell()
}
