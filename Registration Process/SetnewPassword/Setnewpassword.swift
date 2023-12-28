//
//  Setnewpassword.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 02/01/24.
//

import SwiftUI
import AEOTPTextField


import Combine
struct Setnewpassword: View {
    @State var heightplus : CGFloat = 35
    let emailtextlimit = 50
    @StateObject var setpasswordVM = SetnewpasswordVM()
    @Environment(\.presentationMode) var presentationMode
    

    @State private var isPasswordVisible = false
    @State private var isconfirmPasswordVisible = false
    @State var companyidsetnewpass : String


   // @ObservedObject var setpasswordVM = SetPasswordViewModel()


    @State private var alertIsPresented: Bool = false
  
    var body: some View {
        
        NavigationView{
            
            ZStack{
                // Add a Spacer with a minimum length of 50
                GeometryReader { geometry in
                    VStack(spacing:50){
                        
                        VStack(spacing:20){
                            VStack(spacing:10){
                                
                                
                                HStack(){
                                    
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                        
                                    })
                                    {
                                        Image("Arrow Left-8")
                                            .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                        
                                    }
                                    
                                    Spacer()
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                
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
                                            TextField("Enter new Password", text: $setpasswordVM.newpassword)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        } else {
                                            SecureField("Enter new Password", text: $setpasswordVM.newpassword)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
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
                                    if (setpasswordVM.showError && ((setpasswordVM.errorState).object(forKey: "newPassword") != nil)){
                                        if let emailErrors = setpasswordVM.errorState["newPassword"] as? [String], !emailErrors.isEmpty {
                                            ForEach(emailErrors, id: \.self) { errorMessage in
                                                HStack(spacing: 15) {
                                                    Text(errorMessage)
                                                        .foregroundColor(.red)
                                                        .padding(.leading, 16)
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
                                            TextField("Confirm Password", text: $setpasswordVM.confirmpassword)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        } else {
                                            SecureField("Confirm Password", text: $setpasswordVM.confirmpassword)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
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
                                    
                                    if (setpasswordVM.showError && ((setpasswordVM.errorState).object(forKey: "confirmPassword") != nil)){
                                        if let emailErrors = setpasswordVM.errorState["confirmPassword"] as? [String], !emailErrors.isEmpty {
                                            ForEach(emailErrors, id: \.self) { errorMessage in
                                                HStack(spacing: 15) {
                                                    Text(errorMessage)
                                                        .foregroundColor(.red)
                                                        .padding(.leading, 16)
                                                        .multilineTextAlignment(.leading)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            VStack{
                                
                                VStack(alignment: .leading) {
                                
                                    AEOTPView(text: $setpasswordVM.otp) {
                                        alertIsPresented = true
                                    }
                                    //: AEOTPView
                                     .padding()
                                    
                                    Spacer()
                                } //: VStack
//                                .alert(isPresented: $alertIsPresented) {
////                                    setpasswordVM.setnewpassword()
//
//                                }
                              .frame(height: 50)
                               // .padding()
                                
                                
                                
                                if (setpasswordVM.showError && ((setpasswordVM.errorState).object(forKey: "OtpValue") != nil)){
                                    if let emailErrors = setpasswordVM.errorState["OtpValue"] as? [String], !emailErrors.isEmpty {
                                        ForEach(emailErrors, id: \.self) { errorMessage in
                                            HStack(spacing: 15) {
                                                Text(errorMessage)
                                                    .foregroundColor(.red)
                                                    .padding(.leading, 20)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                                
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                               
                                
                            }
                            
                            
                            Button(action: {
                                // Add your sign-in action here
                                
                                setpasswordVM.companyId = companyidsetnewpass
                                
                                setpasswordVM.setnewpassword()
                                
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
                                setpasswordVM.companyId = companyidsetnewpass

                                setpasswordVM.setnewpassword()
                            }
                            
                            .fullScreenCover(isPresented: $setpasswordVM.mainview, content: {
                                
                                
                                
                                Login()
                            })
                            
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
                        
 .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                        
                    }
                }
                
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
            
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
        //    func limitText(_ upper: Int) {
        //
        //        if newpassword.count > upper {
        //            newpassword = String(newpassword.prefix(upper))
        //        }
        //    }
        
        
    }
//    
//    private var otpAlert: Alert {
//   
//
//        
//        setpasswordVM.setnewpassword()
//
//        
//        
//    }
//
    private func setFirstResponder() {
          DispatchQueue.main.async {
              UIApplication.shared.sendAction(
                  #selector(UIResponder.becomeFirstResponder),
                  to: nil,
                  from: nil,
                  for: nil
              )
          }
      }
}


extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}








#Preview {
    Setnewpassword(companyidsetnewpass: "")
}


