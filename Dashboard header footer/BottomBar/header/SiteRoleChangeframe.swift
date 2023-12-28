//
//  SiteRoleChangeframe.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct SiteRoleChangeframe: View {
    //  @State public var textPpText: String = "#PP10215"
    
    @State private var siteadmin = true
    
    @State private var worker = false
    
    
    var body: some View {
        if (UserDefaults.standard.bool(forKey: "Checkedin") == true) {
        if (UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR")  {
            
            HStack(alignment: .center, spacing: 10) {
                
                HStack{
                    
                    Button(" Supervisor "){
                        //   isShowingPopup = false
                        // isShowingPopup = false
                        UserDefaults.standard.setValue("SUPERVISOR", forKey: "Role")
                      //  UserDefaults.standard.setValue("SUPERVISOR", forKey: "MainRole")

                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)
                        
                        withAnimation {
                            siteadmin = true
                            worker = false
                        }
                        
                    }
                    .frame(width: (Responsiveframes.widthPercentageToDP(45))/2,height: Responsiveframes.heightPercentageToDP(5))
                    
                    .background(siteadmin ? Color.white :  Color.lightblue)
                    
                    .foregroundColor(.black)
                    
                    // .background(Color.white)
                    .cornerRadius(6)
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                    
                    .onTapGesture {
                        UserDefaults.standard.setValue("SUPERVISOR", forKey: "Role")
                      //  UserDefaults.standard.setValue("SUPERVISOR", forKey: "MainRole")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)
                        
                        siteadmin  = true
                        worker = false
                    }
                    
                    Spacer()
                    
                    Button(" Worker "){
                        
                        UserDefaults.standard.setValue("WORKER", forKey: "Role")
                     //   UserDefaults.standard.setValue("WORKER", forKey: "MainRole")

                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)
                        worker = true
                        siteadmin=false
                        
                    }
                    .frame(width: (Responsiveframes.widthPercentageToDP(45))/2,height: Responsiveframes.heightPercentageToDP(5))
                    .background(worker ? Color.white :  Color.lightblue)
                    
                    .foregroundColor(.black)
                    .cornerRadius(6)
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                    
                    
                    .onTapGesture {
                        UserDefaults.standard.setValue("WORKER", forKey: "Role")
                     //   UserDefaults.standard.setValue("WORKER", forKey: "MainRole")

                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)

                        worker = true
                        siteadmin=false
                    }
                    
                    
                }
                .frame(width: (Responsiveframes.widthPercentageToDP(50))/2)
                
                
            }
            .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
            .frame(width: (Responsiveframes.widthPercentageToDP(50)),height: Responsiveframes.heightPercentageToDP(6))
            .background(Color(red: 0.43, green: 0.64, blue: 1.00, opacity: 1.00))
            .cornerRadius(6)
            .onAppear(){
                if (UserDefaults.standard.string(forKey: "Role") == "WORKER"){
                    worker = true
                    siteadmin=false
                }else{
                    worker = false
                    siteadmin=true
                }
            }
        }
    }
    }
}



#Preview {
    SiteRoleChangeframe()
}
