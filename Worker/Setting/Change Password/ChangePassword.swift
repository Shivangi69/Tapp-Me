//
//  ChangePassword.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/02/24.
//

import SwiftUI

struct ChangePassword: View {
    
    
    @State private var newpassword: String = ""
    @State private var confirmpassword: String = ""
    @State var heightplus : CGFloat = 35
    let emailtextlimit = 50
    
    @State private var isPasswordVisible = false
    @State private var isconfirmPasswordVisible = false
    @State private var isoldpassword = false
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var changepassword = ChangepasswordVM()
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack{
                        
                   //     ScrollView(.vertical , showsIndicators: false){
                            VStack{
//                                    VStack(spacing:20){
                                    HStack(){
                                        
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        })
                                        {
                                            Image("Arrow Left-8")
                                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                        }
                                        
                                        Text("Change Password")
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                            .padding()
                                        
                                        Spacer()
                                    }
                                    
                                    VStack(spacing:20){
                                        
                                        VStack{
                                            HStack(spacing: 15){
                                                Image("material-symbols_lock-outline")
                                                    .resizable()
                                                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                
                                                if isoldpassword {
                                                    TextField("Enter Old Password", text: $changepassword.oldpassword)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                } else {
                                                    SecureField("Enter Old Password", text: $changepassword.oldpassword)
                                                        .font(Font.custom("Poppins-Black", size:           Responsiveframes.responsiveFontSize(1.6)))
                                                }
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    isoldpassword.toggle()
                                                }) {
                                                    Image(systemName: isoldpassword ?"eye.fill": "eye.slash.fill"  )
                                                        .foregroundColor(.primary)
                                                        .padding(.trailing, 5)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                
                                                
                                            }
                                            .padding( Responsiveframes.widthPercentageToDP(5))
                                            .frame(width: ConstantClass.HstackTextFieldSize.w1,height: ConstantClass.HstackTextFieldSize.height)
                                            .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 0.5))
                                            if (changepassword.showError && ((changepassword.errorState).object(forKey: "oldPassword") != nil)){
                                                if let emailErrors = changepassword.errorState["oldPassword"] as? [String], !emailErrors.isEmpty {
                                                    ForEach(emailErrors, id: \.self) { errorMessage in
                                                        HStack(spacing: 15) {
                                                            Text(errorMessage)
                                                                .foregroundColor(.red)
                                                                .padding(.leading, 15)
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
                                                Image("material-symbols_lock-outline")
                                                    .resizable()
                                                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                
                                                if isconfirmPasswordVisible {
                                                    TextField("Enter new Password", text: $changepassword.newpassword)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                } else {
                                                    SecureField("Enter new Password", text: $changepassword.newpassword)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                }
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    isconfirmPasswordVisible.toggle()
                                                }) {
                                                    Image(systemName: isconfirmPasswordVisible ?"eye.fill": "eye.slash.fill"  )
                                                        .foregroundColor(.primary)
                                                        .padding(.trailing, 5)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                
                                                
                                            }
                                            .padding( Responsiveframes.widthPercentageToDP(5))
                                            .frame(width: ConstantClass.HstackTextFieldSize.w1,height: ConstantClass.HstackTextFieldSize.height)
                                            .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 0.5))
                                            if (changepassword.showError && ((changepassword.errorState).object(forKey: "newPassword") != nil)){
                                                if let emailErrors = changepassword.errorState["newPassword"] as? [String], !emailErrors.isEmpty {
                                                    ForEach(emailErrors, id: \.self) { errorMessage in
                                                        HStack(spacing: 15) {
                                                            Text(errorMessage)
                                                                .foregroundColor(.red)
                                                                .padding(.leading, 15)
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
                                                    TextField("Enter Confirm Password", text: $changepassword.confirmpassword)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                } else {
                                                    SecureField("Enter Confirm Password", text: $changepassword.confirmpassword)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                }
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    isPasswordVisible.toggle()
                                                }) {
                                                    Image(systemName: isPasswordVisible ?"eye.fill": "eye.slash.fill"  )
                                                        .foregroundColor(.primary)
                                                        .padding(.trailing, 5)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }
                                            
                                            .padding( Responsiveframes.widthPercentageToDP(5))
                                            .frame(width: ConstantClass.HstackTextFieldSize.w1,height: ConstantClass.HstackTextFieldSize.height)
                                            .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 0.5))
                                            
                                            if (changepassword.showError && ((changepassword.errorState).object(forKey: "confirmPassword") != nil)){
                                                if let emailErrors = changepassword.errorState["confirmPassword"] as? [String], !emailErrors.isEmpty {
                                                    ForEach(emailErrors, id: \.self) { errorMessage in
                                                        HStack(spacing: 15) {
                                                            Text(errorMessage)
                                                                .foregroundColor(.red)
                                                                .padding(.leading, 15)
                                                                .multilineTextAlignment(.leading)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                                            
                                                            Spacer()
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        
                                        Button(action: {
                                            
                                            
                                            changepassword.changepassword {
                                                self.presentationMode.wrappedValue.dismiss()
                                                
                                            }
                                            
                                            
                                            
                                        }) {
                                            HStack {
                                                Spacer()
                                                Text("Change Password")
                                                    .foregroundColor(.white)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                Spacer()
                                            }
                                        }
                                        .frame(width: ConstantClass.HstackTextFieldSize.w1,height: ConstantClass.HstackTextFieldSize.height)
                                        .onTapGesture {
                                            changepassword.changepassword {
                                                self.presentationMode.wrappedValue.dismiss()
                                                
                                            }
                                            
                                        }
                                        
                                        .background(Color.accentColor)
                                        .cornerRadius(6)
                                        Spacer()
                                        
                                    }
                                    //.padding()
                                
                   
                                
                            }
                            
                            .frame(width: Responsiveframes.widthPercentageToDP(80))
                            .padding()
                            //  .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                            
                     //   }
                    }
                    
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .inset(by: 0.5)
                            .stroke(Color.black.opacity(0.15), lineWidth: 0.5)
                    )
                    
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
                    
                    
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry

             
                }
                
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        } .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        
        
    }
}

#Preview {
    ChangePassword()
}
