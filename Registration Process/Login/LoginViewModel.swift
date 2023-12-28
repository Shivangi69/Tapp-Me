//
//  LoginViewModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 23/01/24.
//

import Foundation
import SwiftUI
import Alamofire
import JWTDecode
import Firebase

extension Login  {
    
    class LoginViewModel: ObservableObject {
        
        @Published  var email = "Shivangi@gmail.com"
        @Published  var password = "Shivi@69"
        @Published  var homemodel: HomeViewModel?

        @Published  var companyId = String()
        
        @State private var alertMessage = ""
        @State private var showAlert = false
        
        @Published var errorState = NSDictionary()
        @Published  var showError = false
        
        @Published  var shownextscreen = false
        @Published  var goingtoreset = false
         
        
        func login() {
            
            var logInFormData: Parameters {
                [
                    "email": email,
                    "deviceToken": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                    "password": password,
                    "companyId": Int(companyId)!,
                    "deviceType": "IOS"
                ]
            }
            
            print(logInFormData)
            print("hello")
            
            AccountAPI.signin(servciename: "auth/login", logInFormData) { [self] res in
                switch res {
                case .success:
                    if let json = res.value {
                        
                        print(json)
                        
                        if json["status"] == true {
                            let userdic = json["data"]
                            
                            // Extract the JWT token from your response
                            if let token = userdic["token"].string {
                                UserDefaults.standard.setValue(token, forKey: "jwttoken")

                                print("Extracted Token:", token)
                                
                                do {
                                    let jwt = try decode(jwt: token)
                                    
                                    // Access JWT claims here
                                    if let mail = jwt.claim(name: "username").string {
                                        print("JWT Claims - Username:", mail)
                                        UserDefaults.standard.setValue(mail, forKey: "username")
                                    } else {
                                        print("Username claim not found in JWT.")
                                    }
                                    
                                    
                                    if let userType = jwt.claim(name: "userType").string {
                                        print("JWT Claims - UserType:", userType)
                                        UserDefaults.standard.setValue(userType, forKey: "Role")
                                        UserDefaults.standard.setValue(userType, forKey: "MainRole")
                                        
                                    } else {
                                        print("UserType claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let isFirstLogin = jwt.claim(name: "isFirstLogin").boolean {
                                        print("JWT Claims - IsFirstLogin:", isFirstLogin)
                                        UserDefaults.standard.setValue(isFirstLogin, forKey: "isFirstLogin")
                                    } else {
                                        print("IsFirstLogin claim not found in JWT.")
                                    }
                                    
                                    
                                    if let id = jwt.claim(name: "id").integer {
                                        print("JWT Claims - id:", id)
                                        UserDefaults.standard.setValue(id, forKey: "id")
                                    } else {
                                        print("id claim not found in JWT.")
                                    }
                                    
                                    
                                    if let companyId = jwt.claim(name: "companyId").integer {
                                        print("JWT Claims - companyId:", companyId)
                                        UserDefaults.standard.setValue(companyId, forKey: "usercompanyid")
                                    } else {
                                        print("companyId claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let name = jwt.claim(name: "name").string {
                                        print("JWT Claims - name:", name)
                                        UserDefaults.standard.setValue(name, forKey: "name")
                                    } else {
                                        print("name claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let imageUrl = jwt.claim(name: "imageUrl").string {
                                        print("JWT Claims - imageUrl:", imageUrl)
                                        UserDefaults.standard.setValue(imageUrl, forKey: "imageurlw")
                                    }
                                    
                                    else {
                                        print("imageUrl claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let employeeid = jwt.claim(name: "employeeId").string {
                                        print("JWT Claims - employeeId:", employeeid)
                                        UserDefaults.standard.setValue(employeeid, forKey: "employeeId")
                                    }
                                    
                                    else {
                                        print("employeeid claim not found in JWT.")
                                    }
                                       
                                    if let status = jwt.claim(name: "status").string {
                                        print("JWT Claims - status:", status)
                                        UserDefaults.standard.setValue(status, forKey: "status")
                                    }
                                    
                                    else {
                                        print("status claim not found in JWT.")
                                    }
                                    
                                    
                                    if let iat = jwt.claim(name: "iat").string {
                                        print("JWT Claims - iat:", iat)
                                        UserDefaults.standard.setValue(iat, forKey: "iat")
                                    }
                                    
                                    else {
                                        print("iat claim not found in JWT.")
                                    }
                                    
                                    
                                    if let exp = jwt.claim(name: "exp").string {
                                        print("JWT Claims - exp:", exp)
                                        UserDefaults.standard.setValue(exp, forKey: "exp")
                                    }
                                    
                                    else {
                                        print("exp claim not found in JWT.")
                                    }
                                    
                                    
                                    if let skills = jwt.claim(name: "skills").string {
                                        print("JWT Claims - skills:", skills)
                                        UserDefaults.standard.setValue(skills, forKey: "skills")
                                    }
                                    
                                    else {
                                        print("skills claim not found in JWT.")
                                    }
                                    
                                    if let workforceId = jwt.claim(name: "workforceId").integer {
                                        print("JWT Claims - workforceId:", workforceId)
                                        UserDefaults.standard.setValue(workforceId, forKey: "workforceId")
                                    
                                        
                                    }
                                    
                                    else {
                                        print("workforceId claim not found in JWT.")
                                    }
                                    
                                }
                                
                                catch {
                                    print("Failed to decode JWT:", error.localizedDescription)
                                }
                                
                                UserDefaults.standard.set("yes", forKey: "login")
                                
                            }
//
//                            if let msg = json["message"].string {
//                                print("msg is \(msg)")
//                                Toast(text: msg).show()
//                            }
//                            
//                            
                            
                            let userid =   UserDefaults.standard.string(forKey: "id") ?? ""

                            let str = "home/status/" + userid
                            AccountAPI.getsignin(servciename: str, nil){ res in
                                switch res {
                                case .success:
                                    
                                    if let json = res.value{
                                      //  print("Josn",json)
                                        
                                        let events = json["data"]
                                        
                                        self.homemodel = HomeViewModel(
                                  
                                            isAccountBlocked: events["isAccountBlocked"].boolValue,
                                            isGoogleLinked: events["isGoogleLinked"].boolValue,
                                            isFacebookLinked: events["isFacebookLinked"].boolValue,
                                            isFirstLogin: events["isFirstLogin"].boolValue,
                                            isSupervisor: events["isSupervisor"].boolValue,
                                            isWorkerCheckedIn: events["isWorkerCheckedIn"].boolValue, isWorkerCheckedOut: events["isWorkerCheckOut"].boolValue,
                                            isBreak: events["isBreak"].boolValue,
                                            isOutside: events["isOutside"].boolValue,
                                            active: events["active"].boolValue,
                                            isworkerovertimecheckin: events["isWorkerOvertimeCheckIn"].boolValue,
                                            status: events["status"].boolValue, workforceId: events["workforceId"].intValue
                                        )
                                        
                                        UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "Checkedin")
                                        UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "isWorkerCheckedIn")
                                        UserDefaults.standard.setValue(events["active"].boolValue, forKey: "active")

                                        UserDefaults.standard.setValue(events["isBreak"].boolValue, forKey: "isBreak")
                                        UserDefaults.standard.setValue(events["isOutside"].boolValue, forKey: "isOutside")
                                        UserDefaults.standard.setValue(events["isWorkerOvertimeCheckIn"].boolValue, forKey: "isWorkerOvertimeCheckIn")
                                        UserDefaults.standard.setValue(events["isWorkerCheckOut"].boolValue, forKey: "isWorkerCheckedOut")
                                       
                                        UserDefaults.standard.setValue(events["status"].boolValue, forKey: "status")
//                                        UserDefaults.standard.setValue(events["workforceId"].intValue, forKey: "workforceId")
                                        let wfID =    events["workforceId"].intValue
                                           UserDefaults.standard.setValue(wfID, forKey: "workforceId")
                                      
                                        if UserDefaults.standard.bool(forKey: "isFirstLogin") == false   {                             /*self.goingtoreset.toggle()*/
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RESET"), object: self)

                                        }
                                        
                                        else{
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LOGIN"), object: self)

                                        }


                                    }
                                case let .failure(error):
                                    print(error)
                                }
                            }
                            
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                            
                            
                            
                            
                            
                            
                          //  UserDefaults.standard.synchronize()
                           
                        }
                        
                        else {
                            
                            let userdic = json["errorState"]
                            if  userdic.count != 0  {
                                self.errorState = userdic.rawValue as! NSDictionary
                                self.showError = true
                            }
                            
                            else {
                                if let msg = json["message"].string {
                                    print("msg is \(msg)")
                                    Toast(text: msg).show()
                                }
                            }
                        }
                        
                    }
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    // Other classes or structs can be added here
    
}



class Connectsociallogin: ObservableObject {
    
//        @Published  var email = ""
//        @Published  var password = ""
    
    @Published  var email = UserDefaults.standard.string(forKey: "emailgoogle")
    
   // @Published  var email = UserDefaults.standard.string(forKey: "emailgoogle")

    @Published  var companyId = Int()
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published  var homemodel: HomeViewModel?


    @Published  var linked = false

    var statuscheck =  CompanylistbyemailVM()
    @Published  var shownextscreen1 = false
    @Published  var goingtodashboard1 = false
    @Published  var usercompanyid = UserDefaults.standard.integer(forKey: "usercompanyid")
    
    @Published  var textchange = false
    
    
    func GoogleConnect() {
        
        var logInFormData: Parameters {
            [
                "email": email ?? "",
                "deviceToken": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                "companyId": usercompanyid,
                
                "deviceType": "IOS",
                "phoneNo": "7078192345",
                "providerType": "google",
                "providerId": UserDefaults.standard.string(forKey: "Providerid") ?? "",
                "userId": UserDefaults.standard.string(forKey: "id") ?? "",
            //    "userId": "40",

            ]
        }
        
        print(logInFormData)
        
        print("hello")
        
        AccountAPI.signin(servciename: "auth/link/account", logInFormData) { [self] res in
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
                        
//                        if let googleaccountlinked = userdic["isGoogleLinked"].boolValue {
//                            UserDefaults.standard.setValue(googleaccountlinked, forKey: "googleaccountlinked")
//                            print(googleaccountlinked)
//                        }

//                       self.textchange = true
                        
                        UserDefaults.standard.set(true, forKey: "googleaccountlinkedtrue")
                        
                        
                        
                        
                      //  GetallStatusdata()
                      //  self.linked.toggle()
                
                    }
                    
                    
                    
                    
                    
                    else {
                        
                        let userdic = json["errorState"]
                        //     self.errorState = userdic.rawValue as! NSDictionary
                        //     self.showError = true
                        
                        
                        if  userdic.count != 0  {
                            self.errorState = userdic.rawValue as! NSDictionary
                            self.showError = true
                            
                        }
                        
                        else {
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
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
    
    
    
    func GetallStatusdata()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        
        let str = "home/status/" + userid
        
  //  http://62.171.153.83:8080/tappme-api-development/home/status/59

        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                  //  print("Josn",json)
                    
                    let events = json["data"]
                    
                    print (json)
                    
                    self.homemodel = HomeViewModel(
                  
                        isAccountBlocked: events["isAccountBlocked"].boolValue,
                        isGoogleLinked: events["isGoogleLinked"].boolValue,
                        isFacebookLinked: events["isFacebookLinked"].boolValue,
                        isFirstLogin: events["isFirstLogin"].boolValue,
                        isSupervisor: events["isSupervisor"].boolValue,
                        isWorkerCheckedIn: events["isWorkerCheckedIn"].boolValue,
                        isWorkerCheckedOut: events["isWorkerCheckOut"].boolValue,
                        isBreak: events["isBreak"].boolValue,
                        isOutside: events["isOutside"].boolValue,
                        active: events["active"].boolValue,
                        isworkerovertimecheckin: events["isWorkerOvertimeCheckIn"].boolValue,
                        status: events["status"].boolValue,
                        workforceId: events["workforceId"].intValue

                    )
                    
                    UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "Checkedin")
                    UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "isWorkerCheckedIn")
                    UserDefaults.standard.setValue(events["isBreak"].boolValue, forKey: "isBreak")
                    UserDefaults.standard.setValue(events["isOutside"].boolValue, forKey: "isOutside")
                    UserDefaults.standard.setValue(events["isWorkerOvertimeCheckIn"].boolValue, forKey: "isWorkerOvertimeCheckIn")
                    UserDefaults.standard.setValue(events["isWorkerCheckOut"].boolValue, forKey: "isWorkerCheckedOut")
                    UserDefaults.standard.setValue(events["active"].boolValue, forKey: "active")
                    UserDefaults.standard.setValue(events["status"].boolValue, forKey: "status")
//                    UserDefaults.standard.setValue(events["workforceId"].intValue, forKey: "workforceId")
                    let wfID =    events["workforceId"].intValue
                       UserDefaults.standard.setValue(wfID, forKey: "workforceId")

                  //  self.showFullview = true

              
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func logingoogle(){
        
        var logInFormData: Parameters {
            [
                "email": email,
              //  "deviceToken": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
             //  "companyId": UserDefaults.standard.string(forKey: "companyid") ?? "",
                "companyId": companyId ,

             //   "deviceType": "IOS",
              //  "phoneNo": "7078192345",
                "providerType": "google",
               // "providerId": UserDefaults.standard.string(forKey: "Providerid") ?? "",
              //  "userId": UserDefaults.standard.string(forKey: "id") ?? "",
            
            ]
        }
        
        print(logInFormData)
        
        print("hello")
        
        AccountAPI.signin(servciename: "auth/social/login", logInFormData) { [self] res in
            switch res {
            case .success:
                if let json = res.value {
                    
                    print(json)
                    
                
                        if json["status"] == true {
                            let userdic = json["data"]
                            
                            // Extract the JWT token from your response
                            if let token = userdic["token"].string {
                                print("Extracted Token:", token)
                                do {
                                    let jwt = try decode(jwt: token)
                                    
                                    // Access JWT claims here
                                    if let mail = jwt.claim(name: "username").string {
                                        print("JWT Claims - Username:", mail)
                                        UserDefaults.standard.setValue(mail, forKey: "username")
                                    } else {
                                        print("Username claim not found in JWT.")
                                    }
                                    
                                    
                                    if let userType = jwt.claim(name: "userType").string {
                                        print("JWT Claims - UserType:", userType)
                                        UserDefaults.standard.setValue(userType, forKey: "Role")
                                        UserDefaults.standard.setValue(userType, forKey: "MainRole")
                                        
                                    } else {
                                        print("UserType claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let isFirstLogin = jwt.claim(name: "isFirstLogin").boolean {
                                        print("JWT Claims - IsFirstLogin:", isFirstLogin)
                                        UserDefaults.standard.setValue(isFirstLogin, forKey: "isFirstLogin")
                                    } else {
                                        print("IsFirstLogin claim not found in JWT.")
                                    }
                                    
                                    
                                    if let id = jwt.claim(name: "id").integer {
                                        print("JWT Claims - id:", id)
                                        UserDefaults.standard.setValue(id, forKey: "id")
                                    } else {
                                        print("id claim not found in JWT.")
                                    }
                                    
                                    
                                    if let companyId = jwt.claim(name: "companyId").integer {
                                        print("JWT Claims - companyId:", companyId)
                                        UserDefaults.standard.setValue(companyId, forKey: "usercompanyid")
                                    } else {
                                        print("companyId claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let name = jwt.claim(name: "name").string {
                                        print("JWT Claims - name:", name)
                                        UserDefaults.standard.setValue(name, forKey: "name")
                                    } else {
                                        print("name claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let imageUrl = jwt.claim(name: "imageUrl").string {
                                        print("JWT Claims - imageUrl:", imageUrl)
                                        UserDefaults.standard.setValue(imageUrl, forKey: "imageUrl")
                                    }
                                    
                                    else {
                                        print("imageUrl claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let employeeid = jwt.claim(name: "employeeId").string {
                                        print("JWT Claims - employeeId:", employeeid)
                                        UserDefaults.standard.setValue(employeeid, forKey: "employeeId")
                                    }
                                    
                                    else {
                                        print("employeeid claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    if let status = jwt.claim(name: "status").string {
                                        print("JWT Claims - status:", status)
                                        UserDefaults.standard.setValue(status, forKey: "status")
                                    }
                                    
                                    else {
                                        print("status claim not found in JWT.")
                                    }
                                    
                                    
                                    if let iat = jwt.claim(name: "iat").string {
                                        print("JWT Claims - iat:", iat)
                                        UserDefaults.standard.setValue(iat, forKey: "iat")
                                    }
                                    
                                    else {
                                        print("iat claim not found in JWT.")
                                    }
                                    
                                    
                                    if let exp = jwt.claim(name: "exp").string {
                                        print("JWT Claims - exp:", exp)
                                        UserDefaults.standard.setValue(exp, forKey: "exp")
                                    }
                                    
                                    else {
                                        print("exp claim not found in JWT.")
                                    }
                                    
                                    
                                    if let skills = jwt.claim(name: "skills").string {
                                        print("JWT Claims - skills:", skills)
                                        UserDefaults.standard.setValue(skills, forKey: "skills")
                                    }
                                    
                                    else {
                                        print("skills claim not found in JWT.")
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                catch {
                                    print("Failed to decode JWT:", error.localizedDescription)
                                }
                                
                                UserDefaults.standard.set("yes", forKey: "login")
                                
                            }
                            
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                            
                            let userid =   UserDefaults.standard.string(forKey: "id") ?? ""

                            let str = "home/status/" + userid
                            AccountAPI.getsignin(servciename: str, nil){ res in
                                switch res {
                                case .success:
                                    
                                    if let json = res.value{
                                      //  print("Josn",json)
                                        
                                        let events = json["data"]
                                        
                                        self.homemodel = HomeViewModel(
                                     
                                            isAccountBlocked: events["isAccountBlocked"].boolValue,
                                            isGoogleLinked: events["isGoogleLinked"].boolValue,
                                            isFacebookLinked: events["isFacebookLinked"].boolValue,
                                            isFirstLogin: events["isFirstLogin"].boolValue,
                                            isSupervisor: events["isSupervisor"].boolValue,
                                            isWorkerCheckedIn: events["isWorkerCheckedIn"].boolValue, isWorkerCheckedOut: events["isWorkerCheckOut"].boolValue,
                                            isBreak: events["isBreak"].boolValue,
                                            isOutside: events["isOutside"].boolValue,
                                            active: events["active"].boolValue, 
                                            isworkerovertimecheckin: events["isWorkerOvertimeCheckIn"].boolValue,               status: events["status"].boolValue,
                                            workforceId: events["workforceId"].intValue
                                        )
                                        
                                        UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "Checkedin")
                                        UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "isWorkerCheckedIn")
                                        UserDefaults.standard.setValue(events["isBreak"].boolValue, forKey: "isBreak")
                                        UserDefaults.standard.setValue(events["isOutside"].boolValue, forKey: "isOutside")
                                        UserDefaults.standard.setValue(events["isWorkerOvertimeCheckIn"].boolValue, forKey: "isWorkerOvertimeCheckIn")
                                        UserDefaults.standard.setValue(events["isWorkerCheckOut"].boolValue, forKey: "isWorkerCheckedOut")
                                        UserDefaults.standard.setValue(events["active"].boolValue, forKey: "active")
                                        UserDefaults.standard.setValue(events["status"].boolValue, forKey: "status")
//                                        UserDefaults.standard.setValue(events["workforceId"].intValue, forKey: "workforceId")
                                        let wfID =    events["workforceId"].intValue
                                           UserDefaults.standard.setValue(wfID, forKey: "workforceId")

                                        if (userdic["isFirstLogin"].boolValue == true){
                                            self.shownextscreen1.toggle()
                                        }
                                        
                                        else{
                                            self.goingtodashboard1.toggle()
                                            
                                        }

                                  
                                    }
                                case let .failure(error):
                                    print(error)
                                }
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            
                           // UserDefaults.standard.synchronize()
                           
                         
                            
                        }
                    
                    else {
                        
                            let userdic = json["errorState"]
//                                                    self.errorState = userdic.rawValue as! NSDictionary
//                                                    self.showError = true
                        
                        
                        if  userdic.count != 0  {
                            self.errorState = userdic.rawValue as! NSDictionary
                            self.showError = true
                            
                        }
                        
                        else {
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
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
}






class CompanylistbyemailVM: ObservableObject {
    
    @Published   var showview = false
    @Published   var Companymodel = [CompanyListModel]()
    @Published   var Comapanyname = [String]()
    @Published   var CompanyID = [Int]()
    @Published   var defaultCompanyId = Int()
    
    @Published  var email = ""
    
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    
    func Companylistbyemail()  {
        //@Environment(\.managedObjectContext) var moc
        
        let str =  "company/byEmail/" + email
        self.Companymodel = []
        self.Comapanyname = []
        self.CompanyID = []
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                //  print("resulllll",res)
                
                if let json = res.value{
                    
         
                    print("Josn",json)
                    
                    if json["status"] == true {
                        
                        let events = json["data"]
                        
                        
                       
                        
                        for i in events {
                            let acc = CompanyListModel(
                                companyID: i.1["companyId"].intValue,
                                companyName: i.1["companyName"].stringValue,
                                email: i.1["email"].stringValue,
                                registrationNo: i.1["registrationNo"].stringValue,
                                taxAgencyNo: i.1["taxAgencyNo"].stringValue,
                                companySites: i.1["companySites"].arrayValue.map { $0.stringValue },
                                subscription: i.1["subscription"].stringValue,
                                skills: i.1["skills"].arrayValue.map { $0.stringValue },
                                currentPaymentStatus: i.1["currentPaymentStatus"].stringValue,
                                createdAt: i.1["createdAt"].stringValue,
                                createdBy: i.1["createdBy"].stringValue,
                                updatedAt: i.1["updatedAt"].stringValue,
                                updatedBy: i.1["updatedBy"].stringValue,
                                active: i.1["active"].boolValue)
                            
                            self.Comapanyname.append(i.1["companyName"].stringValue)
                            self.CompanyID.append(i.1["companyId"].intValue)
                            self.Companymodel.append(acc)
                            print(self.Companymodel)
                            
                        }
                        print(self.Comapanyname)
                        self.showview = true
                        
                        
                        if self.CompanyID.count > 0{
                            self.defaultCompanyId =  self.CompanyID[0]
                        }
                        
                        if let msg = json["message"].string {
                            print("msg is \(msg)")
                            Toast(text: msg).show()
                            
                        }
                        
                  
                        
                    }
                    
                    else {
                        
                        let userdic = json["errorState"]
                        if  userdic.count != 0  {
                            self.errorState = userdic.rawValue as! NSDictionary
                            self.showError = true
                            
                        }
                        
                        else {
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                        }
                        
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}




class CompanylistbyemailVMgoogle: ObservableObject {
    
    @Published   var showview = false
    @Published   var Companymodel = [CompanyListModel]()
    @Published   var Comapanyname = [String]()
    @Published   var CompanyID = [Int]()
    @Published   var defaultCompanyId = Int()
    @Published   var showFullview = false

   @Published  var email = UserDefaults.standard.string(forKey: "emailgoogle") ?? ""
    
    @Published var currentdate = String()
        
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published  var homemodel: HomeViewModel?
    @Published  var Checkinmodel: checkinmodel?

    

    func Companylist()  {
        
       // let str =  "company/byEmail/" + "Shivangibhargava69@gmail.com"
       let str =  "company/social/byEmail/" + email

        
        
        AccountAPI.getsignin(servciename: str, nil){ res in
            
            switch res {
            case .success:
                //  print("resulllll",res)
                
                if let json = res.value{
                    
                    self.Companymodel = []
                    self.Comapanyname = []
                    self.CompanyID = []
                    print("Josn",json)
                    
                    if json["status"] == true {
                        
                        let events = json["data"]
                        
                        for i in events {
                            let acc = CompanyListModel(
                                companyID: i.1["companyID"].intValue,
                                companyName: i.1["companyName"].stringValue,
                                email: i.1["email"].stringValue,
                                registrationNo: i.1["registrationNo"].stringValue,
                                taxAgencyNo: i.1["taxAgencyNo"].stringValue,
                                companySites: i.1["companySites"].arrayValue.map { $0.stringValue },
                                subscription: i.1["subscription"].stringValue,
                                skills: i.1["skills"].arrayValue.map { $0.stringValue },
                                currentPaymentStatus: i.1["currentPaymentStatus"].stringValue,
                                createdAt: i.1["createdAt"].stringValue,
                                createdBy: i.1["createdBy"].stringValue,
                                updatedAt: i.1["updatedAt"].stringValue,
                                updatedBy: i.1["updatedBy"].stringValue,
                                active: i.1["active"].boolValue)
                            
                            self.Comapanyname.append(i.1["companyName"].stringValue)
                            self.CompanyID.append(i.1["companyId"].intValue)
                            self.Companymodel.append(acc)
                            
                            
                        }
                        if self.CompanyID.count > 0{
                            self.defaultCompanyId =  self.CompanyID[0]
                        }
                        
                        //                        if let msg = json["message"].string {
                        //                            print("msg is \(msg)")
                        //                            Toast(text: msg).show()
                        //
                        //                        }
                        
                        // self.showview = true
                        
                    }
                    
                    else {
                        
                        let userdic = json["errorState"]
                        if  userdic.count != 0  {
                            self.errorState = userdic.rawValue as! NSDictionary
                            self.showError = true
                            
                        }
                        
                        else {
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                        }
                        
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    func GetallStatus()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        
        let str = "home/status/" + userid
        
  //  http://62.171.153.83:8080/tappme-api-development/home/status/59

        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                  //  print("Josn",json)
                    
                    let events = json["data"]
                    
                    print (json)
                    
                    self.homemodel = HomeViewModel(
              
                        isAccountBlocked: events["isAccountBlocked"].boolValue,
                        isGoogleLinked: events["isGoogleLinked"].boolValue,
                        isFacebookLinked: events["isFacebookLinked"].boolValue,
                        isFirstLogin: events["isFirstLogin"].boolValue,
                        isSupervisor: events["isSupervisor"].boolValue,
                        isWorkerCheckedIn: events["isWorkerCheckedIn"].boolValue,
                        isWorkerCheckedOut: events["isWorkerCheckOut"].boolValue,
                        isBreak: events["isBreak"].boolValue,
                        isOutside: events["isOutside"].boolValue,
                        active: events["active"].boolValue,
                        isworkerovertimecheckin: events["isWorkerOvertimeCheckIn"].boolValue,
                        status: events["status"].boolValue,
                        workforceId: events["workforceId"].intValue


                    )
                    
                    
                    
                    
                    
                    
                    UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "Checkedin")
                    UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "isWorkerCheckedIn")
                    UserDefaults.standard.setValue(events["isBreak"].boolValue, forKey: "isBreak")
                    UserDefaults.standard.setValue(events["isOutside"].boolValue, forKey: "isOutside")
                    UserDefaults.standard.setValue(events["isWorkerOvertimeCheckIn"].boolValue, forKey: "isWorkerOvertimeCheckIn")
                    UserDefaults.standard.setValue(events["isWorkerCheckOut"].boolValue, forKey: "isWorkerCheckedOut")
                    UserDefaults.standard.setValue(events["active"].boolValue, forKey: "active")
                    UserDefaults.standard.setValue(events["status"].boolValue, forKey: "status")
//
                    // Assuming `events` is your JSON data
                 let wfID =    events["workforceId"].intValue
                    UserDefaults.standard.setValue(wfID, forKey: "workforceId")
                    self.showFullview = true

              
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    func GetCheckintime()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        
        let str = "api/checkinout/daily-hours?userId=" + userid + "&date=" + currentdate

        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
              print("Josn",json)
                    
                    let events = json["data"]
                    
                    self.Checkinmodel = checkinmodel(
                        timesheetId: events["timesheetId"].intValue,
                        checkIn: events["checkIn"].stringValue,
                        checkInOvertime: events["checkInOvertime"].stringValue,
                        latestStartBreakTime: events["latestStartBreakTime"].stringValue,
                        latestEndBreakTime: events["latestEndBreakTime"].stringValue
                    )
                  //  UserDefaults.standard.setValue(events["isWorkerCheckedIn"].boolValue, forKey: "Checkedin")

                 print(" self.profilemodel%@" ,self.Checkinmodel as Any)
                  
                  //  self.showFullview = true

              
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}



