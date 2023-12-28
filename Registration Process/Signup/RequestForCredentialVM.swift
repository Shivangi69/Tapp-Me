//
//  RequestForCredentialVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 31/01/24.
//


import Foundation
import SwiftUI
import Alamofire
import JWTDecode
import Firebase


//extension RequestForCredentials  {
    
    class RequestForCredentialVM: ObservableObject {
        
        @Published  var fullname = ""
        @Published  var email = ""
        @Published  var Phonenumber = ""
        @Published  var SSN = ""
        @Published  var EmergencyNumber = ""
        

        @Published  var companyId = String()
//        @State private var alertMessage = ""
//        @State private var showAlert = false
        
        @Published var errorState = NSDictionary()
        @Published  var showError = false
        @Published  var isShowingPopup = false

        
        func RequestCred() {
            
            var logInFormData: Parameters {
                [
                  //  "deviceToken": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                    "fullName": fullname,
                    "emailAddress": email,
                    "phoneNo": Phonenumber,
                    "ssn": SSN,
                    "companyId": Int(companyId),
                    "emergencyNumber": EmergencyNumber
                    
                ]
            }
            
            print(logInFormData)
            
            print("hello")
            
            AccountAPI.signin(servciename: "request/worker/save", logInFormData) { res in
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
                            
                            self.isShowingPopup.toggle()
                        }
                        else {
                    
                                let userdic = json["errorState"]
//                              self.errorState = userdic.rawValue as! NSDictionary
//                              self.showError = true
                            
                            if  userdic.count != 0 {
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
    
    









class CompanylistVM: ObservableObject {
    
    @Published   var showview = false
    @Published   var Companymodel = [AllCompList]()
    @Published   var Comapanyname = [String]()
    @Published   var CompanyID = [Int]()
 //   @Published  var emailID = UserDefaults.standard.string(forKey: "emaillist")
    
    func Companylistbyemail()  {
        //@Environment(\.managedObjectContext) var moc
        
        let str =  "company/list"
        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                //  print("resulllll",res)
                
                if let json = res.value{
                    
                    self.Companymodel = []
                    self.Comapanyname = []
                    self.CompanyID = []
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                    for i in events {
                        let acc = AllCompList(
                            companyID: i.1["companyID"].intValue,
                            companyName: i.1["companyName"].stringValue,
                            email: i.1["email"].stringValue,phoneNo: i.1["phoneNo"].stringValue,
                            registrationNo: i.1["registrationNo"].stringValue, taxAgencyNo: i.1["taxAgencyNo"].stringValue,
                            active: i.1["active"].boolValue
                        )

                        self.Comapanyname.append(i.1["companyName"].stringValue)
                        self.CompanyID.append(i.1["companyId"].intValue)
                        self.Companymodel.append(acc)
                    }
                    
                  //  self.showview = true
                }
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
