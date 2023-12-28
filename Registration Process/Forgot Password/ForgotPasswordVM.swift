//
//  ForgotPasswordVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 29/01/24.
//


import Foundation
import SwiftUI
import Alamofire
import JWTDecode
import Firebase


extension ForgotPassword  {

class forgotViewModel: ObservableObject {
    
    @Published  var forgotemailid: String = ""
    @Published  var companyId = String()
    @Published var showsetpasswordscreen: Bool = false
    
    
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    
    func forgotpassword() {
        
        var forgotpassworddata: Parameters {
            [
               // "token": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                "email": forgotemailid,
                "companyId": Int(companyId)
            ]
            
        }
        print(forgotpassworddata)
        
        print("hello")
        AccountAPI.signin(servciename: "user/forgotpassword", forgotpassworddata) { res in
            switch res {
            case .success:
                print("resulllll",res)
                if let json = res.value{
                    
                    print("Josn",json)

                        if json["status"] == true {
                            let userdic = json["data"]
                          //  self.sendOTP()
                            // Extract the JWT token from your response
                            
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()

                            }
                            self.showsetpasswordscreen.toggle()
                        }
                   
                    else{
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
