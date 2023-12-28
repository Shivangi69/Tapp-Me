//
//  CreateNewTaskVm.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 27/02/24.
//



import Foundation
import SwiftUI
import Alamofire
import JWTDecode
import Firebase

    
    class CreateNewTaskVm: ObservableObject {
    
        @Published  var name = ""
        @Published  var descriptionText: String = ""
        @Published  var startDate = ""
        @Published  var dueDate = ""
        @Published  var priority = "Medium"
        @Published  var taskid = Int()
        @Published   var showview = false

        @State private var alertMessage = ""
        @State private var showAlert = false
        @State private var sucessres = false

        
        @Published var errorState = NSDictionary()
        @Published  var showError = false
        
        @Published  var shownextscreen = false
        @Published  var goingtodashboard = false
        @Published  var token =  UserDefaults.standard.string(forKey: "jwttoken")
        @Environment(\.presentationMode) var presentationMode


    //    func crestetask() {
            func crestetask(completion: @escaping () -> Void) {

            
            var logInFormData: Parameters {
                [
                    "name": name,
                    "description": descriptionText,
                    "startDate": startDate,
                    "dueDate": dueDate,
                    "priority": priority
                 
                ]
            }
           
          
            print(logInFormData)
            print("hello")
            
            AccountAPI.signinwithHeader(servciename: "task/create" , logInFormData) { [self] res in
                
                
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
                            completion()
                            
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
        
            func Updatetaskdetails(completion: @escaping () -> Void) {

            //   let requestid =   UserDefaults.standard.string(forKey: "requestid") ?? ""
                
                var logInFormData: Parameters {
                    [
                       "name": name,
                        "description": descriptionText,
                        "startDate": startDate,
                        "dueDate": dueDate,
                        "priority": priority,
                        "assigned": true
                        
                    ]
                }
               
            print(logInFormData)
                
            let str =  "task/update/" + String(taskid)

            AccountAPI.updateEdittask(servciename: str, logInFormData){ res in
                switch res {
                case .success:
                    //  print("resulllll",res)
                    
                    if let json = res.value{
                        
                        print(json)
                        
                        if json["status"] == true {
                            
                            let event = json["data"]
                            
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                            completion()

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
                        
                    self.showview = true

                    }
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
        
        
        
        
//            func deletetaskdetails(completion: @escaping () -> Void) {
//
//                
//            let str =  "task/" + String(taskid)
//                
//            AccountAPI.deleteRequest(servciename: str, nil){ res in
//                switch res {
//                case .success:
//                    //  print("resulllll",res)
//                    
//                    if let json = res.value{
//                        
//                        print(json)
//                        
//                        if json["status"] == true {
//                            
//                            let event = json["data"]
//                            
//                            if let msg = json["message"].string {
//                                print("msg is \(msg)")
//                                Toast(text: msg).show()
//                            }
//                            completion()
//
//                        }
//                        
//                        else {
//                            
//                                if let msg = json["message"].string {
//                                    print("msg is \(msg)")
//                                    Toast(text: msg).show()
//                                }
//                        }
//                        
//                    self.showview = true
//
//                    }
//                    
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
    }
    

