//
//  SideMenuCellView.swift
//  AttendenceSystem
//
//  Created by Misha Infotech on 09/11/2022.
//

import SwiftUI
import WebKit


struct SideMenuCellView: View {
    @Binding var wdith: CGFloat
    @Binding var x: CGFloat
    @State var showPopup = false
    @State var showApplyLeave = false
    @State var showUpdateProfile = false
    @State var showMyEmployee = false
    @State var showAttendance = false
    @State var showtimesheet = false

    @State var showTimeSheet = false
    @State var showChangePassword = false
    @State var showPrivacyPolicy = false
    @State var showTermCondition = false
    @State var showHelpFeedback = false
    @State var appLogout = false
    @State var  iscomingfromsidemenu = false
    // var myleave = true
    @State private var showWebView = false
   // @available(iOS 15, *)
    var body: some View {
        //NavigationView{
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack (alignment: .leading, spacing: 11){
                        VStack(alignment: .leading, spacing: 12){
                            //                            HStack{
                            //                                Image("myleave")
                            //                                    .resizable()
                            //                                    .frame(width: 25.0, height: 25.0)
                            //
                            //                                Text("Appply Leave")
                            //                                    .foregroundColor(.white)
                            //                                    .font(.custom("Poppins-Black-Medium", size: 16))
                            //                                Spacer()
                            //                            }
                            //                            .onTapGesture {
                            //                                showApplyLeave.toggle()
                            //                            }
                            //
                            //                            .fullScreenCover(isPresented: $showApplyLeave, content: {
                            //                                ApplyForLeaveView()
                            //                            })
                            
                            //                HStack{}
                            //                    .frame(width: wdith - 80 ,height: 0.5)
                            //                .background(Color.white)
                            //                            Divider()
                            //                                .overlay(Color.white)
                            HStack{
                                Image("Vector (8)")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("Update Profile")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))
                                Spacer()
                                
                            }
                            .onTapGesture {
                                showUpdateProfile.toggle()
                                iscomingfromsidemenu.toggle()
                            }
                            
                            .fullScreenCover(isPresented: $showUpdateProfile, content: {
                                EditProfileUIVIew(FromWhere : "S")
                            })
                            
                            //                HStack{}
                            //                .frame(width: wdith - 80, height: 0.5)
                            //                .background(Color.white)
                            Divider()
                                .overlay(Color.white)
                            HStack{
                                Image("employee")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("My Employee")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))
                                Spacer()
                                
                            } .onTapGesture {
                               
                                showMyEmployee.toggle()
                            }
                            
                            .fullScreenCover(isPresented: $showMyEmployee, content: {
                            EmployeeDetailsList()
                            })
                            
                            
                        }
                        .padding(.vertical, 10.0)
                        .padding(.horizontal, 20.0)
                        .frame(width: wdith - 40)
                        .background(Color.gray)
                        .cornerRadius(10)
                        //.border(Color.white, width: 0.5)
                        
                        
                        VStack(alignment: .leading, spacing: 12){

                            
                            HStack{
                               Image("timesheet")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("TimeSheet")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))
                            }
//                            }.onTapGesture {
//                                showtimesheet.toggle()
//                            }
//
//                            .fullScreenCover(isPresented: $showtimesheet, content: {
//                                Timesheet()
//                            })
                            
                            
                            .onTapGesture {
                                showtimesheet.toggle()
                                           //    UserDefaults.standard.removeObject(forKey: "isTimesheetSubmitted")

                            }
                            
                            .fullScreenCover(isPresented: $showtimesheet, content: {
                                TimesheetData()
                                
                            })
                            
                            
                    Divider()
                .overlay(Color.white)
                            
                            HStack{
                                Image("password 1")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("Change Password")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))
                            }
                            .onTapGesture {
                                showChangePassword.toggle()
                            }
                            
                            .fullScreenCover(isPresented: $showChangePassword, content: {
                                ResetPasswordScreen()
                            })
                            
                        }
                        .padding(.vertical, 10.0)
                        .padding(.horizontal, 20.0)
                        .frame(width: wdith - 40)
                        .background(Color.gray)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 12){
                            HStack{
                                Image("pp")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("Privacy Policy")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))

                            }
                            .onTapGesture {
                                showPrivacyPolicy.toggle()
                            }
                            

                            .fullScreenCover(isPresented: $showPrivacyPolicy, content: {
                                PrivacyPolicy()
                            })
                            
                            Divider()
                                .overlay(Color.white)
                            
                            HStack{
                                Image("tnc")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("Terms & Conditions")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))
                                
                            }
                            .onTapGesture {
                                showTermCondition.toggle()
                            }
                            
                            .fullScreenCover(isPresented: $showTermCondition, content: {
                           //     if #available(iOS 15, *) {
                                    termsandCondition()
                                //} else {
                                    // Fallback on earlier versions
                               // }
                            })
                            
                            Divider()
                                .overlay(Color.white)
                            
                            HStack{
                                Image("info-circle")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("Help & Feedback")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))
                                
                            }
                            .onTapGesture {
                                showHelpFeedback.toggle()
                            }
                            
                            .fullScreenCover(isPresented: $showHelpFeedback, content: {
                                helPCwenter()
                            })
                            
                        }
                        .padding(.vertical, 10.0)
                        .padding(.horizontal, 20.0)
                        .frame(width: wdith - 40)
                        .background(Color.gray)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Image("sign-out 1")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text("Logout")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Black-Medium", size: 16))
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.horizontal, 20.0)
                            .frame(width: wdith - 40, height: 61)
                            .background(Color.gray)
                            .cornerRadius(10)
                            
                            .onTapGesture {
//                                UserDefaults.standard.removeObject(forKey: "login")
//                                //  UserDefaults.standard.set("", forKey: "login")
//
                                appLogout.toggle()
                                
                        let shared = PersistenceController()
                        shared.deleteAllData()
                                print("Error deleting all data")

//                                PersistenceController.deleteAllData(<#T##self: PersistenceController##PersistenceController#>)
//                                PersistenceController.deleteAllData(name : "EmployeeListViewTable")
//                               deleteAllData(name : String?)
                                
                            }
                            
                            .fullScreenCover(isPresented: $appLogout, content: {
                                LoginScreen()
                            })
                            
                            //
                        }
                    }
                    .padding(.top, 10.0)
                    .padding(.bottom, 20.0)
                    .frame(width: wdith)
                    .background(Color.black)
                    
                }
            }
        }.navigationBarHidden(true)
    }

}
 
struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
