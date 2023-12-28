////
////  StandardPopUp.swift
////  Tapp Me
////
////  Created by Rohit wadhwa on 04/01/24.
////
//
//import SwiftUI


import SwiftUI

struct StandardPopUp: View {
    @Binding var isShowingPopup: Bool
    var title: String
    var yesButtonLabel: String
    var noButtonLabel: String
    var onYesTapped: () -> Void
    var onNoTapped: () -> Void
    
    var selectedTask: Int? // Assuming Task is the type of your data

    var body: some View {
        ZStack {
//        Color.black.opacity(0.3)
//      .edgesIgnoringSafeArea(.all) // Move edgesIgnoringSafeArea here

            GeometryReader { geometry in
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 50) {
                        VStack(alignment: .center, spacing: 40) {
                            Text(title)
                                .foregroundColor(.darkgray)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .frame(width: (Responsiveframes.widthPercentageToDP(50)))
                            
                            HStack {
                                Button(yesButtonLabel) {
                                    isShowingPopup = false
                                    onYesTapped()
                                    
                                }
                                .frame(width: (Responsiveframes.widthPercentageToDP(70))/2, height: Responsiveframes.heightPercentageToDP(5))
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(6)
                                .onTapGesture {
                                    isShowingPopup = false
                                    onYesTapped()
                                }
                                
                                Spacer()
                                
                                Button(noButtonLabel) {
                                    isShowingPopup = false
                                    onNoTapped()
                                }
                                .frame(width: (Responsiveframes.widthPercentageToDP(70))/2, height: Responsiveframes.heightPercentageToDP(5))
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(6)
                                .onTapGesture {
                                    isShowingPopup = false
                                    onNoTapped()
                                }
                            }
                            .frame(width: (Responsiveframes.widthPercentageToDP(70))/2)
                        }
                        .frame(width: (Responsiveframes.widthPercentageToDP(70)))
                    }
                    .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(25))
                    .transition(.scale)
                    .animation(.spring())
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
                    
                    Spacer()
                }
                
                .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
           

                
            }
            
        }

    }
}











//
//struct StandardPopUp: View {
//    @Binding var isShowingPopup: Bool
//    var title: String
//    var yesButtonLabel: String
//    var noButtonLabel: String
//    var onYesTapped: () -> Void
//    var onNoTapped: () -> Void
//
//    var body: some View {
//        ZStack {
//        Color.black.opacity(0.3)
//      .edgesIgnoringSafeArea(.all) // Move edgesIgnoringSafeArea here
//            
//            GeometryReader { geometry in
//                
//                VStack {
//                    Spacer()
//                    
//                    VStack(spacing: 50) {
//                        VStack(alignment: .center, spacing: 40) {
//                            Text(title)
//                                .foregroundColor(.darkgray)
//                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
////                                .lineLimit(2)
//                                .multilineTextAlignment(.center)
//                                .frame(width: (Responsiveframes.widthPercentageToDP(50)))
//                            
//                            HStack {
//                                Button(yesButtonLabel) {
//                                    isShowingPopup = false
//                                    onYesTapped()
//                                    
//                                }
//                                .frame(width: (Responsiveframes.widthPercentageToDP(70))/2, height: Responsiveframes.heightPercentageToDP(5))
//                                .foregroundColor(.white)
//                                .background(Color.accentColor)
//                                .cornerRadius(6)
//                                .onTapGesture {
//                                    isShowingPopup = false
//                                    onYesTapped()
//                                }
//                                
//                                Spacer()
//                                
//                                Button(noButtonLabel) {
//                                    isShowingPopup = false
//                                    onNoTapped()
//                                }
//                                .frame(width: (Responsiveframes.widthPercentageToDP(70))/2, height: Responsiveframes.heightPercentageToDP(5))
//                                .foregroundColor(.white)
//                                .background(Color.red)
//                                .cornerRadius(6)
//                                .onTapGesture {
//                                    isShowingPopup = false
//                                    onNoTapped()
//                                }
//                            }
//                            .frame(width: (Responsiveframes.widthPercentageToDP(70))/2)
//                        }
//                        .frame(width: (Responsiveframes.widthPercentageToDP(70)))
//                    }
//                    .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(25))
//                    .transition(.scale)
//                    .animation(.spring())
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color.white)
//                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
//                    )
//                    
//                    Spacer()
//                }
//                
//                .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
//           
//
//                
//            }
//            
//        }
//
//    }
//}


struct StandardPopUp_Previews: PreviewProvider {
    static var previews: some View {
        StandardPopUp(
            isShowingPopup: .constant(false),
            title: "Are you sure?",
            yesButtonLabel: "Yes",
            noButtonLabel: "No",
            onYesTapped: {
                // Handle Yes button tapped
            },
            onNoTapped: {
                // Handle No button tapped
            }
        )
    }
}
