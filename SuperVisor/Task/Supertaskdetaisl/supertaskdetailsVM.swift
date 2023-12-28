//
//  supertaskdetailsVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 07/03/24.
//

import Foundation


class supertaskdetailsVM: ObservableObject {
    
    @Published   var showview = false
    // @Published   var Taskmodel = [TaskListData]()
    @Published   var workerTaskassignModel = [WorkerTaskassignModel]()
    @Published var taskid = Int()
    @Published var workerid = Int()
    
    @Published var workeridstrng = ""
    
    @Published  var istaskassigned = true
    @Published  var taskassigned = "false"
    
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    
    var totalPages : Int = 0
    var page : Int = 0
    var iq : Int = 0
    
//    func unaasignedtask()  {
        func unaasignedtask(completion: @escaping () -> Void) {

        
        let taskidstrng = String(taskid)
        
        let str = "task/assign/unassign/" + taskidstrng + "/" + workeridstrng + "/" + "false"
        
        
        
        AccountAPI.signinwithHeader(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    
                    
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
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
        func deletetaskdetails(completion: @escaping () -> Void) {

            
        let str =  "task/" + String(taskid)
            
        AccountAPI.deleteRequest(servciename: str, nil){ res in
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
                        
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                    }
                    
                self.showview = true

                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    
}
    
    
 
