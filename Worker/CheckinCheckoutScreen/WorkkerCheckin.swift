//
//  WorkkerCheckin.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI
import GoogleMaps
import GoogleSignIn
import CoreLocation

struct WorkkerCheckin: View {
    @Environment(\.presentationMode) var presentationMode
    
    let locationManager = CLLocationManager()

    @State private var currentTimeString = ""
    
    
    @StateObject var WorkerCheckvm = WorkerCheckinVM()
    @State var currentdate  : String? = nil
    
    @State private var mainview = false
    @State private var Logoutshow = false

    @State private var isShowingPopupCheckin = false
    @State private var isShowPopupcheckinforovertime = false

    @State private var isShowPopupcheckoutforovertime = false

    
    @State  var isShowingPopupBreak = false
    @State  var isShowingPopupBreakoOFF = false
    
    @State private var isshowingoutoftheboudary = false
    
    @State private var RequestforGeofenceoutside = false
    
    @State private var isShowingPopupCheckout = false
    
    @State  var showbreak = false
    
    @State  var showcheckout = false
    
    @State private var Workerdashboard = false
    @State private var breakStatus: String? = nil
    
    @State private var buttonText: String = ""
    @State private var buttonColor: Color = .blue
    @State private var bgcolor: Color = .red
    
    @State private var bttext: String = ""
    
    @State private var isWithinPolygons = Bool() // Binding variable to control the visibility of the popup
    
    @StateObject var WorkerCheckin = WorkerCheckinVM()
    
    @StateObject var statuscheck = CompanylistbyemailVMgoogle()
    
    @State private var toggleState = false
    
    //  let sitesData: [Site] // Assuming this data is provided from your API response
    
    @State  var latitude = Double()
    //    @State  var isImageVisible = Bool()
    
    @State  var longitude = Double()
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    if(statuscheck.showFullview == true){
                        VStack{
                            VStack {
                                if(WorkerCheckin.showMAP == true){
                                    
                                    GoogleMapView(isWithinPolygons: $isWithinPolygons, polygonArr: WorkerCheckin.AllCoordinateArray, status: statuscheck.homemodel! )
                                }
                                
                            }
                            
                            
                            
                            VStack{
                                
                                VStack(alignment: .center, spacing: 8.0){
                                    
                                    HStack{
                                        VStack(alignment: .center ){
                                            
                                            let checkintime = DateConverter.convertDatetotime(dateString: statuscheck.Checkinmodel?.checkIn ?? "")

                                            
                                            if checkintime == "" {
                                            
                                                
                                                Text("Today Not Logged in." )
                                                    .fontWeight(.semibold)
                                                    .lineLimit(2)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    .foregroundColor(.blue)
                                                
                                            }
                                            else if checkintime != "" {
                                                Text("Logged in today at " + checkintime)
                                                    .fontWeight(.semibold)
                                                    .lineLimit(2)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    .foregroundColor(.blue)
                                            }
                                            
                                    
                                            if statuscheck.homemodel?.isworkerovertimecheckin == true{
                                                
                                                let checkintime = DateConverter.convertDatetotime(dateString: statuscheck.Checkinmodel?.checkInOvertime ?? "")
                                                Text("Overtime Logged in today at " + checkintime)
                                                    .fontWeight(.semibold)
                                                    .lineLimit(2)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    .foregroundColor(.blue)
                                                
                                            }
                                            
                                            //  Spacer()
                                            
                                            if WorkerCheckin.sImageVisible == true && statuscheck.homemodel?.isworkerovertimecheckin == false {
                                                if statuscheck.Checkinmodel?.latestStartBreakTime != ""  {
                                                    
                                                    let checkintime = DateConverter.convertDatetotime(dateString: statuscheck.Checkinmodel?.latestStartBreakTime ?? "")
                                                    
                                                    Text("Today Break start at " + checkintime)
                                                        .fontWeight(.semibold)
                                                        .lineLimit(2)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        .foregroundColor(.blue)
                                                    
                                                }
                                            }
                                            
                                            
                                            if WorkerCheckin.sImageVisible == false && statuscheck.homemodel?.isworkerovertimecheckin == false {
                                                if   statuscheck.Checkinmodel?.latestEndBreakTime != ""{
                                                    
                                                    
                                                    let breakend = DateConverter.convertDatetotime(dateString: statuscheck.Checkinmodel?.latestEndBreakTime ?? "")
                                                    Text("Today Break end at " + breakend)
                                                        .fontWeight(.semibold)
                                                        .lineLimit(2)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        .foregroundColor(.blue)
                                                    
                                                }
                                            }
                                            
                                            
                                        }
                                      
                                       
                                    }
                                   
                                    
                                    
                                    VStack(alignment: .center) {
                                        if let checkinString = statuscheck.Checkinmodel?.checkIn {
                                            if checkinString == "" {
                                                // Display "0" for hours, minutes, and seconds if checkinString is empty
                                                HStack (spacing: 10) {
                                                    TimeUnitView(time: "0")
                                                    Text(":")
                                                        .font(.headline)
                                                        .foregroundColor(.accentColor)
                                                    TimeUnitView(time: "0")
                                                    Text(":")
                                                        .font(.headline)
                                                        .foregroundColor(.accentColor)
                                                    TimeUnitView(time: "0")
                                                }
                                            } else if let checkinTime = formatDateString(checkinString) {
                                                // Calculate the time difference if checkinString is not empty
                                                let currentTime = Date()
                                                let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: checkinTime, to: currentTime)

                                                if let hours = timeDifference.hour, let minutes = timeDifference.minute, let seconds = timeDifference.second {
                                                    HStack (spacing: 10) {
                                                        TimeUnitView(time: String(hours))
                                                        Text(":")
                                                            .font(.headline)
                                                            .foregroundColor(.accentColor)
                                                        TimeUnitView(time: String(format: "%02d", minutes))
                                                        Text(":")
                                                            .font(.headline)
                                                            .foregroundColor(.accentColor)
                                                        TimeUnitView(time: String(format: "%02d", seconds))
                                                    }
                                                }
                                            }
                                        }
                                    }


                                            
                                    VStack{
                                        Text("Shift end in 9 hours")
                                            .fontWeight(.semibold)
                                            .lineLimit(2)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .foregroundColor(.blue)
                                        
                                    }  .frame(width: Responsiveframes.widthPercentageToDP(80))
                                      
                                }
                              
                                .frame(width: Responsiveframes.widthPercentageToDP(80))
                                
                                
                            }
                            .padding(.top,5)
                           
                            .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(20))
                            .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 0.5)
                                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
                            )
                            
                            
                            VStack{
                                Spacer()
                                    .frame(height: Responsiveframes.heightPercentageToDP(2))
                                HStack(spacing:5){
                                    
                                    HStack{
                                        if statuscheck.homemodel?.isWorkerCheckedIn == false && UserDefaults.standard.bool(forKey: "isWorkerCheckedOut") == false {
                                            
                                            Button(action: {
                                                
                                                if isWithinPolygons == false {
                                                    isshowingoutoftheboudary = true
                                                }else{
                                                    if statuscheck.homemodel?.isWorkerCheckedIn == false {
                                                        isShowingPopupCheckin = true
                                                    }
                                                    
                                                    else if statuscheck.homemodel?.isWorkerCheckedIn == true {
                                                        isShowingPopupCheckin = false
                                                        
                                                    }
                                                }
                                                
                                            }) {
                                                    Text("Check In")
                                                        .foregroundColor(.accentColor)
                                                        .padding()
                                                        .cornerRadius(10)
                                                
                                            }
                                            .frame(width: (Responsiveframes.widthPercentageToDP(40)), height:  Responsiveframes.heightPercentageToDP(6))
                                            .background(Color.white)
                                            .cornerRadius(6)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .inset(by: 0.5)
                                                    .stroke(Color.accentColor, lineWidth: 1)
                                            )
                                            .onTapGesture {
                                                
                                                if isWithinPolygons == false {
                                                    isshowingoutoftheboudary = true
                                                }else{
                                                    if statuscheck.homemodel?.isWorkerCheckedIn == false {
                                                        isShowingPopupCheckin = true
                                                    }
                                                    
                                                    
                                                    else if statuscheck.homemodel?.isWorkerCheckedIn == true {
                                                        isShowingPopupCheckin = false
                                                        
                                                    }
                                                }
                                            }
                                            
                                        }
//                                        if statuscheck.homemodel?.isWorkerCheckedIn == true && statuscheck.homemodel?.isWorkerCheckedOut == false {
                                            
                                        if UserDefaults.standard.bool(forKey: "isWorkerCheckedIn") == true  && UserDefaults.standard.bool(forKey: "isWorkerCheckedOut") == false  {
                                         //   Spacer()
                                            
                                            
                                            if WorkerCheckin.sImageVisible == false {
                                                HStack{
                                                    Button(action: {
                                                        // Your action here
                                                        
                                                        
                                                        if statuscheck.homemodel?.isOutside == true {
                                                            
                                                            RequestforGeofenceoutside.toggle()
                                                            
                                                        }
                                                        
                                                        
                                                        else  if statuscheck.homemodel?.isWorkerCheckedIn == true {
                                                            isShowingPopupCheckout = true
                                                        }
                                                        else{
                                                            isShowingPopupCheckout = false
                                                        }
                                                        
                                                        
                                                        
                                                    })
                                                    {
                                                        Text("Check Out")
                                                            .foregroundColor(.red)
                                                            .padding()
                                                            .cornerRadius(10)
                                                    }
                                                    
                                                    
                                                    .frame(width: (Responsiveframes.widthPercentageToDP(40)), height:  Responsiveframes.heightPercentageToDP(6))
                                                    .foregroundColor(.red)
                                                    .cornerRadius(6)
                                                    
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .inset(by: 0.5)
                                                            .stroke(Color.red, lineWidth: 1)
                                                    )
                                                    
                                                    .onTapGesture {
                                                        
                                                        if statuscheck.homemodel?.isOutside == true {
                                                            RequestforGeofenceoutside.toggle()
                                                            
                                                        }
                                                        else if statuscheck.homemodel?.isWorkerCheckedIn == true{
                                                            isShowingPopupCheckout = true
                                                        }
                                                        else{
                                                            
                                                            isShowingPopupCheckout = false
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            
                                          //  Spacer()
                                       
                                            
                                            
                                            HStack {
                                                
                                                if(statuscheck.homemodel?.isOutside == false){
                                                    
                                                    Button(action: {
                                                        // Toggle the state of isImageVisible
                                                        //  isImageVisible.toggle()
                                                        
                                                        
                                                        
                                                        if WorkerCheckin.sImageVisible == false {
                                                            isShowingPopupBreak = true
                                                            isShowingPopupBreakoOFF = false
                                                        }else{
                                                           if(isWithinPolygons == false){
                                                                isshowingoutoftheboudary = true
                                                                
                                                            }
                                                            else{
                                                                isShowingPopupBreak = false
                                                                isShowingPopupBreakoOFF = true
                                                            }
                                                            
                                                        }
                                                        
                                                    }) {
                                                        VStack(spacing: 1){
                                                            Image(WorkerCheckin.sImageVisible  ? "breakon" : "breakoff")
                                                                .resizable()
                                                                .frame(width: Responsiveframes.widthPercentageToDP(15), height: Responsiveframes.heightPercentageToDP(6))
                                                            
                                                            
                                                            Text("Break")
                                                             //   .font(.headline)
                                                                .foregroundColor(.black)
                                                               // .padding()
                                                            //    .frame(width: Responsiveframes.widthPercentageToDP(20),height: Responsiveframes.heightPercentageToDP(6))
                                                        }
                                                        
                                                    }
                                                }
                                                
                                            }
                                            .frame(width: Responsiveframes.widthPercentageToDP(20),height: Responsiveframes.heightPercentageToDP(7))
                                       
                                        }
                                            
                                        
//                                        if WorkerCheckin.showcheckoutbutton == true{
                                         
                               
                                        if UserDefaults.standard.bool(forKey: "isWorkerCheckedOut") == true &&  UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == false  {
                                            
                                            HStack {
                                                Button(action: {
                                                    // Toggle the state of isImageVisible
                                                    // isImageVisible.toggle()
                                                    if !isWithinPolygons {
                                                        isshowingoutoftheboudary = true
                                                    } else {
                                                        isShowPopupcheckinforovertime = true
                                                        isShowPopupcheckoutforovertime = false
                                                    }
                                                }) {
                                                    Text("Checkin Overtime")
                                                        .font(.system(size: Responsiveframes.widthPercentageToDP(4))) // Adjust font size as needed
                                                        .padding()
                                                        .foregroundColor(.white) // Adjust text color as needed
                                                }
                                                .frame(width: Responsiveframes.widthPercentageToDP(60), height: Responsiveframes.heightPercentageToDP(6))
                                                .background(Color.blue) // Adjust background color as needed
                                                .cornerRadius(10)
                                                
                                            }
                                        }
                                            
                                            if UserDefaults.standard.bool(forKey: "isWorkerCheckedOut") == true &&  UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == true  {
                                                
                                                
                                                HStack {
                                                    Button(action: {
                                                        // Toggle the state of isImageVisible
                                                        //  isImageVisible.toggle()
                                                        if isWithinPolygons == false {
                                                            isshowingoutoftheboudary = true
                                                        }
                                                        else {
                                                            
                                                            isShowPopupcheckinforovertime = false
                                                            isShowPopupcheckoutforovertime = true
                                                            
                                                            
                                                            
                                                        }
                                                    }) {
                                                        Text("Checkout Overtime")
                                                            .font(.system(size: Responsiveframes.widthPercentageToDP(4))) // Adjust font size as needed
                                                            .padding()
                                                            .foregroundColor(.white) // Adjust text color as needed
                                                        // Adjust corner radius as needed
                                                    }
                                                    .frame(width: Responsiveframes.widthPercentageToDP(60),height: Responsiveframes.heightPercentageToDP(6))
                                                    .background(Color.blue) // Adjust background color as needed
                                                    .cornerRadius(10)
                                                    
                                                }
                                                
                                            }
                                        
                                        
                                    }
                                    .frame(width: (Responsiveframes.widthPercentageToDP(90))/3)
                                }
                                
                                
                                .frame(width: Responsiveframes.widthPercentageToDP(90) , height: Responsiveframes.heightPercentageToDP(8) )
                                
                            }
                            .cornerRadius(10)
                            .onAppear(){
                                
                                let istrur = statuscheck.homemodel?.isBreak
                                WorkerCheckin.sImageVisible = istrur ?? false

                            }
                        }
//                        .fullScreenCover(isPresented: $Logoutshow, content: {
//                            HomeView()
//                        })
                        
                        
                        NavigationLink(destination: HomeView(), isActive: $Logoutshow) { EmptyView() }
                        
                        NavigationLink(destination: Tapp_Me.RequestforGeofenceoutside(), isActive: $RequestforGeofenceoutside) { EmptyView() }
                    }
                    
                    if isShowingPopupCheckin == true {
                        
                        StandardPopUp(
                            isShowingPopup: $isShowingPopupCheckin,
                            title: "Are you sure you want to Check in?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                
//                                UserDefaults.standard.setValue("yes", forKey: "Checkedin")
                                withAnimation{
                                    
                                    
                                    WorkerCheckin.siteId = WorkerCheckin.siteID1 ?? 0
                                    WorkerCheckin.requestid = "CHECK-IN"
                                    WorkerCheckin.checkinandoutApi()
                                     
                                }
                            },
                            onNoTapped: {
                                // Custom action for No button
                                withAnimation{
                                    isShowingPopupCheckin = false
                                }
                                
                                
                            }
                        )
                        
                    }
                    
                    
                    
                    if  isshowingoutoftheboudary  {
                        
                        ZStack {
                            Color.black.opacity(0.3)
                                .edgesIgnoringSafeArea(.all)
                            
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
                    }
                    
                    
                    
                    if isShowingPopupBreak == true {
                        
                        StandardPopUp(
                            isShowingPopup: $isShowingPopupBreak,
                            title: "Are you sure you want to Start your Break ?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                
                                WorkerCheckin.breakon()
                                UserDefaults.standard.setValue("yes", forKey: "breakon")
                                isShowingPopupBreak = false
                                
                                statuscheck.homemodel?.isBreak = true
                                WorkerCheckin.showMAP = true
                                statuscheck.GetCheckintime()
                                
                            },
                            onNoTapped: {
                                // Custom action for No button
                                
                                withAnimation{
                                    isShowingPopupBreak = false
                                    // isToggled = false
                                }
                                
                                
                            }
                        )
                        
                    }
                    
                    if isShowingPopupBreakoOFF == true {
                        
                    
                        StandardPopUp(
                            isShowingPopup: $isShowingPopupBreakoOFF,
                            title: "Are you sure you want to Stop your Break ?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                
                                WorkerCheckin.breakoff()
                                UserDefaults.standard.setValue("no", forKey: "breakon")
                                isShowingPopupBreakoOFF = false
                                statuscheck.homemodel?.isBreak = false
                                WorkerCheckin.showMAP = true

                            },
                            onNoTapped: {
                                // Custom action for No button
                                
                                withAnimation{
                                    isShowingPopupBreakoOFF = false
                                    // isToggled = false
                                }
                                
                                
                            } )
                    }
                    
                    if isShowingPopupCheckout == true{
                        StandardPopUp(
                            isShowingPopup: $isShowingPopupCheckout,
                            title: "Are you sure you want to Check Out?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                WorkerCheckin.siteId = WorkerCheckin.siteID1 ?? 0
                                
                                WorkerCheckin.requestid = "CHECK-OUT"
                                WorkerCheckin.checkinandoutApi()
                                
                                
                               
                                
                  
                            },
                            onNoTapped: {
                                // Custom action for No button
                                
                                withAnimation{
                                    isShowingPopupCheckout = false
                                }
                            }
                        )
                    }
                    
                    
                    if isShowPopupcheckinforovertime == true{
                        StandardPopUp(
                            isShowingPopup: $isShowPopupcheckinforovertime,
                            title: "Are you sure you want to Check in for Overtime?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                     
                                WorkerCheckin.siteId = WorkerCheckin.siteID1 ?? 0
                                WorkerCheckin.requestid = "CHECK-IN"
                                WorkerCheckin.OvertimecheckinandoutApi()
                                
                            },
                            onNoTapped: {
                                
                                withAnimation{
                                    isShowPopupcheckinforovertime = false
                                }
                            }
                        )
                    }
                    
                    if isShowPopupcheckoutforovertime == true{
                        StandardPopUp(
                            isShowingPopup: $isShowPopupcheckoutforovertime,
                            title: "Are you sure you want to Check out for Overtime?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                
                                WorkerCheckin.siteId = WorkerCheckin.siteID1 ?? 0
                                WorkerCheckin.requestid = "CHECK-OUT"
                                WorkerCheckin.OvertimecheckinandoutApi()
                                
                               // WorkerCheckvm.LogoutAPI()
                                Logoutshow.toggle()
                        
                               // clearUserData()
                               // Logoutshow.toggle()
//                                if let window = UIApplication.shared.windows.first {
//                                           window.rootViewController = UIHostingController(rootView: ContentView())
//                                           window.makeKeyAndVisible()
//                                       }
                                
                             
                            },
                            onNoTapped: {
                                // Custom action for No button
                                
                                withAnimation{
                                    isShowPopupcheckoutforovertime = false
                                }
                            }
                        )
                    }
                    
                    
                    
                    
                }
                
            }
            
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
            
            
        }
        .onAppear(){
            locationManager.startUpdatingLocation()
            getCurrentDate()
            statuscheck.currentdate = currentdate ?? ""
            print(statuscheck.currentdate)
            statuscheck.GetCheckintime()
            
            statuscheck.GetallStatus()
            WorkerCheckin.showMAP = false
            WorkerCheckin.getsideid()
            UserDefaults.standard.setValue(WorkerCheckin.AllCoordinateArray, forKey: "AllCoordinateArray")
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "callBreakAuto"), object: nil, queue: OperationQueue.main) {_ in
                withAnimation {
                    
                    WorkerCheckin.sImageVisible = true
                }
            }
            
            
            
          }
        .onDisappear(){
            locationManager.startUpdatingLocation()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }

    
    func formatDateString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return dateFormatter.date(from: dateString)
    }
    
    
    func clearUserData() {
        let deviceToken = UserDefaults.standard.string(forKey: "devicetoken")
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
        UserDefaults.standard.setValue(deviceToken, forKey: "devicetoken")
    }
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        currentdate = dateFormatter.string(from: date)
        print (currentdate)
        return currentdate ?? ""
    }
    
    func startTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateTime()
        }
                timer.fire()
    }
    
    func updateTime() {
        // Get the current date and format it as a string representing time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        
        // Update the UI with the current time string
        DispatchQueue.main.async {
            self.currentTimeString = currentTime
        }
    }
    
}
import AVFoundation

struct GoogleMapView: UIViewRepresentable {
    
    
    @State  var centerlatitude = UserDefaults.standard.double(forKey: "centerLatitude")
    @State  var centerlongitude = UserDefaults.standard.double(forKey: "centerLongitude")
    @State  var latitude = Double()
    @State  var longitude = Double()
    @Binding var isWithinPolygons: Bool // Binding to update the state in ContentView
    @State  var Clatitude = Double()
    @State  var Clongitude = Double()
    
    var polygonArr: NSArray
    @State private var polygons = [[[CLLocationCoordinate2D]]]()
    @State private var currentLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    @State  var mapView = GMSMapView()
    @State  var audioPlayer: AVAudioPlayer?
    @State  var status : HomeViewModel
    @State private var timer: Timer?
    @State private var alertCounter = 0
    @State var timerForApi: Timer? // Timer property to handle the 5-minute interval
    @State     var apiCalled: Bool = false // Flag to track if API call has been made
    
    func makeUIView(context: Context) -> GMSMapView {
        
        
        print("CALLLLLLLLLLLLLLstatus",status.isWorkerCheckedIn)
        
        print("centerlatitude",centerlatitude)
        print("centerlongitude",centerlongitude)
        print("polygonArr.count",polygonArr.count)
        
        // Initialize mapView with a default camera position
        let camera = GMSCameraPosition.camera(withLatitude: centerlatitude, longitude: centerlongitude, zoom: 11.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.isIndoorEnabled = false
        mapView.isMyLocationEnabled = true
        // Set up location manager
        context.coordinator.parent = self
        locationManager.delegate = context.coordinator
        //
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //  locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        //
        //  locationManager.distanceFilter = 15 // Update every 10 meters
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        print("CALLLLLLLLLLLLLL1")
        
        DispatchQueue.main.async {
            if let location = getCurrentLocation() {
                print("CALLLLLLLLLLLLLL2")
                
                self.latitude = location.latitude
                self.longitude = location.longitude
                
                populatePolygons(mapView: mapView)
                isWithinPolygons = isLocationWithinPolygons(CLLocationCoordinate2D(latitude:  self.latitude, longitude: self.longitude))
                let cameraUpdate = GMSCameraUpdate.setTarget(location, zoom: 15.0)//GMSCameraUpdate.setTarget(location)
                mapView.animate(with: cameraUpdate)
            } else {
                locationManager.startUpdatingLocation()
                
                print("CALLLLLLLLLLLLLL2")
                
                self.latitude = UserDefaults.standard.double(forKey: "lat")
                self.longitude = UserDefaults.standard.double(forKey: "lon")
                let location = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
                
                print("CALLLLLLLLLLLLLL   location %@ %@ %@",self.latitude,self.longitude,location)
                
                populatePolygons(mapView: mapView)
                isWithinPolygons = isLocationWithinPolygons(CLLocationCoordinate2D(latitude:  self.latitude, longitude: self.longitude))

                // Update the camera position to the current location
                let cameraUpdate = GMSCameraUpdate.setTarget(location, zoom: 15.0)//GMSCameraUpdate.setTarget(location)
                mapView.animate(with: cameraUpdate)
                print("CALLLLLLLLLLLLLL3")
                
                // Handle case where current location is nil
            }
        }
        
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        
    }
    
    @StateObject var WorkerCheckin = WorkerCheckinVM()
    
    
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: GoogleMapView
        let locationManager = CLLocationManager()
        
        init(_ parent: GoogleMapView) {
            self.parent = parent
            super.init()
        }
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            guard let location = locations.last else { return }
//            
//            parent.currentLocation = location.coordinate
//            parent.isWithinPolygons = parent.isLocationWithinPolygons(location.coordinate)
//            parent.Clatitude = location.coordinate.latitude
//            parent.Clongitude = location.coordinate.longitude
//            UserDefaults.standard.setValue(location.coordinate.latitude, forKey: "lat")
//            UserDefaults.standard.setValue(location.coordinate.longitude, forKey: "lon")
//            let location1 = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            parent.populatePolygons(mapView:  parent.mapView)
//            print("CALLLLLLLLLLLLLLCURRENT",location)
//            print("parent.isWithinPolygons",parent.isWithinPolygons)
//            
//            UserDefaults.standard.setValue(parent.isWithinPolygons, forKey: "isWithinPolygons")
//            print(parent.isWithinPolygons)
//            
//            //            if !parent.isWithinPolygons {
//            //                if parent.status.isWorkerCheckedIn && !parent.status.isBreak {
//            //                    parent.playSiren()
//            //                    parent.scheduleNotification(timeInterval: 3, message: "You Are Out of Boundry!")
//            //
//            //                    if !parent.apiCalled {
//            //                        parent.apiCalled = true
//            //                        parent.startTimer()
//            //                    }
//            //                }
//            //
//            //            } else {
//            
//            //                if !parent.status.isWorkerCheckedIn {
//            //                    // Start the timer if it's not already running
//            //                    if parent.timer == nil {
//            //                        parent.timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true) { _ in // 300 seconds = 5 minutes
//            //                            self.parent.scheduleNotification(timeInterval: 1, message: "You Are In Boundry,you have to check in!")
//            //
//            //                            self.parent.playSiren()
//            //                            self.parent.alertCounter += 1
//            //                            if self.parent.alertCounter >= 6 { // 6 alerts * 5 minutes = 30 minutes
//            //                                self.parent.timer?.invalidate()
//            //                                self.parent.timer = nil
//            //                            }
//            //                        }
//            //                    }
//            //                } else {
//            // Stop the timer if the condition is not met
//            //            self.parent.timer?.invalidate()
//            //            self.parent.timer = nil
//            //            self.parent.alertCounter = 0
//            //        }}
//        }
    }
    
//    func startTimer() {
//            timerForApi = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: false) { _ in
//                // Timer fired, call API
//                self.callAPI()
//            }
//        }
//        func stopTimer() {
//            timerForApi?.invalidate()
//            timerForApi = nil
//        }
//        func callAPI() {
//            
//            WorkerCheckin.breakon()
//            status.isBreak = true
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "callBreakAuto"), object: self)
//
//        }
//    func showAlert() {
//        Toast(text: "jiferbhgferbjhiefr").show()
//       }
//    
//    func scheduleNotification(timeInterval: TimeInterval,message:String) {
//           let content = UNMutableNotificationContent()
//           content.title = "Alert"
//           content.body = message
//           content.sound = UNNotificationSound.default
//           
//           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
//           
//           let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
//           
//           UNUserNotificationCenter.current().add(request) { (error) in
//               if let error = error {
//                   print("Error scheduling notification: \(error.localizedDescription)")
//               } else {
//                   print("Notification scheduled successfully")
//               }
//           }}
//     
//    func playSiren() {
//            guard let url = Bundle.main.url(forResource: "YRL6BSM-siren", withExtension: "mp3") else { return }
//            
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: url)
//                audioPlayer?.numberOfLoops = 0
//                audioPlayer?.play()
//            } catch {
//                print("Error playing siren sound: \(error.localizedDescription)")
//            }
//        }
//    
    func isLocationWithinPolygons(_ coordinate: CLLocationCoordinate2D) -> Bool {
        for polygonVertices in polygons {
            let path = GMSMutablePath()
            for vertex in polygonVertices {
                for coordinate in vertex {
                    path.add(coordinate)
                }
                if let firstCoordinate = vertex.first {
                    path.add(firstCoordinate)
                }
            }
            
            if GMSGeometryContainsLocation(coordinate, path, true) {
                return true
            }
        }
        return false
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        return currentLocation
    }
    
    func populatePolygons(mapView: GMSMapView) {
        var coordinates = [[CLLocationCoordinate2D]]()
        for polygon in polygonArr {
            var coordinates = [[CLLocationCoordinate2D]]()
            if let polygonVertices = polygon as? NSArray {
                var coordinateArray = [CLLocationCoordinate2D]()
                for vertex in polygonVertices {
                    if let vertexArray = vertex as? NSDictionary,
                       let latString = vertexArray["lat"] as? Double,
                       let lngString = vertexArray["lng"] as? Double {
                        let lat = CLLocationDegrees(latString)
                        let lng = CLLocationDegrees(lngString)
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                        coordinateArray.append(coordinate)
                    }
                }
                coordinates.append(coordinateArray)
            }
            self.polygons.append(coordinates)
        }
        
        for polygonVertices in polygons {
            for coordinate in polygonVertices {
                let path = GMSMutablePath()
                for vertex in coordinate {
                    path.add(vertex)
                }
                if let firstCoordinate = coordinate.first {
                    path.add(firstCoordinate)
                }
                let polygon = GMSPolygon(path: path)
                polygon.strokeWidth = 2.0
                polygon.strokeColor = .red
                polygon.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.1)
                polygon.map = mapView
            }
        }
    }
    
 
}
