//
//  WorkerSubmittedCell.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 09/01/24.
//

import SwiftUI

struct WorkerSubmittedCell: View {

    @State private var Reportdescriptionsubmit = false
     @State private var WorkerGeneralReport = false
     @State private var WorkkerCheckin = false

    var body: some View {
        
        
        VStack(spacing: 10){
            
            VStack( alignment: .leading, spacing:10 ){
                HStack{
                    
                    Text("Fix Roof top sheet")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Text("#JD10215-1")
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))                         .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                    .padding(6)
                    .background(Color.lightblue)
                    
                }
                //  .frame(width: Responsiveframes.widthPercentageToDP(80))
                //  .padding()
                
                
                
                VStack{
                    Text("Submitted: Before work by #DA10245")
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                        .frame(width: Responsiveframes.widthPercentageToDP(60), height: Responsiveframes.heightPercentageToDP(4))
                        .background(Color.accentColor)
                        .cornerRadius(6)
                    
                    
                }
                
                VStack{
                    Text("Time & Date: 23 June, 2023 at 02:00 pm")
                        .foregroundColor(.black)
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    
                    
                    HStack {
                        Image("Map Point")
                            .resizable()
                            .frame(width: 24, height: 24) // Adjust the size of the image as needed
                        
                        Text("Location")
                            .foregroundColor(.black)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                        
                        Spacer()
                    }
                    //  .padding()
                    
                }
                
            }
            .frame(width: Responsiveframes.widthPercentageToDP(80))
            .onTapGesture {
                Reportdescriptionsubmit.toggle()
            }
           // Adjust the height as needed

            
            
        }
        
        .padding()
        .frame(width: Responsiveframes.widthPercentageToDP(90))
        .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color.black.opacity(0.15), lineWidth: 1)
            
        )
        
        
        
        
     //   NavigationLink(destination: WorkerReportsubmitDescription(), isActive: $Reportdescriptionsubmit) { EmptyView() }
        
        
        
        
        
    }
}

#Preview {
    WorkerSubmittedCell()
}
