//
//  SuperRequestForGeofence.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct SuperRequestForGeofence: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{

        
        ZStack {
            GeometryReader { geometry in
                
                VStack{
                    VStack(spacing:50.0){
                        
                        HStack(alignment: .center, spacing:10){
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            })
                            {
                                Image("Arrow Left-8")
                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                
                                
                            }
                            
                            Text("Request for going outside the geofence")
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            Spacer()
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        VStack(alignment: .leading){
                            Text("Reason")
                                .font(ConstantClass.AppFonts.light)
                                .foregroundColor(.black)
                                .padding(.leading, 5.0)
                            
                            
                            //    Text("Reason", text: $description)
                            
                            
                            Text("Need to get glue to fix the roof ceiling of the new construction site ASAP ")
                            
                                .padding(.leading, 5.0)
                                .multilineTextAlignment(.leading)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                .lineLimit(100)
                                .frame(width:ConstantClass.Emptytextfield.textdescriptionwidth, height: ConstantClass.Emptytextfield.textdescriptionheight)
                                .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                .overlay(
                                    ConstantClass.Emptytextfield.getOverlay()
                                )
                            
                        }
                        
           
                        
                        VStack(spacing: 15){
                            
                            Button(action: {
                                // Add your sign-in action here
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Accept")
                                        .foregroundColor(.white)
                                        .font(ConstantClass.AppFonts.medium)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                            .background(Color.greenapp)
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                            Button(action: {
                                // Add your sign-in action here
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Reject")
                                        .foregroundColor(.white)
                                        .font(ConstantClass.AppFonts.medium)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                            .background(Color.red)
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                            
                        }
                        
                        
                        
                        
                        
                    }
                    Spacer()
                }
                
                .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
            }
        }
            
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)

    }
}

#Preview {
    SuperRequestForGeofence()
}
