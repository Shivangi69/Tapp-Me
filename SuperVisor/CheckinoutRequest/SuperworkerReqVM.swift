//
//  SuperworkerReqVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 16/02/24.
//

import Foundation


extension SuperWorkerRequest {
    class SuperworkerReqVM: ObservableObject {
        @Published   var showview = false
        @Published  var rcnt: [SuperWorkerReqModel] = []
        @Published  var UserProfilemodel: UserProfile?
        
        
        @Published var flattype = ""
        @Published var requestid = Int()
        @Published var status = ""
        
        func  Superreqapi(){
            let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
            
            let str =  "api/checkinout/checkin/list/" + userid
            
            AccountAPI.getsignin(servciename: str, nil){ res in
                switch res {
                case .success:
                    //  print("resulllll",res)
                    
                    
                    if let json = res.value{
                        
                        print("Josn",json)
                        
                        let SuperWorkerReqjson = json["data"]
                        
                        
                        print(SuperWorkerReqjson)
                        
                        self.rcnt = []
                        
                        for i in SuperWorkerReqjson {
                            
                            let acc =  SuperWorkerReqModel(requestId: i.1["requestId"].intValue,
                                                           requestTime: i.1["requestTime"].stringValue,
                                                           flag: i.1["flag"].stringValue,
                                                           status: i.1["status"].stringValue,
                                                           siteId: i.1["siteId"].intValue, employeeID: i.1["employeeID"].stringValue, name: i.1["name"].stringValue )
                            
                            self.rcnt.append(acc)
                            
                        }
                        
                        self.showview = true
                    }
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
        
        func updateapiAR(){
            //   let requestid =   UserDefaults.standard.string(forKey: "requestid") ?? ""
            
            let str =  "api/checkinout/" + flattype + "/" + String(requestid) + "/status?status=" + status
            
            
     //   http://62.171.153.83:8080/tappme-api-development/api/checkinout/CHECK-IN/12/status?status=APPROVED

            
            AccountAPI.updateSignin(servciename: str, nil){ res in
                switch res {
                case .success:
                    //  print("resulllll",res)
                    
                    if let json = res.value{
                        
                        if json["status"] == true {
                            
                            let event = json["data"]
                            
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                            
                            
                            
                        }
                        
                        
                        self.Superreqapi()
                    self.showview = true

                    }
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
        
        
        
        func OvertimeupdateapiAR(){
            //   let requestid =   UserDefaults.standard.string(forKey: "requestid") ?? ""
            
            let str =  "api/checkinout/overtime/" + flattype + "/" + String(requestid) + "/status?status=" + status
            

            
     //   http://62.171.153.83:8080/tappme-api-development/api/checkinout/CHECK-IN/12/status?status=APPROVED

            
            AccountAPI.updateSignin(servciename: str, nil){ res in
                switch res {
                case .success:
                    //  print("resulllll",res)
                    
                    if let json = res.value{
                        
                        if json["status"] == true {
                            
                            let event = json["data"]
                            
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                            
                            
                            
                        }
                        
                        
                        self.Superreqapi()
                    self.showview = true

                    }
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
}
