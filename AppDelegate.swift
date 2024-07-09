//
//  AppDelegate.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 25/01/24.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import FirebaseAuth
import Alamofire
import SwiftUI
import Reachability
import GoogleSignIn
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces
import Network
import AVFoundation
import Combine

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate,MessagingDelegate, CLLocationManagerDelegate  {
    
   
    

    var window: UIWindow?
    var reachability: Reachability!
    
    // Create an instance of NetworkViewModel
    let networkViewModel = NetworkViewModel()
    var networkAlertWindow: UIWindow? // Add this line
    
    var WorkerCheckvm = WorkerCheckinVM()
    
 
     var timer2: Timer?

    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    var statuscheck = CompanylistbyemailVMgoogle()
    private let locationManager = CLLocationManager()
    
    //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
       
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowBluetooth])
            try AVAudioSession.sharedInstance().setActive(true)
        } 
        catch {
            print("Failed to set audio session category: \(error)")
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: nil)
        
        
        
        GMSPlacesClient.provideAPIKey("AIzaSyBn5gHHZP-V3517BQ163GxfuGZFckbefq8")
        
        GMSServices.provideAPIKey("AIzaSyBn5gHHZP-V3517BQ163GxfuGZFckbefq8")
        
        
        
        //        GIDSignIn.sharedInstance.clientID = "437527695659-8p43km4hcr5dcoagslro88cc8va6jk00.apps.googleusercontent.com"
        //        GIDSignIn.sharedInstance().delegate = self
        //
        //
        //
        UserDefaults.standard.set("fqLSImbFbk5zmQoX46qneC:APA91bFxGN3R_RHk_O32y1JyQkC60c06hD7eL_KcRiHxTeXjLQgHNgdvEhnrugvzLe7q-3mTDRYcXjBpSC7kNqXUCsf0pDrQSX6hFKe9HUbLaqbCFQRhE9ZVX8zvWZmQjSNqLnoVkk_A", forKey: "devicetoken")
        FirebaseApp .configure()
        Messaging.messaging().delegate = self
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            application.registerForRemoteNotifications()
            
            
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                       categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        UserDefaults.standard.set(token, forKey: "devicetoken")
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        
        
        
        
        if  UserDefaults.standard.string(forKey: "login") == "yes"  {
            WorkerCheckvm.getsideid()
            statuscheck.GetallStatus()
            startTimer5()
        }
        
        return true
    }
    
   
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()
        
        // Create the SwiftUI view that provides the window contents.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        backgroundTask = application.beginBackgroundTask(withName: "MyBackgroundTask") {
            // Cleanup code, if necessary
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
        }
        
        // Perform your task here
        timer2?.invalidate()

        application.endBackgroundTask(self.backgroundTask)
        backgroundTask = .invalid
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
//        startTimer5()
        locationManager.startUpdatingLocation()
    }

    
//    func startTimer5() {
//        timer2 = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
//              self?.WorkerCheckvm.getsideid()
//          }
//      }
//    
//    
    
    func startTimer5() {
        timer2 = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            // Timer fired, call API
            self.statuscheck.GetallStatus()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CallRefreshpage"), object: self)

            print("calingstatus")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.populatePolygons()
        
        let isWithinPolygons = isLocationWithinPolygons(location.coordinate)
        
        UserDefaults.standard.setValue(location.coordinate.latitude, forKey: "lat")
        UserDefaults.standard.setValue(location.coordinate.longitude, forKey: "lon")
        let location1 = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("CALLLLLLLLLLLLLLCURRENTAPPPPPP",location)
        print("parent.isWithinPolygons",isWithinPolygons)
        
        UserDefaults.standard.setValue(isWithinPolygons, forKey: "isWithinPolygons")
        print(isWithinPolygons)
        
        if (UserDefaults.standard.string(forKey: "login") != "yes"){
            return
        }
//        
//        if polygons.count == 0 {
//            return
//            
//        }
        
        if (UserDefaults.standard.bool(forKey: "isWorkerCheckedIn") == false) &&  (UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == false) &&   (UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == false){
            return
        }
        if polygons.count == 0 {
            return
        }
        

        if (UserDefaults.standard.bool(forKey: "isOutside") == true){
            return
        }
        
        if (UserDefaults.standard.bool(forKey: "isWorkerCheckedOut") == true && UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == false){
            return
        }
        
        
        if (UserDefaults.standard.bool(forKey: "isCheckInApproved") == false) &&  (UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn") == true){
            return
        }
        
        
        
        //        if  UserDefaults.standard.string(forKey: "login") == "yes"  {
        
        if  UserDefaults.standard.string(forKey: "login") == "yes"  {
            
            if !isWithinPolygons {
                
                if (UserDefaults.standard.bool(forKey: "isCheckInApproved")) && !(UserDefaults.standard.bool(forKey: "isBreak"))   {
                    
                    scheduleNotification(timeInterval: 1, message: "You Are Out of Boundry!")
                    playSiren()
                    
                    if !apiCalled {
                        startTimer()
                        apiCalled = true
                    }
                }
                
                if (UserDefaults.standard.bool(forKey: "isWorkerOvertimeCheckIn")) && !(UserDefaults.standard.bool(forKey: "isBreak"))   {
                    
                    
                    scheduleNotification(timeInterval: 1, message: "You Are Out of Boundry!")
                    playSiren()
                    //
                    //                if !apiCalled {
                    //                    apiCalled = true
                    //                    startTimer()
                    //                }
                }
                
                
            } else {
                
                stopTimer()
                
                if !(UserDefaults.standard.bool(forKey: "isCheckInApproved")) &&  UserDefaults.standard.string(forKey: "login") == "yes" {
                    // Start the timer if it's not already running
                    
                    print(timer as Any)
                    if timer == nil {
                        timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true) { _ in // 300 seconds = 5 minutes
                            self.scheduleNotification(timeInterval: 1, message: "You Are In Boundry,you have to check in!")
                            
                            self.playSiren()
                            self.alertCounter += 1
                            if self.alertCounter >= 6 { // 6 alerts * 5 minutes = 30 minutes
                                self.timer?.invalidate()
                                self.timer = nil
                                
                            }
                        }
                        print("yessstimesr")
                        
                    }
                } else {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.alertCounter = 0
                    print("nooootimer")
                }
                
                
                
            }
        }
        
        else {
            
            
            
            
        }
        
        
    }
    
    
    var polygons = [[[CLLocationCoordinate2D]]]()
    var polygonArr =  NSArray()
    
    func populatePolygons() {
        self.polygons.removeAll()
        if let polygonArraa = UserDefaults.standard.array(forKey: "AllCoordinateArray") as? NSArray {
            polygonArr = polygonArraa
            
        } else {
            // Handle the case where the array does not exist or casting fails
            print("The array for key 'AllCoordinateArray' does not exist or is not an NSArray.")
        }
        //        var coordinates = [[CLLocationCoordinate2D]]()
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
    }
    
    var timer: Timer?
    var alertCounter = 0
    var timerForApi: Timer? // Timer property to handle the 5-minute interval
    var apiCalled: Bool = false // Flag to track if API call has been made
    var audioPlayer: AVAudioPlayer?
    
    func startTimer() {
        timerForApi = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: false) { _ in
            // Timer fired, call API
            self.callAPI()
        }
    }
    func stopTimer() {
        timerForApi?.invalidate()
        timerForApi = nil
    }
    func callAPI() {
        
        //
        breakon()
        
    }
    
    
    var workerId = (UserDefaults.standard.string(forKey: "id") ?? "")
    func breakon()  {
        //@Environment(\.managedObjectContext) var moc
        
        let str =  "api/checkinout/break/BREAK-IN/" + String(workerId)
        
        
        AccountAPI.signin(servciename: str, nil){ res in
            
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
                            //                            self.sImageVisible = true
                            
                            
                            UserDefaults.standard.setValue(true, forKey: "isBreak")
                            self.apiCalled = false
                            self.timerForApi = nil
                            //            status.isBreak = true
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "callBreakAuto"), object: self)
                            
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
        // MARK: - CodeAI Output
        // *** PLEASE SUBSCRIBE TO GAIN CodeAI ACCESS! ***
        /// To subscribe, open CodeAI MacOS app and tap SUBSCRIBE
    }
    
    
    
    func showAlert() {
        Toast(text: "jiferbhgferbjhiefr").show()
    }
    
    func scheduleNotification(timeInterval: TimeInterval,message:String) {
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.body = message
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }}
    func scheduleNotificationrepeat(timeInterval: TimeInterval,message:String) {
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.body = message
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }}
    func playSiren() {
        guard let url = Bundle.main.url(forResource: "YRL6BSM-siren", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.play()
        } catch {
            print("Error playing siren sound: \(error.localizedDescription)")
        }
    }
    
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
        
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            options: options
        )
    }
    
    @objc func reachabilityChanged(_ notification: NSNotification) {
        print("Reachability changed") // Add this line for debugging
        guard let reachability = notification.object as? Reachability else { return }
        
        if reachability.connection == .unavailable {
            // Show NetworkAlert when there's no internet connection
            showNetworkAlert()
        } else {
            hideNetworkAlert()
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Google sign in error: \(error.localizedDescription)")
            return
        }
        
        // Perform actions after sign-in
        print("Successfully signed in with Google!")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        // Perform any final cleanup tasks here before the app terminates.
        // Save application data, close connections, etc.
        timer?.invalidate()
             timer = nil
        locationManager.startUpdatingLocation()
        print("Application will terminate")
    }
    
    
    func showNetworkAlert() {
        DispatchQueue.main.async {
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIHostingController(rootView: NetworkAlert(networkManager: self.networkViewModel))
            alertWindow.windowLevel = .alert + 1
            alertWindow.makeKeyAndVisible()
            self.networkAlertWindow = alertWindow
        }
    }
    
    func hideNetworkAlert() {
        DispatchQueue.main.async {
            self.window?.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    //    func applicationWillTerminate(_ application: UIApplication) {
    //          // Stop the reachability notifier when the app terminates
    //          reachability.stopNotifier()
    //      }
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        let tokenDict = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: NSNotification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict)
        print("Firebase registration token: \(fcmToken ?? "")")
        
        UserDefaults.standard.set(fcmToken, forKey: "devicetoken")
    }
    
    //    var window: UIWindow?
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let firebaseAuth = Auth.auth()
        
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
        
        //   Auth.auth().setAPNSToken(deviceToken, type: .prod)
        
        
        var token = ""
        Messaging.messaging().apnsToken = deviceToken
        
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        //  userDefault.set(token, forKey: "deviceToken")
        print("Registration succeeded!")
        print("Token: ", token)
        
        UserDefaults.standard.set(token, forKey: "devicetoken")
        
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
  
    
}


