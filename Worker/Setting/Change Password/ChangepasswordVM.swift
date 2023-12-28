//
//  ChangepasswordVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/02/24.
//

import Foundation
import Alamofire

extension ChangePassword  {
    
    class ChangepasswordVM: ObservableObject {

         @Published var newpassword = ""
          @Published var confirmpassword = ""
        @Published var oldpassword = ""

          @Published var mainview = false
          @Published var errorState = NSDictionary()
          @Published var showError = false
//          @Published var otp: [String] = Array(repeating: "", count: 6)

            
            func changepassword(completion: @escaping () -> Void) {

            
            var changepassword: Parameters {
                [
                    // "token": UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                "username": UserDefaults.standard.string(forKey: "username"),
                "newPassword": newpassword,
                "confirmPassword": confirmpassword,
                "oldPassword": oldpassword
                
                ]
            }
            print(changepassword)
            print("hello")
            AccountAPI.signin(servciename: "user/changepassword", changepassword) { res in
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
                            completion()

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
