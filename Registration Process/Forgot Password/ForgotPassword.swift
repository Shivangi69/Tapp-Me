//
//  ForgotPassword.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 29/01/24.
//

import SwiftUI
import Combine

struct ForgotPassword: View {
    let emailtextlimit = 50
    
    @State var setnewpassword: Bool = false
    @State var reqforcredentials: Bool = false
    @StateObject var forgotVM = forgotViewModel()
    @State var showotpbyforgotview: Bool = false
    @State private var isUsernameValid = false
    
    @Environment(\.presentationMode) var presentationMode

    @State  var message = String()
    @State  var showingAlert = false
    
    @State var value: String?
    @State var value1 = ""
    var placeholder = "Select Company"
    
    @StateObject var  Companylistbyemailview = CompanylistbyemailVM()

    @State  var isShowingPopup1 = false


    @State  var showsetpasswordscreen = false

    var body: some View {
        
        ZStack {
            
            GeometryReader { geometry in
                ScrollView(.vertical , showsIndicators: false){
                    
                    VStack(spacing:40.0){
                        
                        VStack(spacing: 10) {
                            
                            
                            
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
                            
                            Text("Forgot Password?")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            VStack {
                                Text("Enter your Email shared by")
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.8)))
                                    .foregroundColor(Color(.maincolorlbue))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                
                                Text("your organization.")
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.8)))
                                    .foregroundColor(Color(.maincolorlbue))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                            }
                            
                        }
                        
                        VStack(spacing: 20) {
                            VStack{
                                HStack(spacing: 15) {
                                    Image("Letter")
                                        .resizable()
                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                    TextField("Email Address", text: $forgotVM.forgotemailid, onEditingChanged: { editing in
                                        if !editing && !forgotVM.forgotemailid.isEmpty {
                                           
                                            Companylistbyemailview.email = forgotVM.forgotemailid
                                            Companylistbyemailview.Companylistbyemail()
                                            UserDefaults.standard.set(forgotVM.forgotemailid, forKey: "forgotemail")

                                        }

                                    })
                                   // .padding(.leading, 5.0)
                                }
                                .padding( Responsiveframes.widthPercentageToDP(5))
                                
                                .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                                
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                )
                                
                            
                                if (forgotVM.showError && ((forgotVM.errorState).object(forKey: "email") != nil)){
                                    if let emailErrors = forgotVM.errorState["email"] as? [String], !emailErrors.isEmpty {
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
                            
                            VStack {
                                HStack {
                                    Image("Buildings")
                                        .resizable()
                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                    
                                    Menu {
                                        ForEach(Companylistbyemailview.Comapanyname, id: \.self) { company in
                                            Button(action: {
                                                self.value1 = company
                                                
                                                if let index = self.Companylistbyemailview.Comapanyname.firstIndex(of: company) {
                                                    let companyId = self.Companylistbyemailview.CompanyID[index]
                                                    self.forgotVM.companyId = String(companyId)

                                                    UserDefaults.standard.setValue(forgotVM.companyId, forKey: "companyId")
                                                    print("Selected company ID for \(company): \(companyId)")
                                                }
                                            }) {
                                                Text(company)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    .padding(.leading, 5.0)
                                            }
                                        }
                                    } label: {
                                        VStack(spacing: 5) {
                                            HStack {
                                                Text(value1.isEmpty ? (Companylistbyemailview.Comapanyname.first ?? placeholder) : value1)
                                                    .foregroundColor((value1.isEmpty && Companylistbyemailview.Comapanyname.first == nil) ? .black.opacity(0.3) : .black)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    .padding(.leading, 5.0)
                                                Spacer()
                                                
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(Color.gray)
                                                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                    .padding(.trailing, 5.0)
                                            }
                                        }
                                    }
                                }

                                .padding( Responsiveframes.widthPercentageToDP(5))
                                
                                .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                               // .animation(.linear)
                                .transition(.opacity)
                                .onTapGesture {
                                    // Handle tap gesture if needed
                                }
                                
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                )
                                
                                if (forgotVM.showError && ((forgotVM.errorState).object(forKey: "companyId") != nil)){
                                    if let emailErrors = forgotVM.errorState["companyId"] as? [String], !emailErrors.isEmpty {
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
                        }
                        
                        
                        VStack(spacing: 30) {
                            Button(action: {
                                self.forgotVM.companyId = String(self.Companylistbyemailview.defaultCompanyId)
                        self.forgotVM.forgotpassword()
                            
                                clear()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Send OTP")
                                        .foregroundColor(.white)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    Spacer()
                                }
                            }
                            .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                            
                            .onTapGesture {
                                self.forgotVM.forgotpassword()
                                clear()
                                

                            }
                            .fullScreenCover(isPresented: $forgotVM.showsetpasswordscreen, content: {
                                Setnewpassword(companyidsetnewpass:   String(self.Companylistbyemailview.defaultCompanyId))
                            })
                            
                            .background(Color.accentColor)
                            .cornerRadius(6)
               
                        }
                    }
                    
                }
               .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
            }
        }
    }
    
    
    func clear() {
        value1 = ""
        value = ""
        forgotVM.forgotemailid = ""

        

    }
    
}





#Preview {
    ForgotPassword()
}
