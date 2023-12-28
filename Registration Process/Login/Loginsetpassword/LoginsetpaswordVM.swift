//
//  LoginsetpaswordVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 31/01/24.
//

import Foundation
import SwiftUI
import Alamofire
import JWTDecode
import Firebase


extension LoginsetPassowrd  {
    
    class LoginsetpaswordVM: ObservableObject {
        
        @Published var errorState = NSDictionary()
        @Published  var showError = false
        
        @Published  var newpassword: String = ""
        @Published  var confirmpassword: String = ""
        
        @Published  var Mainview = false

        
        func loginsetnewpassword() {
            
            var forgotpassworddata: Parameters {
                [
                    "token": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                    "username": UserDefaults.standard.string(forKey: "username"),
                    "newPassword": newpassword,
                    "confirmPassword": confirmpassword
                ]
                         
            }
            
            print(forgotpassworddata)
            
            print("hello")
            AccountAPI.signin(servciename: "user/setnewpassword", forgotpassworddata) { [self] res in
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
                            
                            Mainview.toggle()
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
    
}
