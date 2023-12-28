//
//  RequesttogooutsideVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 06/03/24.
//

import Foundation

    class RequesttogooutsideVM: ObservableObject {
        
        @Published var showView = false
        @Published var errorState = NSDictionary()
        @Published var showError = false
        @Published var Reason = ""
        @Published var statuscheckdata = ""

        
        func outsiderequestAPi(completion: @escaping () -> Void) {
            
            let userid = UserDefaults.standard.string(forKey: "id") ?? ""
            
            let str = "api/checkinout/request/" + statuscheckdata +  "/" + userid + "?&reason=" + Reason
            
      //  http://62.171.153.83:8080/tappme-api-development/api/checkinout/request/GO-OUTSIDE/57?reason=nxvkjxvkxcjvx

            
            AccountAPI.signin(servciename: str, nil) { res in
                switch res {
                case .success(let json):
                    if json["status"].boolValue {
                        let event = json["data"]
                        if let msg = json["message"].string {
                            print("msg is \(msg)")
                            Toast(text: msg).show()
                        }
                        
                        
                        if self.statuscheckdata == "GO-OUTSIDE"
                        {
                            UserDefaults.standard.set(true, forKey: "isOutside")
                        }else{
                            UserDefaults.standard.set(false, forKey: "isOutside")

                        }
                        completion() // Call the completion handler
                  
                    } else {
                        let userdic = json["errorState"]
                        if userdic.count != 0 {
                            self.errorState = userdic.rawValue as! NSDictionary
                            self.showError = true
                        } else {
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
        }
    }
