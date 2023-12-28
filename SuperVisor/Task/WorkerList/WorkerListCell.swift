//
//  WorkerListCell.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 17/01/24.
//

import SwiftUI

//struct WorkerListCell: View {
//    
//    @State private var textValue = "Hello, SwiftUI!"
//    @State private var showTasks = false
//    @State private var mainview = false
//
//    
//    var body: some View {
//        VStack {
//            
//            HStack {
//                HStack {
//                    Text("Daniel")
//                        .fontWeight(.semibold)
//                        .lineLimit(1)
//                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                        .foregroundColor(Color.black)
//                        .multilineTextAlignment(.leading)
//                    
//                    Spacer()
//                    
//                    
//                    HStack(alignment: .center) {
//                        Text("#JD10215-1")
//                            .lineLimit(1)
//                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))                         .multilineTextAlignment(.center)
//                            .foregroundColor(.white)
//                    }
//                    .padding(6)
//                    .background(Color.lightblue)
//                    
//                }
//                
//                
//                Button(action: {
//                    // Add action for the button here
//                    mainview.toggle()
//                }) {
//                    Text("View Details")
//                        .lineLimit(1)
//                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.lightblue)
//                        .padding(6)
//                        .background(Color.white)
//                        .cornerRadius(8) // Add corner radius to mimic button style
//                }
//                .onTapGesture {
//                    mainview.toggle()
//                }
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.lightblue, lineWidth: 1)
//                )
//        
//                
//                NavigationLink(destination: WorkerViewTasklist(), isActive: $mainview) { EmptyView() }
//                
//            }
//            .padding()
//            .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(9))
//            .background(Color.white)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.gray.opacity(0.17), lineWidth: 1)
//            )
//            
//        }
//        
//        
//     .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2)
//
//    }
//}

//#Preview {
//    WorkerListCell()
//}
