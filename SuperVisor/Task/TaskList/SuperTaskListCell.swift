//
//  SuperTaskListCell.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct SuperTaskListCell: View {
    
    @State private var workertaskassign = false

    
    var body: some View {
        VStack {
                  // Your VStack content goes here
            
            HStack {
               // Image("Ellipse 20")

                VStack(alignment: .leading, spacing: 4){
                    
                    Text("Floor carpenting")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                        .foregroundColor(Color.black)
                      //  .multilineTextAlignment(.leading)
                    
                    Text("Start date: 12 Dec, 2023")
                        .lineLimit(1)
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                       // .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)

                    
                    Text("Due Date: 12 Dec, 2023")
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                        .foregroundColor(.gray)
                       // .padding(.leading, 5.0)
                    
                    HStack(spacing:2){
                        Image("Ellipse 1121")
                            .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                        
                        Text("High")
                            .font(ConstantClass.AppFonts.light)
                            .foregroundColor(.black)
                            .padding(.leading, 5.0)
                        
                        Spacer()
                        
                    }
                    
                }
                
                
           
                
                Spacer()
                
                Button(action: {
                    // Add your button action here
                    
                    workertaskassign.toggle()
                }) {
                    Text("Assign Task")
                        .foregroundColor(.white)
                             .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                }
                .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(10))
//                    .background(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.blue, Color.blue]),
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    )
                
                .background(Color.accentColor)

                .cornerRadius(6)
              //  .padding()
               
//                .onTapGesture {
//                    mainview.toggle()
//                    
//                }
//              
//                .fullScreenCover(isPresented: $mainview, content: {
//                    Setnewpassword()
//                })
                
                
               }
            
            .padding()
            .frame(width: Responsiveframes.widthPercentageToDP(90))

              }
       //  .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(9))
              .background(Color.white) // Set the background color if needed
              .cornerRadius(8) // Adjust the corner radius as needed
              .overlay(
                  RoundedRectangle(cornerRadius: 8)
                      .stroke(Color.gray, lineWidth: 1) // Border color and width
              )
              //  .shadow(color: Color.gray.opacity(0.5), radius: 5, x: -2, y: 2) // Left and bottom shadow
             .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2) // Right and bottom shadow
        NavigationLink(destination: WorkerTaskAssignList(), isActive: $workertaskassign) { EmptyView() }

    }
}

#Preview {
    SuperTaskListCell()
}
