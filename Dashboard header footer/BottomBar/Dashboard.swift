//
//  Dashboard.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 29/12/23.
//

import SwiftUI


struct Dashboard: View {
    @Environment(\.presentationMode) var presentationMode
    @State var Showupdateprofile: Bool = false
    @State var Showchangepassword: Bool = false
    @State private var notificationshow = false
    @State private var ProfileView = false
    @State private var workercheckin = false
    @State private var showdashboard = false
    @State private var shownfcview = false
    
    
    
    @Binding var x : CGFloat
    @Binding var isDark: Bool
    @State var selectedIndex = 0
    @State var shouldShowModel = false
    
    
    var home_tab_RootView = HomeView()
    

    var body: some View {
        ZStack{
            VStack{
               
                
                
                VStack{
                    
                    
                    
                    ContainerGroup()
                    
                }
                
                Spacer()
                    .frame(height: 20)
                
                ZStack{
                    
                
                    switch selectedIndex {
                    case 0:
               
                              
                        if (UserDefaults.standard.bool(forKey: "Checkedin") == true) && (UserDefaults.standard.bool(forKey: "isCheckInApproved") == true)  {
                            
                            if (UserDefaults.standard.bool(forKey: "isBreak") == false) {
                                if (UserDefaults.standard.string(forKey: "Role") == "SUPERVISOR") &&                 (UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR") {
                                    SuperDashboard()
                                    
                                }
                                
                                else  {
                                    WorkerDashBoard()
                                    
                                }
                                
                            }
                            
                            else if (UserDefaults.standard.bool(forKey: "isBreak") == true) {
                                
                                WorkkerCheckin()
                            }
                        }
                        
                        
                        else if (UserDefaults.standard.bool(forKey: "Checkedin") == true) && (UserDefaults.standard.bool(forKey: "isCheckInApproved") == false) && (UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == true)   {
                            
                            if (UserDefaults.standard.string(forKey: "Role") == "SUPERVISOR") &&                 (UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR") {
                                SuperDashboard()
                                
                            }
                            
                            else  {
                                WorkerDashBoard()
                                
                            }

                        }
                     
                        else
                        
                        {
                            HomeView()
                            
                            
                        }
                         
                    case 1:
                        
                        if   ( UserDefaults.standard.string(forKey: "Role") ==  "WORKER"){
                              
                            WorkerTimeReport()
                        }
                        
                else {
                    
                    WorkerList()
                 }
                        
                        
                   
                    case 2:
                        
                        
                        
                        if   ( UserDefaults.standard.string(forKey: "Role") ==  "WORKER") || (UserDefaults.standard.string(forKey: "MainRole") == "WORKER"){
                              
                            WorkerSubmittedReports()
                        }
                        
                else {
                    
                   SuperReports()
                 }
                        
                       
                        
                        
                    case 3:
                     //
                    //    WorkerSubmittedReports()
                        
                        
                        CustomChannelList(senderName: "", unreadMessageCount: 0, recentTime: "", recentMessage: "")

                        
                        
                    default :
                        Text("Hi 1")
                    }
                    
                    if (notificationshow==true){
                        Notification()
                    }
                    if (ProfileView==true){
                        Profile()
                    }
                    
                    if (workercheckin==true){
                        WorkkerCheckin()
                    }
                    
                    if (shownfcview==true){
                        NfcCheckin()
                    }
                    
                    if (showdashboard==true){
                        if (UserDefaults.standard.string(forKey: "Role") == "WORKER"){
                            
                            WorkerDashBoard()
                        }
                        
                        else {
                            SuperDashboard()
                        }
                    }
                }
                Spacer()
                    .frame(height: 10)
                
                if (UserDefaults.standard.bool(forKey: "Checkedin") == true) && (UserDefaults.standard.bool(forKey: "isCheckInApproved") == true) && (UserDefaults.standard.bool(forKey: "isBreak") == false) {
                    
                    if (workercheckin==false){
                        
                        CustumTabView(selectedIndex: selectedIndex) { index in
                            //                if index == 2 {
                            //                    shouldShowModel = true
                            //                    return
                            //                }
                            disableAllview()
                            selectedIndex = index
                        }
                        
                    }
                }
                
                else if    (UserDefaults.standard.bool(forKey: "Checkedin") == true) && (UserDefaults.standard.bool(forKey: "isCheckInApproved") == false) && (UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == true) {
                    
                    if (workercheckin==false){
                        
                        CustumTabView(selectedIndex: selectedIndex) { index in
                            //                if index == 2 {
                            //                    shouldShowModel = true
                            //                    return
                            //                }
                            disableAllview()
                            selectedIndex = index
                        }
                        
                    }
                }
                
                
                
            }.edgesIgnoringSafeArea(.all)
                .background(Color("BackGroundColor"))
            //
            
        }
        .onAppear(){
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "callsidemenu"), object: nil, queue: OperationQueue.main) {_ in
                withAnimation {
                    
                    x = 0
                    
                }
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SetNotificationView"), object: nil, queue: OperationQueue.main) {_ in
                
                
                disableAllview()
                notificationshow.toggle()
                
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RemoveNotificationView"), object: nil, queue: OperationQueue.main) {_ in
                
                notificationshow.toggle()
                
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RemoveProfileView"), object: nil, queue: OperationQueue.main) {_ in
                
                ProfileView.toggle()
                
            }
            
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SetProfileView"), object: nil, queue: OperationQueue.main) {_ in
                disableAllview()
                ProfileView.toggle()
//                workercheckin = false
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RemoveGpsView"), object: self)

                
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Showworkercheckin"), object: nil, queue: OperationQueue.main) {_ in
                disableAllview()
                workercheckin.toggle()
                
                
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RemoveGpsView"), object: nil, queue: OperationQueue.main) {_ in
                workercheckin = false
                
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "calldashboard"), object: nil, queue: OperationQueue.main) {_ in
                selectedIndex = 0
                disableAllview()
                //                workercheckin = false
                showdashboard = true
                
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "callnfcview"), object: nil, queue: OperationQueue.main) {_ in
                disableAllview()
                //                workercheckin = false
                shownfcview = true
                
            }
            
            
            
        }
    }
    
    func disableAllview(){
        notificationshow = false
        ProfileView = false
        workercheckin = false
        showdashboard = false
        shownfcview = false
        
    }
    
}

//struct Dashboard_Previews: PreviewProvider {
//    static var previews: some View {
//        Dashboard(x: 0, isDark: false).environment(\.colorScheme, .light)
//       // Dashboard()
//     //   Dashboard()
//
//        Dashboard(x: 0, isDark: false).environment(\.colorScheme, .dark)
//    }
//}
//#Preview {
//    Dashboard()
//}
