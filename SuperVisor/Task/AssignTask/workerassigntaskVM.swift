//
//  workerassigntaskVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 05/03/24.
//

import Foundation

class workerassigntaskVM: ObservableObject {
    
    @Published   var showview = false
   // @Published   var Taskmodel = [TaskListData]()
    @Published   var workerTaskassignModel = [WorkerTaskassignModel]()
    @Published var taskid = Int()
    @Published var workerid = Int()
    @Published var AssignedIndex = Int()
    @Published var Assignedvalue = Bool()

    @Published var workeridstrng = String()

    @Published  var istaskassigned = true
    @Published  var filtername = ""
    @Published  var taskassigned = String()

    
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    
    var totalPages : Int = 0
    var page : Int = 0
    var iq : Int = 0
    
    
    
    func updateTaskAssignStatus(atIndex index: Int,assingd : Bool) {
            // Check if the index is within bounds
            guard index < workerTaskassignModel.count else {
                return
            }

            // Update the assigned status of the task at the specified index
        workerTaskassignModel[index].asiignd = assingd // Assuming you have a property asiignd to represent the assignment status
        }
    
    func loadMoreContent(currentItem item: WorkerTaskassignModel){
        let thresholdIndex = self.workerTaskassignModel.index(self.workerTaskassignModel.endIndex, offsetBy: -1)
        print(thresholdIndex)
        
        if thresholdIndex == item.ID   {
            page += 1
            print(item.ID)
            
            Getworkerlist()
        }
    }
    
    func Getworkerlist()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        let str = "workforce/worker/list/" + userid + "?filterName=" + filtername
        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    
                    self.workerTaskassignModel = []
                    
                    if json["status"] == true {
                        
                        let event = json["data"]
                    
                        for i in event {
                            
                            let acc = WorkerTaskassignModel(
                                ID: self.iq,
                                id: i.1["id"].intValue,
                                name: i.1["name"].stringValue,
                                employeeId: i.1["employeeId"].stringValue,
                                skills: i.1["skills"].stringValue, asiignd: true
                                
                            )
             
                            self.workerTaskassignModel.append(acc)
                            self.iq = self.iq + 1

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
    }
    
    
    func Getworkerlistwithfilter()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        let str = "workforce/worker/list/" + userid + "?filterName=" + filtername
        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    
                    self.workerTaskassignModel = []
                    
                    if json["status"] == true {
                        
                        let event = json["data"]
                    
                        for i in event {
                            
                            let acc = WorkerTaskassignModel(
                                ID: self.iq,
                                id: i.1["id"].intValue,
                                name: i.1["name"].stringValue,
                                employeeId: i.1["employeeId"].stringValue,
                                skills: i.1["skills"].stringValue, asiignd: true
                                
                            )
             
                            self.workerTaskassignModel.append(acc)
                            self.iq = self.iq + 1

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
    }
    
    
    
    
    func assigntasktoworker()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        
        let taskidstrng = String(taskid)
        let workeridstrng = String(workerid)
        
        let str = "task/assign/unassign/" + taskidstrng + "/" + workeridstrng + "/" + taskassigned
        
//        'http://62.171.153.83:8080/tappme-api-development/task/assign/unassign/35/50/false' \

        
        AccountAPI.signinwithHeader(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("josn", json)
                    
                    if json["status"] == true {
                        
                        let event = json["data"]
                    
                        if let msg = json["message"].string {
                            print("msg is \(msg)")
                            Toast(text: msg).show()
                            self.updateTaskAssignStatus(atIndex: self.AssignedIndex, assingd: self.Assignedvalue)
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
    }
    
    
}
