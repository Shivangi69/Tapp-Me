//
//  WorkerDashBoard.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 04/01/24.
//

import SwiftUI

struct WorkerDashBoard: View {
    @State private var showTasks = true
    @State private var RequestforGeofenceoutside = false
    @State private var backgroundDisabled = false
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    
    @StateObject var  obs = WorkerdashbaordVM()
    @State var shouldReload = UUID() // Change this value to trigger reload

    @State private var showAlert1 = false
    @State private var Logoutshow = false
    @StateObject var WorkerCheckvm = WorkerCheckinVM()
    
    @State private var taskdetails = false
    @State private var showalert = false

    @State private var showAlert2 = false
    @State private var showhomeview = false

    
    
    
    @State private var isshowingoutoftheboudary = false

    @State var currentdate  : String? = nil

    @State private var reloadFlag = UUID()

    @State private var WorkerGeneralReport = false
    @State private var WorkkerCheckin = false
    @State var taskIndex = Int()
    @StateObject var statuscheck = CompanylistbyemailVMgoogle()

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing:30.0){
                           
                            VStack(spacing:30.0){
                                VStack(spacing: 15){
                                    
                                    HStack(spacing: 15){
                                        
                                        VStack (spacing: 20){
                                            Text("Total Tasks")
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black)
                                                .lineLimit(1)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            
                                            // .padding()
                                            
                                            Text  (String(obs.workerdas?.tasksAssignedCount ?? 0))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black)
                                                .lineLimit(1)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            
                                            // .padding()
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
                                            
                                            Text (String(obs.workerdas?.completedTasksCount ?? 0))
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
                                            Text("Hours worked today")
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black)
                                                .lineLimit(1)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            

//                                              
//                                            VStack{
//                                                
//                                                if let checkinString = statuscheck.Checkinmodel?.checkIn,
//                                                           let checkinTime = formatDateString(checkinString) {
//                                                            let currentTime = Date()
//                                                            let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: checkinTime, to: currentTime)
//
//                                                            if let hours = timeDifference.hour {
//                                                                Text(String(hours))
//                                                                .multilineTextAlignment(.center)
//                                                                .foregroundColor(.black)
//                                                                .lineLimit(1)
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                    }
//                                                    
//                                                }
//                                            }
                                            
                                            
                                            VStack {
                                                if let checkinString = statuscheck.Checkinmodel?.checkIn {
                                                    if checkinString == "" {
                                                        // Display "0" if checkinString is empty
                                                        Text("0 Hours")
                                                            .multilineTextAlignment(.center)
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    } else if let checkinTime = formatDateString(checkinString) {
                                                        // Calculate the time difference if checkinString is not empty
                                                        let currentTime = Date()
                                                        let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: checkinTime, to: currentTime)

                                                        if let hours = timeDifference.hour {
                                                            Text(String(hours)  + " Hours ")
                                                                .multilineTextAlignment(.center)
                                                                .foregroundColor(.black)
                                                                .lineLimit(1)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        }
                                                    }
                                                }
                                            }

                                            
                                        }
                                        .frame(width: Responsiveframes.widthPercentageToDP(85)/2,height: Responsiveframes.heightPercentageToDP(12))
                                        
                                        
                                        
                                        .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.25)
                                                .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                        )
                                        
                                        VStack (spacing: 20){
                                            Text("Overtime hours")
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black)
                                                .lineLimit(1)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            
                                            //   .padding()
                                            
                                  
                                            
//                                            VStack{
//                                                
//                                                if let checkinString = statuscheck.Checkinmodel?.checkInOvertime,
//                                                   
//                                                    
//                                                    
//                                                    
//                                                    
//                                                           let checkinTime = formatDateString(checkinString) {
//                                                            let currentTime = Date()
//                                                            let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: checkinTime, to: currentTime)
//
//                                                            if let hours = timeDifference.hour {
//                                                                Text(String(hours))
//                                                                .multilineTextAlignment(.center)
//                                                                .foregroundColor(.black)
//                                                                .lineLimit(1)
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                    }
//                                                    
//                                                }
//                                            }
                                            
                                         VStack {
                                            if let checkinString = statuscheck.Checkinmodel?.checkInOvertime {
                                                if checkinString == "" {
                                                    // Display "0" if checkinString is empty
                                                    Text("0 Hours")
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(.black)
                                                        .lineLimit(1)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                } else if let checkinTime = formatDateString(checkinString) {
                                                    // Calculate the time difference if checkinString is not empty
                                                    let currentTime = Date()
                                                    let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: checkinTime, to: currentTime)

                                                    if let hours = timeDifference.hour {
                                                        Text(String(hours) + " Hours" )
                                                            .multilineTextAlignment(.center)
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    }
                                                }
                                            }
                                        }

                                            
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
                                
                                //boxes bellow Data
                                
                                VStack(spacing: 30){
                                    
                                    Button(action: {
                                        // Add your sign-in action here
                                        
                               
                                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Showworkercheckin"), object: self)
                                     //   WorkkerCheckin.toggle()
                                        
                                    }) {
                                        HStack {
                                            Spacer()
                                            Text("Break/Request  or  Check out")
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
                                
                                    HStack(spacing: 15){
                                        if statuscheck.homemodel?.isBreak == true {
                                            
                                            VStack (spacing: 20){
                                                Text("Request to go outside geofence")
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.white)
                                                    .lineLimit(2)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.8)))
                                                    .padding()
                                                
                                                
                                            }
                                            
                                            .onTapGesture {
                                             //   RequestforGeofenceoutside.toggle()
                                                showalert.toggle()
                                            }
                                            
                                            .frame(width: Responsiveframes.widthPercentageToDP(85)/2,height: Responsiveframes.heightPercentageToDP(12))
                                            .background(Color.darkgray)
                                            .cornerRadius(10)
                                            .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .inset(by: 0.25)
                                                    .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                            )   
                                            .alert(isPresented: $showalert) {
                                                Alert(
                                                    title: Text("Request Already Raised"),
                                                    message: Text("You have already raised a request for a break. Please cancel that request before raising a new one."),
                                                    dismissButton: .default(Text("OK"))
                                                    
                                                )
                                            }
      
                                        }
                                    
                                        
                                            else {
                                                
                                                
                                                VStack (spacing: 20){
                                                    Text("Request to go outside geofence")
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(.white)
                                                        .lineLimit(2)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.8)))
                                                        .padding()
                                                    
                                                    
                                                }
                                                
                                                .onTapGesture {
                                                    
                                                    if UserDefaults.standard.bool(forKey: "isWithinPolygons")  == true {
                                                        RequestforGeofenceoutside.toggle()

                                                        
                                                    }
                                                    else {
                                                        isshowingoutoftheboudary = true

                                                    }
                                                }
                                                
                                                .frame(width: Responsiveframes.widthPercentageToDP(85)/2,height: Responsiveframes.heightPercentageToDP(12))
                                                .background(Color.darkgray)
                                                .cornerRadius(10)
                                                .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .inset(by: 0.25)
                                                        .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                                )
                                                
                                                
                                            }
                                     
                                           
                                        VStack (spacing: 20){
                                            Text("Create General Report")
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                                .lineLimit(2)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.8)))
                                                .padding()
                                        }
                                        
                                        .frame(width: Responsiveframes.widthPercentageToDP(85)/2,height: Responsiveframes.heightPercentageToDP(12))
                                        .background(Color.accentColor)
                                        .cornerRadius(10)
                                        
                                        //.cornerRadius(10)
                                        .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.25)
                                                .stroke(.black.opacity(0.3), lineWidth: 0.5)
                                        )
                              
                                        .onTapGesture {
                                            WorkerGeneralReport.toggle()
                                        }
                                    }
                                    .padding()
                                    .frame(width: (Responsiveframes.widthPercentageToDP(85))/2,height: Responsiveframes.heightPercentageToDP(12))
                                               
                                }
                                
                                
                                ScrollView(.vertical, showsIndicators: false){
                                    
                                    LazyVStack {
                                        HStack {
                                             Text("Tasks List")
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                              //  .padding()
                                            
                                    Spacer()
                                            
                                            
                                            Taskpicker(value: $CompanyName,
                                                showCompanyPicker: $showcompanypicker,
                                    
                                                onChange: {
                                                if CompanyName == "In Progress" {
                                                    obs.eTaskReportStatus = "Working"
                                                  obs.tasklistdata = []
                                               
                                                    obs.getdasworker()
                                                    showTasks = true

                                            
                                                } else if CompanyName == "Pending" {
                                                    obs.eTaskReportStatus = "Pending"
                                                    obs.tasklistdata = []
                                                    obs.getdasworker()
                                                    showTasks = true

                                                }
                                            })
                                            
                                            .onAppear(){
                                 
                                                showTasks = true
                                                obs.getdasworker()
                                            }
                                            
                                            .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
                                        }
                                        
                                        .padding()
                                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(9))
                                      //  .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                             
                                        
                                        if showTasks == true  && obs.tasklistdata.count !=  0   {
                                            
                                          //  ForEach(obs.tasklistdata, id:\.self) { task in
                                                
                                                ForEach(Array(obs.tasklistdata.enumerated()), id: \.1.taskID) { (index, task) in

                                                VStack {
                                                        HStack{
                                                            VStack(alignment: .leading) {
                                                                Text(task.name)
                                                                         .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                
                                                                Spacer()
                                                                
//                                                                Text("Very High Priority")
//                                                                    .fontWeight(.semibold)
//                                                                    .lineLimit(1)
//                                                                    .font(ConstantClass.AppFonts.light)
//                                                                    .foregroundColor(Color.red)
                                                                
                                                                HStack(spacing:2){
                                                                    if task.priority == "Medium"{
                                                                        Image("medium")
                                                                            .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                                                        
                                                                        Text(task.priority)
                                                                            .font(ConstantClass.AppFonts.light)
                                                                            .foregroundColor(.yellow)
                                                                            .padding(.leading, 5.0)
                                                                    } else if task.priority == "High"{
                                                                        Image("high")
                                                                            .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                                                        
                                                                        Text(task.priority)
                                                                            .font(ConstantClass.AppFonts.light)
                                                                            .foregroundColor(.red)
                                                                            .padding(.leading, 5.0)
                                                                    } else {
                                                                        Image("low")
                                                                            .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                                                        
                                                                        Text(task.priority)
                                                                            .font(ConstantClass.AppFonts.light)
                                                                            .foregroundColor(.lightorange)
                                                                            .padding(.leading, 5.0)
                                                                    }
                                                                    Spacer()
                                                                }
                                                            }
                                                                            
                                                     .padding()
                                                            
                                                             Spacer()
                                                            
                                                            Button(action: {
                                                                // Add your button action here
                                                                taskdetails.toggle()
                                                                self.taskIndex = index

                                                                
                                                            }) {
                                                                Text("VIEW")
                                                                    .foregroundColor(.white)
                                                                         .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            }
                                                            .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(5))
                                                                                           
                                                            .background(Color.accentColor)
                                                            .cornerRadius(6)
                                                            .padding()
                                                            .onTapGesture {
                                                                taskdetails.toggle()
                                                                self.taskIndex = index

                                                            }
                                                          
                                                        }
                                                    //.padding()
                                                        
                                                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(7))


                                                    }
                                            }
                                        }
                                        else{
                                            Spacer()
                                            EmptyListView(screenName: "timsheet")
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                                    
                                    .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    
                                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                                }
                    
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                        }
                        .alert(isPresented: $showAlert1) {
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

                       Spacer()
                        
                        NavigationLink(destination: HomeView(), isActive: $showhomeview) { EmptyView() }
                        NavigationLink(destination: Tapp_Me.RequestforGeofenceoutside(), isActive: $RequestforGeofenceoutside) { EmptyView() }


                        NavigationLink(destination: Tapp_Me.WorkerGeneralReport(), isActive: $WorkerGeneralReport) { EmptyView() }
                        
                        
                        if (obs.tasklistdata.count>0){
                       //     let validIndex = min(self.taskIndex, obs.tasklistdata.count - 1)

                            NavigationLink(destination: WorkerTaskDetails(TaskDetaildata: obs.tasklistdata[self.taskIndex]), isActive: $taskdetails) {
                                EmptyView()}
                        }
                        
                        
                          
                        
                        
                    }
                    
                    .disabled(backgroundDisabled)
                    .frame(width: geometry.size.width)
                }
                
                if  isshowingoutoftheboudary  {
                    
                    ZStack {
//                        Color.black.opacity(0.3)
//                            .edgesIgnoringSafeArea(.all)
//                        
                        GeometryReader { geometry in
                            
                            VStack{
                                VStack(spacing: 30){
                                    
                                    VStack {
                                        Text("You are out of the boundary.")
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                            .font(ConstantClass.AppFonts.light)
                                        
                                    }
                                    
                                    VStack {
                                        
                                        Text("When you will in the site")
                                            .foregroundColor(.darkgray)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                        Text("You can check in.")
                                            .foregroundColor(.darkgray)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                        
                                    }
                                    
                                    
                                    
                                    Button(action: {
                                        // Add your sign-in action here
                                        //     isShowingPopup = false
                                        isshowingoutoftheboudary = false
                                        self.backgroundDisabled = false

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
                                        isshowingoutoftheboudary = false
                                        self.backgroundDisabled = false

                                        
                                    }
                                    
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
                    .onAppear(){
                        self.backgroundDisabled = true
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onReceive(obs.$shouldReload) { _ in
                     // React to changes in reloadState.shouldReload
                     // Perform any actions necessary before reload
                     print("Reloading...")
                 }
        }
        
        .onAppear(){
            if UserDefaults.standard.bool(forKey: "status") == false {
                
                showAlert1 = true
            }
            
            if UserDefaults.standard.integer(forKey: "workforceId") == 0{
                
                showAlert2 = true
            }
            

            obs.getworkerdash()
            getCurrentDate()

            statuscheck.currentdate = currentdate ?? ""
            statuscheck.GetCheckintime()
            statuscheck.GetallStatus()

            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "CALLAPI"), object: nil, queue: OperationQueue.main) {_ in
                statuscheck.GetallStatus()
        
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Calldash"), object: nil, queue: OperationQueue.main) {_ in
                obs.getworkerdash()
        
            }
            
        }
        
        .navigationBarBackButtonHidden(true)
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
    
    
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        currentdate = dateFormatter.string(from: date)
        print (currentdate)
        
        
        return currentdate ?? ""
    }
    func formatDateString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return dateFormatter.date(from: dateString)
    }
    
}
    
    
    

struct Taskpicker: View {
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    let typetasklist = [ "Pending" ,"In Progress" ]
    var placeholder = "Pending"
    var onChange: (() -> Void)? // Callback function to notify parent

    var body: some View {
        
        HStack {
            Menu {
                ForEach(typetasklist, id: \.self) { company in
                    Button(action: {
                        self.value1 = company
                        self.value = company
                        self.showCompanyPicker.toggle()
                        onChange?() // Invoke callback

                    }) {
                        Text(company)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            .foregroundColor(Color.white) // Set text color to white
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .white : .white) // Set text color to white
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            .padding(.leading, 10)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.white) // Set arrow color to white
                            .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                            .padding(.trailing, 2)

                    }
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
        .background(Color.blue) // Set background color to blue
        .cornerRadius(6) // Add corner radius to background
    }
}

#Preview {
    WorkerDashBoard()
}
