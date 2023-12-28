//
//  SuperDashboard.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 04/01/24.
//

import SwiftUI

struct SuperDashboard: View {
    
    @State private var Supertasklist = false
    @State private var Superworkerrequest = false
    @State private var timesheetshow = false
    @State private var WorkkerCheckin = false

    @State private var showAlert = false
    @State private var Logoutshow = false
    @StateObject var WorkerCheckvm = WorkerCheckinVM()
    
    @State  var showAlert2 = false

    @State private var showhomeview = false
    @ObservedObject var  obs = WorkerdashbaordVM()

    @ObservedObject var statuscheck = CompanylistbyemailVMgoogle()
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false){
                        
                        VStack(spacing: 30){
                            
                            VStack(spacing: 15){
                                HStack(spacing: 15){
                                    
                                    VStack (spacing: 20){
                                        Text("Total Tasks")
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        //      .padding()
                                        
                                        Text(String(obs.superdas?.totalTasks ?? 0))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        //                                                .padding()
                                    }
                                    .frame(width: (Responsiveframes.widthPercentageToDP(85))/2,height: Responsiveframes.heightPercentageToDP(12))
                                    
                                    
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.25)
                                            .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                    )
                                    
                                    VStack (spacing: 20){
                                        Text("Tasks completed")
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        //                                                .padding()
                                        
                                        Text(String(obs.superdas?.totalCompletedTasks ?? 0))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        //                                                .padding()
                                        
                                    }
                                    .frame(width: (Responsiveframes.widthPercentageToDP(85))/2,height: Responsiveframes.heightPercentageToDP(12))
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.25)
                                            .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                    )
                                }
                                
                                .padding()
                                .frame(width: (Responsiveframes.widthPercentageToDP(85))/2,height: Responsiveframes.heightPercentageToDP(12))
                                
                                HStack(spacing: 15){
                                    
                                    VStack (spacing: 20){
                                        Text("Total Workers")
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        //                                                .padding()
                                        Text(String(obs.superdas?.totalWorkers ?? 0))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        //                                                .padding()
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(85)/2,height: Responsiveframes.heightPercentageToDP(12))
                                    
                                    
                                    
                                    .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.25)
                                            .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                    )
                                    
                                    VStack (spacing: 20){
                                        Text("Workers Checked-in")
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        //   .padding()
                                        
                                        Text(String(obs.superdas?.totalCheckedInWorkerToday ?? 0))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        
                                        // .padding()
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(85)/2,height: Responsiveframes.heightPercentageToDP(12))
                                    
                                    //.cornerRadius(10)
                                    .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.25)
                                            .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                    )
                                    
                                }
                                .padding()
                                .frame(width: (Responsiveframes.widthPercentageToDP(85))/2,height: Responsiveframes.heightPercentageToDP(12))
                                
                            }
                            
                            
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            
                            
                            VStack(spacing: 15){
                                
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    WorkkerCheckin.toggle()
                                    
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Showworkercheckin"), object: self)
                                    
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Break  or  Check out")
                                            .foregroundColor(.white)
                                            .font(ConstantClass.AppFonts.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(7))
                                .background(Color.greenapp)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                
                                .onTapGesture {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Showworkercheckin"), object: self)
                                }
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    Supertasklist.toggle()
                                    
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Tasks")
                                            .foregroundColor(.white)
                                            .font(ConstantClass.AppFonts.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(7))
                                .background(Color.lightblue)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    
                                    
                                    Superworkerrequest.toggle()
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Workers Requests")
                                            .foregroundColor(.white)
                                            .font(ConstantClass.AppFonts.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(7))
                                .background(Color.lightblue)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    timesheetshow.toggle()
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Working Time")
                                            .foregroundColor(.white)
                                            .font(ConstantClass.AppFonts.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(7))
                                .background(Color.lightblue)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                
                            }
                        }
                        
                        
                        
                        
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Activation Required"),
                                message: Text("Your ID is not activated. Please connect with the administrator."),
                                dismissButton: .default(Text("OK")) {
                                    // Your existing code to handle the OK button action
                                    WorkerCheckvm.LogoutAPI()
                                    clearUserData()
                                    if let window = UIApplication.shared.windows.first {
                                        window.rootViewController = UIHostingController(rootView: ContentView())
                                        window.makeKeyAndVisible()
                                    }
                                }
                            )
                        }
                        
                        
                        
                    }
                    
                    
                    .onAppear(){
                        
                        if UserDefaults.standard.bool(forKey: "status") == false {
                            
                            showAlert = true
                        }
                        
                        if UserDefaults.standard.integer(forKey: "workforceId") == 0{
                            
                            showAlert2 = true
                        }
                        
                        statuscheck.GetallStatus()
                        obs.getsuperwprker()
                        
                    }
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry
                    
                    NavigationLink(destination: SuperTaskList(taskId: 0), isActive: $Supertasklist) { EmptyView() }
                    NavigationLink(destination: HomeView(), isActive: $showhomeview) { EmptyView() }
                    NavigationLink(destination: SuperWorkerRequest(), isActive: $Superworkerrequest) { EmptyView() }
                    NavigationLink(destination: SuperTimesheet(), isActive: $timesheetshow) { EmptyView() }
                    
                        .fullScreenCover(isPresented: $Logoutshow, content: {
                            Login()
                        })
                    
                    
                }
            }
            
            .alert(isPresented: $showAlert2) {
                Alert(
                    title: Text("WorkForce Not Assigned"),
                    message: Text("You don't have any assigned workforce. Please connect with your supervisor."),
                    dismissButton: .default(Text("OK")) {
                        // Your existing code to handle the OK button action
                        showhomeview.toggle()
                        
                        
                    }
                )
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        }   .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
    func clearUserData() {
        let deviceToken = UserDefaults.standard.string(forKey: "devicetoken")
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
        UserDefaults.standard.setValue(deviceToken, forKey: "devicetoken")
        
        UserDefaults.standard.removeObject(forKey: "login")

    }

}

#Preview {
    SuperDashboard()
}
