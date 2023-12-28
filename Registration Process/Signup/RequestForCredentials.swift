//
//  RequestForCredentials.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 04/01/24.
//

import SwiftUI

struct RequestForCredentials: View {
   
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    
    @State var showLangpicker: Bool = false
    @State var langname : String? = nil
    
    @State private var mainview = false
    @Environment(\.presentationMode) var presentationMode
    @State private var Loginshow = false
    @StateObject var  reqcredenVM = RequestForCredentialVM()

    @StateObject var statuscheck = CompanylistbyemailVMgoogle()

   
    @State  var message = String()
    @State  var showingAlert = false
    
    @State var value: String?
    @State var value1 = ""
    var placeholder = "Select Company"
    
    @ObservedObject var  Companylistbyemailview = CompanylistVM()

    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                
                VStack(spacing: 20){
                    
                    Spacer()

                    VStack(spacing:10){
                        
                        VStack{
                            
                            HStack(alignment: .center ){
                                
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                    
                                })
                                {
                                    Image("Arrow Left-8")
                                        .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                        .padding(.leading, 10)
                                    
                                }
                                
                                Spacer()
                                
                                Text("Request Credentials")
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                
                            }
                        
                           // .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            
                            VStack {
                                Text("Fill in the following mandatory information")
                                    .font(ConstantClass.AppFonts.lighttextsize).foregroundColor(Color(.maincolorlbue))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                Text("to get the credentials")
                                    .font(ConstantClass.AppFonts.lighttextsize)                                 .foregroundColor(Color(.maincolorlbue))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                            }
                            
                        }
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 20){
                                 
                                VStack{
                                    
                                    VStack(alignment: .leading){
                                        Text("Full name")
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5.0)
                                        //         TextField(text: $reqcredenVM.fullname)
                                        TextField("", text: $reqcredenVM.fullname)
                                            .padding(.leading, 5.0)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                            .overlay(
                                                ConstantClass.Emptytextfield.getOverlay()
                                            )
                                        
                                    }
                                    
                                    if (reqcredenVM.showError && ((reqcredenVM.errorState).object(forKey: "fullName") != nil)){
                                        if let emailErrors = reqcredenVM.errorState["fullName"] as? [String], !emailErrors.isEmpty {
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
                                    VStack(alignment: .leading){
                                        Text("Email Address")
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5.0)
                                        //                                TextField(text: $reqcredenVM.fullname)

                                        TextField("", text: $reqcredenVM.email)
                               
                                             .padding(.leading, 5.0)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                            .overlay(
                                                ConstantClass.Emptytextfield.getOverlay()
                                            )
                                     
                                    }
                                    if (reqcredenVM.showError && ((reqcredenVM.errorState).object(forKey: "emailAddress") != nil)){
                                        if let emailErrors = reqcredenVM.errorState["emailAddress"] as? [String], !emailErrors.isEmpty {
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
                                    VStack(alignment: .leading){
                                        Text("Phone number")
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5.0)
                                        
                                        //                                TextField(text: $reqcredenVM.fullname)
                                        TextField("", text: $reqcredenVM.Phonenumber, onCommit: {
                                            // Handle the action when return key is pressed, for example resigning the keyboard
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        })
                                        .padding(.leading, 5.0)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        .frame(width: ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                        .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                        .overlay(ConstantClass.Emptytextfield.getOverlay())
                                        .keyboardType(.numberPad)


                                    }
                                    
                                    if (reqcredenVM.showError && ((reqcredenVM.errorState).object(forKey: "phoneNo") != nil)){
                                        if let emailErrors = reqcredenVM.errorState["phoneNo"] as? [String], !emailErrors.isEmpty {
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
                                    VStack(alignment: .leading){
                                        Text("Social Security number")
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5.0)
                                        
                                        //                                TextField(text: $reqcredenVM.fullname)
                                        TextField("", text: $reqcredenVM.SSN)
                                            .padding(.leading, 5.0)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                            .overlay(
                                                ConstantClass.Emptytextfield.getOverlay()
                                            )
                                    }
                                    if (reqcredenVM.showError && ((reqcredenVM.errorState).object(forKey: "ssn") != nil)){
                                        if let emailErrors = reqcredenVM.errorState["ssn"] as? [String], !emailErrors.isEmpty {
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
                                    
                                    VStack(alignment: .leading){
                                        Text("Company name")
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5.0)
                                        
                                    HStack {
                                            Menu {
                                                ForEach(Companylistbyemailview.Comapanyname, id: \.self) { company in
                                                    Button(action: {
                                                        self.value1 = company
                                                        if let index = self.Companylistbyemailview.Comapanyname.firstIndex(of: company) {
                                                            let companyId = self.Companylistbyemailview.CompanyID[index]
                                                            self.reqcredenVM.companyId = String(companyId)
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
                                                        Text(value1.isEmpty ? "Select company" : value1)
                                                            .foregroundColor(value1.isEmpty ? .black.opacity(0.3) : .black)
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

                                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(5))
                                        
                                        .background(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                        
                                    }
                                    
                                    
                                    if (reqcredenVM.showError && ((reqcredenVM.errorState).object(forKey: "companyId") != nil)){
                                        if let emailErrors = reqcredenVM.errorState["companyId"] as? [String], !emailErrors.isEmpty {
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
                                    VStack(alignment: .leading){
                                        Text("Emergency number")
                                            .padding(.leading, 5.0)
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.gray)
                                        
                                        //                                TextField(text: $reqcredenVM.fullname)
                                        
                                        TextField("", text: $reqcredenVM.EmergencyNumber, onCommit: {
                                            // Handle the action when return key is pressed, for example resigning the keyboard
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        })
                                        .padding(.leading, 5.0)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                            .overlay(
                                                ConstantClass.Emptytextfield.getOverlay()
                                            )
                                            .keyboardType(.numberPad)
                                        
                                      
                                    }
                                    if (reqcredenVM.showError && ((reqcredenVM.errorState).object(forKey: "emergencyNumber") != nil)){
                                        if let emailErrors = reqcredenVM.errorState["emergencyNumber"] as? [String], !emailErrors.isEmpty {
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
                        }
                    }
                    
                    
                    Button(action: {
                        // Add your sign-in action here
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                    reqcredenVM.RequestCred()
               
                    }) {
                        HStack {
                            Spacer()
                            Text("Send Request")
                                .foregroundColor(.white)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            Spacer()
                        }
                    }
                    .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                    .onTapGesture {
        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                      reqcredenVM.RequestCred()
                        
                    }
                    .background(Color.accentColor)
                    .cornerRadius(6)
                    .padding(.bottom, 20)
                }
                
//                 .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                .onAppear(){
                    Companylistbyemailview.Companylistbyemail()
                }
                
                
                if reqcredenVM.isShowingPopup == true  {
                    
                    ZStack {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                        
                        GeometryReader { geometry in
                            
                            VStack{
                                VStack(spacing: 30){
                                    
                                    
                                    
                                    VStack {
                                        Text("Your Request has been sent")
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                            .font(ConstantClass.AppFonts.light)
                                        Text("to the Admin. ")
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                            .font(ConstantClass.AppFonts.light)
                                        
                                    }
                                    
                                    
                                    VStack {
                                        
                                        Text("You will be notified on your given email with")
                                            .foregroundColor(.darkgray)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                        Text("credentials. once your profile is created")
                                            .foregroundColor(.darkgray)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                    }
                                    
                                    //   Spacer()
                                    
                                    Button(action: {
                                        // Add your sign-in action here
                                        //     isShowingPopup = false
                                        Loginshow.toggle()
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
                                        Loginshow.toggle()
                                        
                                    }
                                    
                                    .fullScreenCover(isPresented: $Loginshow, content: {
    
                                        Login()
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
            
            
        }
        
    }
}


//struct Companynamepicker: View {
//    
//    @Binding var value: String?
//    @State var value1 = ""
//    @Binding var showCompanyPicekr: Bool
//    
//    @ObservedObject var  Companylistbyemailview = CompanylistVM()
//
//   
//    let companyList = ["Company A", "Company B", "Company C, Company 8"]
//    var placeholder = ""
//    @StateObject var  reqcredenVM = RequestForCredentialVM()
//
//    
//    var body: some View {
//        
//        
//        HStack{
//            
//            
//            Menu {
//                ForEach(Companylistbyemailview.Comapanyname, id: \.self) { company in
//                    Button(action: {
//                        self.value1 = company
//                        if let index = self.Companylistbyemailview.Comapanyname.firstIndex(of: company) {
//                            let companyId = self.Companylistbyemailview.CompanyID[index]
//                            self.reqcredenVM.companyId = String(companyId)
//                            print("Selected company ID for \(company): \(companyId)")
//                        }
//                    }) {
//                        Text(company)
//                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                            .padding(.leading, 5.0)
//                    }
//                }
//            } label: {
//                VStack(spacing: 5) {
//                    HStack {
//                        Text(value1.isEmpty ? (Companylistbyemailview.Comapanyname.first ?? placeholder) : value1)
//                            .foregroundColor((value1.isEmpty && Companylistbyemailview.Comapanyname.first == nil) ? .black.opacity(0.3) : .black)
//                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                            .padding(.leading, 5.0)
//                        Spacer()
//                        
//                        Image(systemName: "chevron.down")
//                            .foregroundColor(Color.gray)
//                            .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
//                            .padding(.trailing, 5.0)
//                    }
//                }
//            }
//        }
//        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(5))
//        
//        .background(
//            RoundedRectangle(cornerRadius: 6)
//                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//        )
//    }
//    
//}

#Preview {
    RequestForCredentials()
}
