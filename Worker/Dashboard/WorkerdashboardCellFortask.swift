//
//  WorkerdashboardCellFortask.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 04/01/24.
//

import SwiftUI


struct WorkerdashboardCellFortask: View {

    @State private var taskdetails = false
    @State private var WorkerGeneralReport = false
    @State private var WorkkerCheckin = false

    
    
 @State private var mainview = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    VStack {
                        Text("1. Fix Roof top sheet")
                                 .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                        
                        Spacer()
                        
                        Text("Very High Priority")
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .font(ConstantClass.AppFonts.light)
                            .foregroundColor(Color.red)
                    }
                                    
                 
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        // Add your button action here
                        
                        taskdetails.toggle()

                        
                        
                    }) {
                        Text("View")
                            .foregroundColor(.white)
                                 .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    }
                    .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(5))
//                    .background(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.blue, Color.blue]),
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    )
                    
                    .background(Color.accentColor)

                    .cornerRadius(6)
                    .padding()
                   
                    .onTapGesture {
                        taskdetails.toggle()
                        
                    }
                  
                 
                }
            //.padding()
                
                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(7))
                
             Divider()
                    .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(1))

//                .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .inset(by: 0.5)
//                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
//                )
//                
                
            }
            
          //  NavigationLink(destination: WorkerTaskDetails(), isActive: $taskdetails) { EmptyView() }
//                            NavigationLink(destination: ResetPasswordScreen(), isActive: $goingresetscreen) { EmptyView() }
//                            NavigationLink(destination: ForgotPasswordView(), isActive: $goingtoforgotScreen) { EmptyView() }


       
        }
    }
}

#Preview {
    WorkerdashboardCellFortask()
}
