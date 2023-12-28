//
//  RequestforGeofenceoutside.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 09/01/24.
//

import SwiftUI


struct RequestforGeofenceoutside: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var obs = RequesttogooutsideVM()
   @State  var textStyle = UIFont.TextStyle.body
    @StateObject var statuscheck = CompanylistbyemailVMgoogle()


    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    VStack {
                        VStack(spacing: 50.0) {
                            HStack(alignment: .center, spacing: 10) {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
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
                            
                            VStack(alignment: .leading) {
                                Text("Please enter Reason")
                                    .font(ConstantClass.AppFonts.light)
                                    .foregroundColor(.black)
                                    .padding(.leading, 5.0)
                                
                                TextView(text: $obs.Reason, textStyle: $textStyle)
                                    .padding(.leading, 5.0)
                                    .multilineTextAlignment(.leading)
                                    .font(ConstantClass.AppFonts.light)
                                    .frame(width: ConstantClass.Emptytextfield.textdescriptionwidth, height: ConstantClass.Emptytextfield.textdescriptionheight)
                                    .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                    .overlay(
                                        ConstantClass.Emptytextfield.getOverlay()
                                    )
                            }
                            if statuscheck.homemodel?.isOutside == true {
                                
                                Button(action: {
                                    
                                    obs.statuscheckdata = "COME-INSIDE"
                                    obs.outsiderequestAPi {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Close Request")
                                            .foregroundColor(.white)
                                            .font(ConstantClass.AppFonts.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(7))
                                .background(Color.red)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    obs.outsiderequestAPi {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                     
                            }
                            else {
                                Button(action: {
                                    obs.statuscheckdata = "GO-OUTSIDE"

                                    obs.outsiderequestAPi {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Send Request")
                                            .foregroundColor(.white)
                                            .font(ConstantClass.AppFonts.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(7))
                                .background(Color.accentColor)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    obs.outsiderequestAPi {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                
                            }
                                
                                
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onAppear(){
                statuscheck.GetallStatus()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}





#Preview {
    RequestforGeofenceoutside()
}
