//
//  Login.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 29/12/23.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseAuth
import CryptoKit
import AuthenticationServices
import GoogleSignIn
//import FacebookCore
import FBSDKLoginKit


struct Login: View {

    let emailtextlimit = 50
    
    @State private var isPasswordVisible = false
    
    @State var setnewpassword: Bool = false
    @State var reqforcredentials: Bool = false
    @StateObject var LoginVM = LoginViewModel()
    @StateObject var AuthServiceVM = UserAuthModel()
    //  @StateObject var Facebookauth = facebookauthmodel()
    //@StateObject var facebook = Facebookauth()
    
    @State private var isShowingPopup = false

//  @StateObject var Connectsociallogin = Connectsociallogin()

    @StateObject var ConnectgoogleVM = Connectsociallogin()

    

    @State var showotpbyforgotview: Bool = false

    @State private var isUsernameValid = false
    
    @State  var message = String()
    @State  var showingAlert = false
    
    @State var value: String?
    @State var value1 = ""
    var placeholder = "Select Company"
    @StateObject var  Companylistbyemailview = CompanylistbyemailVM()
    
    
    @StateObject var  complistggle = CompanylistbyemailVMgoogle()

    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                ScrollView(.vertical , showsIndicators: false){
                    
                    VStack(spacing:40.0){
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                            
                            Text("Welcome")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            
                            VStack {
                                Text("Login with credentials shared by")
                                
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
                                    TextField("Email Address", text: $LoginVM.email, onEditingChanged: { editing in
                                        if !editing && !LoginVM.email.isEmpty {
                                            Companylistbyemailview.email = LoginVM.email
                                            
                                            Companylistbyemailview.Companylistbyemail()
                                            
                                        }
                                    })
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    .padding(.leading, 5.0)

                                }
                                .padding( Responsiveframes.widthPercentageToDP(5))
                                
                                .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                                
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                )
                                
                                if (LoginVM.showError && ((LoginVM.errorState).object(forKey: "email") != nil)){
                                    if let emailErrors = LoginVM.errorState["email"] as? [String], !emailErrors.isEmpty {
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
                                                            self.Companylistbyemailview.defaultCompanyId = self.Companylistbyemailview.CompanyID[index]
                                                            self.LoginVM.companyId = String(self.Companylistbyemailview.defaultCompanyId)
                                                            
                                                            print("Selected company ID for \(company): \(self.Companylistbyemailview.defaultCompanyId)")
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
                                                        Text(value1.isEmpty ? (Companylistbyemailview.Comapanyname.first ?? "Select Company") : value1)
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
                                    }.onAppear(){
                                        //                                    if (self.Companylistbyemailview.CompanyID.count
                                        //                                        > 0){
                                        //                                        defaultCompanyId = self.Companylistbyemailview.CompanyID[0]
                                        //
                                        //                                    }
                                        
                                    }
                                    
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                    )
                                    if (LoginVM.showError && ((LoginVM.errorState).object(forKey: "companyId") != nil)){
                                        if let emailErrors = LoginVM.errorState["companyId"] as? [String], !emailErrors.isEmpty {
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
                         
                            
                            VStack{
                                HStack(spacing: 15) {
                                    Image("material-symbols_lock-outline")
                                        .resizable()
                                    
                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                    VStack {
                                        if isPasswordVisible {
                                            TextField("Password", text: $LoginVM.password)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        } else {
                                            SecureField("Password", text: $LoginVM.password)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        }
                                        
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
                                
                                .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                )
                                
                                
                                if (LoginVM.showError && ((LoginVM.errorState).object(forKey: "password") != nil)){
                                    if let emailErrors = LoginVM.errorState["password"] as? [String], !emailErrors.isEmpty {
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

                            HStack{
                                
                                Button(action: {
                                  
                                    setnewpassword.toggle()

                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Forgot password?")
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    }
                                }
                            }
                            .frame(width: ConstantClass.HstackTextFieldSize.width)
                               .onTapGesture {
                              
                                setnewpassword.toggle()

                            }
                            .fullScreenCover(isPresented: $setnewpassword, content: {
                                ForgotPassword()
                            })
                        }
                        
                        VStack(spacing: 30) {
                            Button(action: {
                         
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                                self.LoginVM.companyId = String(self.Companylistbyemailview.defaultCompanyId)
                                self.LoginVM.login()
                               
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

                                self.LoginVM.companyId = String(self.Companylistbyemailview.defaultCompanyId)

                                self.LoginVM.login()
                              
                            }
//                            .fullScreenCover(isPresented: $LoginVM.showMainscreen, content: {
//                                Mainview()
//                            })
                            
//                            .fullScreenCover(isPresented: $LoginVM.goingtoreset, content: {
//                                LoginsetPassowrd()
//                            })
                      
                            .background(Color.accentColor)
                            .cornerRadius(6)
                  
                            VStack(spacing: 10) {
                                Text("or Login with")
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                    .foregroundColor(.darkgray)
                                
                                HStack{
                                    Image("Asset 1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: Responsiveframes.widthPercentageToDP(12), height: Responsiveframes.widthPercentageToDP(12))
                                        .onTapGesture {
                           AuthServiceVM.googleSign()
                                      }
                                    Image("Asset 2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: Responsiveframes.widthPercentageToDP(12), height: Responsiveframes.widthPercentageToDP(12))
                                }
                                .onTapGesture{
                                  //  Facebookauth.FacebookLogin()


                                }
                            }
                            
                            Button(action: {
                                reqforcredentials.toggle()
                                clear()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Request for credentials")
                                        .foregroundColor(.blue)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    //   .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    Spacer()
                                }
                            }
                            .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(Color.clear)
                            )
                            .cornerRadius(6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color("lightblue"), lineWidth: 0.50)
                            )
                            .onTapGesture {
                                reqforcredentials.toggle()
                                clear()
                            }
                            
                            .fullScreenCover(isPresented: $reqforcredentials, content: {
                                RequestForCredentials()
                            })
                            
                        }
                    }
                    
                }
               .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                
                
                if AuthServiceVM.isShowingPopup  == true  {
                    
                    ZStack {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                        
                        GeometryReader { geometry in
                            
                            VStack{
                                VStack(spacing: 30){
                                    
                                    VStack(spacing: 20) {
                                        
                                        HStack{
                                        Spacer()
                                            Button(action: {
                                                  // Action to close the popup
                                                  self.AuthServiceVM.isShowingPopup = false
                                              }) {
                                                  Image(systemName: "xmark") // System image for the cross
                                                      .foregroundColor(.white) // Setting the icon color to white for contrast
                                                      .padding(10) // Add padding around the icon for easier tapping
                                                      .background(Color.blue) // Set the background color to blue
                                                      .clipShape(Circle()) // Making it circular
                                              }
                                              //.padding(.top, 10) // Adjust the padding to position the button inside the top corner of the popup
                                              //.padding(.trailing, 10), // Adjust accordingly
                                              //alignment: .topTrailing
                                        
                                        
                                    }
                                        .padding()
                                        
                                            VStack(alignment: .leading ) {
                                                
                                                Text("Please Select Company")
                                                    .font(ConstantClass.AppFonts.light)
                                                    .foregroundColor(.gray)
                                                    .padding(.leading, 5.0)
                                                
                                                
                                                HStack {
                                                    Image("Buildings")
                                                        .resizable()
                                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                    
                                                    Menu {
                                                        ForEach(complistggle.Comapanyname, id: \.self) { company in
                                                            Button(action: {
                                                                self.value1 = company
                                                                
                                    if let index = self.complistggle.Comapanyname.firstIndex(of: company) {
                                        self.complistggle.defaultCompanyId = self.complistggle.CompanyID[index]
                                       self.ConnectgoogleVM.companyId = self.complistggle.defaultCompanyId
                                                                    
                                    print("Selected company ID for \(company): \(self.complistggle.defaultCompanyId)")

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
                                                                Text(value1.isEmpty ? (complistggle.Comapanyname.first ?? placeholder) : value1)
                                                                    .foregroundColor((value1.isEmpty && complistggle.Comapanyname.first == nil) ? .black.opacity(0.3) : .black)
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
                                                
                                                .frame(width: ConstantClass.HstackTextFieldSize.w1,height: ConstantClass.HstackTextFieldSize.h1)
                                               // .animation(.linear)
                                                .transition(.opacity)
                                                .onTapGesture {
                                                    // Handle tap gesture if needed
                                                }
                                                
                                                .background(
                                                    RoundedRectangle(cornerRadius: 6)
                                                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                                )
                                                
                                                if (complistggle.showError && ((complistggle.errorState).object(forKey: "companyId") != nil)){
                                                    if let emailErrors = complistggle.errorState["companyId"] as? [String], !emailErrors.isEmpty {
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
                                        
                                         
                                            VStack {
                                                Button(action: {
                                                    self.ConnectgoogleVM.companyId = self.complistggle.defaultCompanyId
                                                    self.ConnectgoogleVM.logingoogle() // google in login
                                                   
                                                }) {
                                                    HStack {
                                                        Spacer()
                                                        Text("Sign In")
                                                            .foregroundColor(.white)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        //        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        Spacer()
                                                    }
                                                }
                                                .frame(width: ConstantClass.HstackTextFieldSize.w1,height: ConstantClass.HstackTextFieldSize.h1)
                                                
                                                .onTapGesture {
                                                    self.ConnectgoogleVM.companyId = self.complistggle.defaultCompanyId
                                                    self.ConnectgoogleVM.logingoogle() // google in login
                                                }
                                                .fullScreenCover(isPresented: $ConnectgoogleVM.shownextscreen1, content: {
                                                    LoginsetPassowrd()
                                                })
                                                
                                                .fullScreenCover(isPresented: $ConnectgoogleVM.goingtodashboard1, content: {
                                                    Mainview()
                                                })
                                          
                                                .background(Color.accentColor)
                                                .cornerRadius(6)
                                                Spacer()
                                    }
                                }
                                
                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(35))
                                       .transition(.scale)
                                       .animation(.spring())
                                       .background(
                                           RoundedRectangle(cornerRadius: 16)
                                               .fill(Color.white)
                                               .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                                       )
                                       .padding()
                                   }
                                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                                   
                                   Spacer()
                        }
                    }
                    .onAppear(){
                   //     clear()
                        complistggle.Companylist()
                        Companylistbyemailview.Companylistbyemail()
                    }
                }
            }
        }
        
        
        .onAppear(){
            clear()

        }
        
    }
    
    func clear() {
        LoginVM.companyId = ""
        LoginVM.email = ""
        LoginVM.password = ""

    }
    
    func limitText(_ upper: Int) {
        
        if LoginVM.password.count > upper {
            LoginVM.password = String(LoginVM.password.prefix(upper))
        }
    }
}



//struct LoginTextFieldStyle: TextFieldStyle {
//    func _body(configuration: TextField<_Label>) -> some View {
//        configuration
//            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//            .background(RoundedRectangle(cornerRadius: 6).stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)), lineWidth: 1))
//    }
//    
//}




class UserAuthModel: ObservableObject {
    
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    @Published  var isShowingPopup = false
    
  @StateObject var ConnectgoogleVM = Connectsociallogin()
    
  //  @StateObject var Loginsociallogin = Loginsociallogin()
    

    init(){
        check()
    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    
    
    
    
    func googleSign(){
        
        
        guard let presentingVC = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        // Start the sign in flow!
        let gIdConfiguration = GIDConfiguration(clientID: "437527695659-o8lqveo3daqdte521n9lbjejpel7lpu9.apps.googleusercontent.com")
        
        
        GIDSignIn.sharedInstance.configuration = gIdConfiguration
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { user, error in
            if let error = error {
                // Handle error if sign-in fails
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            // Extract user information
            let userId = user?.user.userID  // Get the unique user ID
            let fullName = user?.user.profile?.name  // Get the user's full name
            let givenName =  user?.user.profile?.givenName  // Get the user's first name
            let familyName =  user?.user.profile?.familyName  // Get the user's last name
            let email =  user?.user.profile?.email  // Get the user's email address (if available)
            
            // Print or use the retrieved user information as needed
            print("User Info:")
            print("- User ID: \(userId ?? "")")
            print("- Full Name: \(fullName)")
            print("- Given Name: \(givenName)")
            print("- Family Name: \(familyName)")
            print("- Email: \(email)")
            
            UserDefaults.standard.set(userId, forKey: "Providerid")
            UserDefaults.standard.set(email, forKey: "emailgoogle")
            
        //  self.ConnectgoogleVM.GoogleConnect() // googleconnect in setting
        
        
            if userId != "" {
                
                self.isShowingPopup.toggle()
                
            }
            
  
            
        }
    }
    
    
    
    
    
    
    
    
    
    func googleSignconnect(){
        
        
        guard let presentingVC = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        // Start the sign in flow!
        let gIdConfiguration = GIDConfiguration(clientID: "437527695659-o8lqveo3daqdte521n9lbjejpel7lpu9.apps.googleusercontent.com")
        
        
        GIDSignIn.sharedInstance.configuration = gIdConfiguration
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { user, error in
            if let error = error {
                // Handle error if sign-in fails
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            // Extract user information
            let userId = user?.user.userID  // Get the unique user ID
            let fullName = user?.user.profile?.name  // Get the user's full name
            let givenName =  user?.user.profile?.givenName  // Get the user's first name
            let familyName =  user?.user.profile?.familyName  // Get the user's last name
            let email =  user?.user.profile?.email  // Get the user's email address (if available)
            
            // Print or use the retrieved user information as needed
            print("User Info:")
            print("- User ID: \(userId ?? "")")
            print("- Full Name: \(fullName)")
            print("- Given Name: \(givenName)")
            print("- Family Name: \(familyName)")
            print("- Email: \(email)")
            
            UserDefaults.standard.set(userId, forKey: "Providerid")
            UserDefaults.standard.set(email, forKey: "emailgoogle")
            
           self.ConnectgoogleVM.GoogleConnect() // google in login

            
        }
    }
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Handle sign-out event
        print("User disconnected")
    }
    
}




class facebookauthmodel: ObservableObject {


    
    private let premission = ["public_profile", "email"] //added
    @State   var emailstr : String = ""
   //
    @State   var existornot : String = ""

    
    func FacebookLogin() {
         let fbLoginManager = LoginManager()
         fbLoginManager.logOut()
         fbLoginManager.logIn(permissions: premission, from: UIHostingController(rootView: Login())) { (result, error) in
             if let error = error {
                 print("Failed to login: \(error.localizedDescription)")
                 let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                 let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                 alertController.addAction(okayAction)
                 return
             }
             
             guard let _ = AccessToken.current else {
                 print("Failed to get access token")
                 return
             }
             
             if result?.isCancelled == true {
                 print("User canceled")
                 return
             }
             
             let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
             
             Auth.auth().signIn(with: credential, completion: { (user, error) in
                 if let error = error {
                     print("Login error: \(error.localizedDescription)")
                     let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                     let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                     alertController.addAction(okayAction)
                     print("asd")
                     return
                 }else{
                     print("userdetails",user!)
                     
                     GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email,age_range"]).start(completion: { (connection, result, error) -> Void in
                         if (error == nil){
                             let dict = result as! [String : AnyObject]
                             print(dict)
                             self.emailstr = dict["email"] as! String
                             print(self.emailstr)
                             UserDefaults.standard.set(self.emailstr, forKey: "Smail")
                             UserDefaults.standard.set(dict["name"] as! String, forKey: "Sname")
                             
                             //
                         //    self.checkuser()
                             
                             if let dict = result as? [String : AnyObject]{
                                 if(dict["email"] as? String == nil || dict["id"] as? String == nil || dict["email"] as? String == "" || dict["id"] as? String == "" ){
                                     
                                     
                                     
                                 }else{
                                     
                                 }
                             }
                             
                         }else{
                             
                         }
                     })
                 }
                 
                 return
                 
             })
         }
     }
    
}



class discinnectmodel: ObservableObject {
    
    @Published   var showview = false
 
    @Published  var statuschannel = String()
  
    
    func DisconnectGoogle() {
        
        let userID =  UserDefaults.standard.string(forKey: "id") ?? ""

        let str =  "auth/disconnect/account?userId=" + userID + "&providerType=" +  statuschannel

//    http://62.171.153.83:8080/tappme-api-development/auth/disconnect/account?userId=53&providerType=google

        
        AccountAPI.signinwithHeader(servciename: str , nil) { [self] res in
            
            switch res {
            case .success:
                if let json = res.value {
                    
                    print(json)
                    
                    if json["status"] == true {
                        let userdic = json["data"]
                        
                        // Extract the JWT token from your response
                        
                        if let msg = json["message"].string {
                            print("msg is \(msg)")
                            Toast(text: msg).show()
                        }
                        
                        
                 
                    }
                    
                    else {
                        
                        if let msg = json["message"].string {
                            print("msg is \(msg)")
                            Toast(text: msg).show()
                        }
                    
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
        
    }
    }



#Preview {
    Login()
}
