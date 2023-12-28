//
//  WorkerTaskAssignListCell.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct WorkerTaskAssignListCell: View {
    @State private var textValue = "Hello, SwiftUI!"
    
    @State private var showTasks = false

    
    
    var body: some View {
        VStack {
            if !showTasks {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Daniel")
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            .foregroundColor(Color.black)
                        
                        
                        Text("#RR10234 - Electrician")
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .foregroundColor(Color.black)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            showTasks.toggle()
                        }
                    }) {
                        Text("Assign")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    }
                    .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(8))
                    .background(Color.accentColor)
                    .cornerRadius(6)
                }
                .padding()
                
                
                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(10))
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
            } else {
                       VStack {
                           HStack {
                               Text("Task Assigned to Daniel Albert")
                                   .foregroundColor(.black)
                                 //  .padding()

                               Button(action: {
                                   // Add your undo logic here
                                   // For example, you can reset the text value
                                   withAnimation {
                                       showTasks.toggle()
                                   }
                               }) {
                                   Text("Undo")
                                       .foregroundColor(.blue)
                                       .underline()
                                       .padding()
                               }
                           }
                           .padding()
                           .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(10))
                           .background(Color.lightgreen)
                           .cornerRadius(8)
//                           .overlay(
//                               RoundedRectangle(cornerRadius: 8)
//                                   .stroke(Color.gray, lineWidth: 1)
//                           )
                          // .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2)
                       }
                   }
               }
        

        
    }
}

#Preview {
    WorkerTaskAssignListCell()
}
