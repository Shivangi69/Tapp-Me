//
//  SetnewpasswordVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 29/01/24.
//

import Foundation
import SwiftUI
import Alamofire
import JWTDecode
import Firebase

extension Setnewpassword  {
    
    class SetnewpasswordVM: ObservableObject {
//      @Published  var newpassword : String = ""
//      @Published  var confirmpassword: String = ""
        
         @Published var newpassword = ""
          @Published var confirmpassword = ""
          @Published var email: String = (UserDefaults.standard.string(forKey: "forgotemail") ?? "")
          @Published var companyId = String()
          @Published var mainview = false
          @Published var errorState = NSDictionary()
          @Published var showError = false
//          @Published var otp: [String] = Array(repeating: "", count: 6)

        @Published  var otp: String = ""

        func setnewpassword() {
            
            var forgotpassworddata: Parameters {
                [
                    // "token": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                "email": email,
              //  "companyId": UserDefaults.standard.integer(forKey: "companyId"),
                "companyId":companyId,

                "newPassword": newpassword,
                "confirmPassword": confirmpassword,
                "otpValue": otp
                 
                ]
            }
            print(forgotpassworddata)
            print("hello")
            AccountAPI.signin(servciename: "user/resetpassword", forgotpassworddata) { res in
                switch res {
                case .success:
                    print("resulllll",res)
                    if let json = res.value {
                        
                        print(json)
                        
                        if json["status"] == true {
                            let userdic = json["data"]
                            
                            // Extract the JWT token from your response
                            
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                            
                            self.mainview.toggle()

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
        }
    }
}
