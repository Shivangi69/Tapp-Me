//
//  LoginsetPassowrd.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 31/01/24.
//

import SwiftUI

struct LoginsetPassowrd: View {
    
    @State private var newpassword: String = ""
    @State private var confirmpassword: String = ""
    @State var heightplus : CGFloat = 35
    let emailtextlimit = 50
    @State private var mainview = false
  
    @State private var isPasswordVisible = false
    @State private var isconfirmPasswordVisible = false
    
    @StateObject var loginsetpassword = LoginsetpaswordVM()
    @State private var otp: [String] = Array(repeating: "", count: 6)
    
    var body: some View {
        
        NavigationView {
        
        ZStack{
            // Add a Spacer with a minimum length of 50
            GeometryReader { geometry in
                VStack(spacing:50){
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height/40)
                    
                    VStack(spacing:20){
                        VStack(spacing:10){
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                            
                            Text("Set New Password")
                                .font(ConstantClass.AppFonts.light)
                                .foregroundColor(.black)
                            
                            Text("Please set the New Password to continue")
                                .font(ConstantClass.AppFonts.lighttextsize).foregroundColor(Color(.maincolorlbue))
                            
                        }
                        
                        VStack(spacing:20){
                            
                            
                            VStack{
                            HStack(spacing: 15){
                                Image("material-symbols_lock-outline")
                                    .resizable()
                                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                             
                                   if isconfirmPasswordVisible {
                                       TextField("Enter new Password", text: $loginsetpassword.newpassword)
                                           .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                   } else {
                                       SecureField("Enter new Password", text: $loginsetpassword.newpassword)
                                           .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                   }
                                   
                                   Spacer()
                                   
                                   Button(action: {
                                       isconfirmPasswordVisible.toggle()
                                                  }) {
                                                      Image(systemName: isconfirmPasswordVisible ?"eye.fill": "eye.slash.fill"  )
                                                          .foregroundColor(.primary)
                                                          .padding(.trailing, 8)
                                                  }
                                                  .buttonStyle(PlainButtonStyle())
                                   
                                
                            }
                            .padding( Responsiveframes.widthPercentageToDP(5))
                            .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                            .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 0.5))
                            if (loginsetpassword.showError && ((loginsetpassword.errorState).object(forKey: "newPassword") != nil)){
                                if let emailErrors = loginsetpassword.errorState["newPassword"] as? [String], !emailErrors.isEmpty {
                                    ForEach(emailErrors, id: \.self) { errorMessage in
                                        HStack(spacing: 15) {
                                            Text(errorMessage)
                                                .foregroundColor(.red)
                                              //  .padding(.leading, 16)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                            
                            VStack{
                                HStack(spacing: 15){
                                    Image("mdi_lock-check-outline")
                                        .resizable()
                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                
                                    if isPasswordVisible {
                                        TextField("Confirm Password", text: $loginsetpassword.confirmpassword)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                    } else {
                                        SecureField("Confirm Password", text: $loginsetpassword.confirmpassword)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                                       isPasswordVisible.toggle()
                                                   }) {
                                                       Image(systemName: isPasswordVisible ?"eye.fill": "eye.slash.fill"  )
                                                           .foregroundColor(.primary)
                                                           .padding(.trailing, 8)
                                                   }
                                                   .buttonStyle(PlainButtonStyle())
                                }
                                .padding( Responsiveframes.widthPercentageToDP(5))
                                .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height).overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 0.5))
                                if (loginsetpassword.showError && ((loginsetpassword.errorState).object(forKey: "confirmPassword") != nil)){
                                    if let emailErrors = loginsetpassword.errorState["confirmPassword"] as? [String], !emailErrors.isEmpty {
                                        ForEach(emailErrors, id: \.self) { errorMessage in
                                            HStack(spacing: 15) {
                                                Text(errorMessage)
                                                    .foregroundColor(.red)
                                             //       .padding(.leading, 16)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                                
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    
                    Button(action: {
                        // Add your sign-in action here
                    //    mainview.toggle()
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                        
                        loginsetpassword.loginsetnewpassword()
                        
                    }) {
                        HStack {
                            Spacer()
                            Text("Sign In")
                                .foregroundColor(.white)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            Spacer()
                        }
                    }
                    .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                        loginsetpassword.loginsetnewpassword()

                      //  mainview.toggle()
                      
                    }
                    
//                    .fullScreenCover(isPresented: $loginsetpassword.Mainview, content: {
//                        Mainview()
//                    })
//                    
                    .background(Color.accentColor)
                    
                    .cornerRadius(6)
                    Spacer()
                }
                .onAppear(){
                    
                    if UIDevice.current.hasNotch {
                        heightplus = 50
                    } else {
                        //... don't have to consider notch
                        heightplus = 20
                    }
                }
                
                
//                 .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                
            }
            
            
            if loginsetpassword.Mainview == true {
                
                ZStack {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                    
                    GeometryReader { geometry in
                        
                        VStack{
                            VStack(spacing: 30){
                                
                                
                                
                                VStack {
                                    Text("Password Changed")
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                        .font(ConstantClass.AppFonts.light)
                                    Text("Successfully ")
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                        .font(ConstantClass.AppFonts.light)
                                }
                                
                                VStack {
                                    
                                    Text("Your password has been successfully changed. ")
                                        .foregroundColor(.darkgray)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                    Text("You may now use this password for future logins.")
                                        .foregroundColor(.darkgray)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                }
                                
                                //   Spacer()
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    //     isShowingPopup = false
                                    mainview.toggle()
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("OK")
                                            .foregroundColor(.white)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        Spacer()
                                    }
                                }
                                .frame(width: ConstantClass.HstackTextFieldSize.width1,height: ConstantClass.HstackTextFieldSize.height1)
                                
                                .onTapGesture {
                                    mainview.toggle()
                                    
                                }
                                
                                .fullScreenCover(isPresented: $mainview, content: {
                                   Mainview()
                                })
                                
                                
                                .background(Color.accentColor)
                                .cornerRadius(6)
                                .frame(width: Responsiveframes.widthPercentageToDP(2) ,height: Responsiveframes.heightPercentageToDP(5))
                                
                            }
                            
                            .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(30))
                            
                            
                            .transition(.scale)
                            .animation(.spring())
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                            
                            
                            
                        }
                        .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))

                        
                        
                    }
                }
            }
            
        }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func limitText(_ upper: Int) {
        
        if newpassword.count > upper {
            newpassword = String(newpassword.prefix(upper))
        }
    }
    
}

#Preview {
    LoginsetPassowrd()
}

