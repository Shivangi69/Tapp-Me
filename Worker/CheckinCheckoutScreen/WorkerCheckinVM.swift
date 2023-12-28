//
//  WorkerCheckinVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 16/02/24.
//

import Foundation
import Alamofire
import GoogleMaps
import GoogleSignIn
    
    class WorkerCheckinVM: ObservableObject {
        
        @Published var workerId = (UserDefaults.standard.string(forKey: "id") ?? "")
        @Published var siteId = Int()

        @Published var requestid = String()
        @Published var errormessage = String()

        @Published var sideir = Int()
        @Published var sImageVisible = Bool()

        @Published var mainview = false
        @Published var errorState = NSDictionary()
        @Published var showError = false
        @Published   var showview = false
        @Published   var showMAP = false

        @Published   var showcheckoutbutton = Bool()

        @Published  var AllCoordinateArray  = NSMutableArray()

        @Published  var siteidarray: [SiteidModel] = []
        var siteID1: Int? 
        @Published  var polygonvertices: [PolygonVertex1] = []

        func getsideid() {
            let userid = UserDefaults.standard.string(forKey: "id") ?? ""
            let str = "user/active/sites/" + userid
            self.showMAP = false
            AccountAPI.getsignin(servciename: str, nil) { res in
                switch res {
                case .success:
                    self.AllCoordinateArray.removeAllObjects()
                    if let json = res.value {
                       // print("Josn", json)
                        if json["statusCode"] == 200 || json["status"] == true {

                            let siteidarr = json["data"]
                            
                            
                            self.siteidarray = []
                            for i in siteidarr {
                                self.polygonvertices = []
                                let polygonvetx = i.1["polygonVertices"]
                                
                                let sitearr = SiteidModel(siteID: i.1["siteId"].intValue,
                                                          siteName: i.1["siteName"].stringValue,
                                                          boundaryAddress: i.1["boundaryAddress"].stringValue,
                                                          centerLatitude: i.1["centerLatitude"].doubleValue,
                                                          centerLongitude: i.1["centerLongitude"].doubleValue,
                                                          radius: i.1["radius"].intValue,
                                                          zoomLevel: i.1["zoomLevel"].intValue,
                                                          polygonVertices: self.polygonvertices,
                                                          workForces: i.1["workForces"].stringValue,
                                                          active: i.1["active"].boolValue )
                                
                                self.siteidarray.append(sitearr)
                                self.siteID1 = i.1["siteId"].intValue

                                UserDefaults.standard.set(i.1["centerLatitude"].intValue, forKey: "centerLatitude")
                                UserDefaults.standard.set(i.1["centerLongitude"].intValue, forKey: "centerLongitude")
                                UserDefaults.standard.set(i.1["workForces"].stringValue, forKey: "workForces")
                                UserDefaults.standard.set(i.1["siteName"].stringValue, forKey: "siteName")


                                
                                UserDefaults.standard.set(i.1["siteId"].intValue, forKey: "siteId")
                                print(i.1["siteId"].intValue)
                                
                                var CoordinateArray = NSMutableArray()
                                for j in polygonvetx {
                                    let acc = PolygonVertex1(
                                        lat: j.1["lat"].doubleValue,
                                        lng: j.1["lng"].doubleValue
                                    )
                                    var dic = NSDictionary()
                                    dic = ["lat": j.1["lat"].doubleValue, "lng": j.1["lng"].doubleValue]
                                    CoordinateArray.add(dic)
                                    self.polygonvertices.append(acc)
                                    
                                }
                                self.AllCoordinateArray.add(CoordinateArray)

                            }
                            UserDefaults.standard.setValue(self.AllCoordinateArray, forKey: "AllCoordinateArray")

                            self.showMAP = true
                            self.showview = true
                            
                        } else {
                            
                            let errormessage = json["message"].stringValue // Extract error message here
                            self.errormessage = errormessage // Assign error message to errormessage variable
                            print("msg is \(self.errormessage)")
                        }
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
        
        func OvertimecheckinandoutApi()  {
            //@Environment(\.managedObjectContext) var moc
            
            let str =  "api/checkinout/checkin-out-over-time/" + requestid + "/" + String(workerId) + "/"  + String(siteId)
            

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
                                
                         

                           }
                            
             
                            
                            
                            if (self.requestid == "CHECK-IN")
                            {
                                
                                self.showcheckoutbutton = true
//                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)

                              //  UserDefaults.standard.setValue(false, forKey: "isWorkerCheckedIn")
//                                UserDefaults.standard.setValue(false, forKey: "isWorkerCheckedOut")
//                                UserDefaults.standard.setValue(false, forKey: "isWorkerOvertimeCheckIn")
//                                
                            }else{
                                self.showcheckoutbutton = false
                                UserDefaults.standard.setValue(false, forKey: "isWorkerCheckedIn")
                                UserDefaults.standard.setValue(false, forKey: "isWorkerCheckedOut")
                                UserDefaults.standard.setValue(false, forKey: "isWorkerOvertimeCheckIn")
//
//                                UserDefaults.standard.setValue(false, forKey: "isWorkerOvertimeCheckIn")

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
            // MARK: - CodeAI Output
            // *** PLEASE SUBSCRIBE TO GAIN CodeAI ACCESS! ***
            /// To subscribe, open CodeAI MacOS app and tap SUBSCRIBE
        }
        
        func checkinandoutApi()  {
            //@Environment(\.managedObjectContext) var moc
            
            let str =  "api/checkinout/checkin-out/" + requestid + "/" + String(workerId) + "/"  + String(siteId)
            
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
                             //   self.showcheckoutbutton = true

                           }
     
                            
                            
                            if (self.requestid == "CHECK-IN")
                            {
//                                self.showcheckoutbutton = true

                                
//                                if UserDefaults.standard.bool(forKey: "isWorkerCheckedIn") == true{
//                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)
//                                    
//                                }
                                UserDefaults.standard.setValue(true, forKey: "isWorkerCheckedIn")
                                UserDefaults.standard.setValue(false, forKey: "isWorkerCheckedOut")
                                UserDefaults.standard.setValue(false, forKey: "isWorkerOvertimeCheckIn")
                                
                            }else{
                                self.showcheckoutbutton = false

                                UserDefaults.standard.setValue(false, forKey: "isWorkerCheckedIn")
                                UserDefaults.standard.setValue(true, forKey: "isWorkerCheckedOut")
                                UserDefaults.standard.setValue(false, forKey: "isWorkerOvertimeCheckIn")

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
            // MARK: - CodeAI Output
            // *** PLEASE SUBSCRIBE TO GAIN CodeAI ACCESS! ***
        /// To subscribe, open CodeAI MacOS app and tap SUBSCRIBE
        }
        
        
        func LogoutAPI()  {
            //@Environment(\.managedObjectContext) var moc
            
          //  var siteid = UserDefaults.standard.string(forKey: "siteId")!
            
            let siteid =   UserDefaults.standard.integer(forKey: "siteId") ?? 0

//            let jwttoken = UserDefaults.standard.string(forKey: "jwttoken")
            
            let str =  "auth/logout?siteId=" + String(siteid)
            


            AccountAPI.signinwithHeader(servciename: str, nil){ res in
                
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
            // MARK: - CodeAI Output
            // *** PLEASE SUBSCRIBE TO GAIN CodeAI ACCESS! ***
            /// To subscribe, open CodeAI MacOS app and tap SUBSCRIBE
        }
        
        
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
                                self.sImageVisible = true
                                
                                
                                UserDefaults.standard.setValue(true, forKey: "isBreak")
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
        
        
        func breakoff()  {
            //@Environment(\.managedObjectContext) var moc
            
            let str =  "api/checkinout/break/BREAK-OUT/" + String(workerId)
            
            AccountAPI.signin(servciename: str, nil){ res in
                
                switch res {
                case .success:
                    if let json = res.value {
                        
                        print(json)
                        
                        if json["status"] == true {
                            let userdic = json["data"]
                            
                            // Extract the JWT token from your response
                            UserDefaults.standard.setValue(false, forKey: "isBreak")

                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                                self.sImageVisible = false

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
            // MARK: - CodeAI Output
            // *** PLEASE SUBSCRIBE TO GAIN CodeAI ACCESS! ***
            /// To subscribe, open CodeAI MacOS app and tap SUBSCRIBE
        }
         
        
        
    }

