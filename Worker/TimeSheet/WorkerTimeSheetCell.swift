//
//  WorkerTimeSheetCell.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct WorkerTimeSheetCell: View {
    var body: some View {
        
        VStack{
            
            
            VStack{
            HStack{
                
                HStack{
                    Image("Ellipse 20")
                    
                    Text("Check Out ")
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                        .foregroundColor(Color.red)
                    
                    Text("at 05:00 pm")
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                        .foregroundColor(Color.black)
                    // .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                Text("19 June 2020")
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                    .foregroundColor(Color.blue)
                
                
            }     .frame(width: Responsiveframes.widthPercentageToDP(80))
            
                .padding()
            Divider()
                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(1))
            
            
                HStack{
                    
                    HStack{
                        Image("Ellipse 20")
                        
                        Text("Check In ")
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .foregroundColor(Color.greenapp)
                        
                        Text("at 09:00 am")
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .foregroundColor(Color.black)
                        // .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Text("yesterday")
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                        .foregroundColor(Color.blue)
                    
                    
                }     .frame(width: Responsiveframes.widthPercentageToDP(80))
                
                    .padding()
                Divider()
                    .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(1))
    }

    
}
        
        
      
        .frame(width: Responsiveframes.widthPercentageToDP(90))
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .inset(by: 0.5)
//                .stroke(Color.black.opacity(0.15), lineWidth: 1)
//        )

        
        
    }
}

#Preview {
    WorkerTimeSheetCell()
}
