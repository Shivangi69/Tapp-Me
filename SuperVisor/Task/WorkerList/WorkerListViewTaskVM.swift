//
//  WorkerListViewTaskVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 19/04/24.
//

import Foundation


class WorkerListViewTaskVM: ObservableObject {
    
    @Published   var showview = false
    @Published   var datastatus: [WorkerTaskListModel] = []
    @Published   var ViewdataModeldata : [ViewdataModel] = []
    @Published   var usertaskid = ""

    @Published var errorState = NSDictionary()
    @Published  var showError = false
    
    func GetWorkerListView(){
        
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""

     

        let str = "task/" + workforceId + "/assignedTasks/" + usertaskid
        
        
  //  http://62.171.153.83:8080/tappme-api-development/task/20/assignedTasks/59

        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                   
                    
                    self.datastatus = []
                    
                    if json["status"] == true {
                        
                        let maindata = json["data"]
                        
                       // let event = maindata["data"]

//                        let event = maindata["data"]
                        
                        
//                        self.ViewdataModeldata = []
                        for j in maindata {
                            let datashow = j.1["data"]
                            self.ViewdataModeldata = []


                            for i in datashow {
                                
                                
                                let acc = ViewdataModel(
                                    id: "", taskID: i.1["taskId"].intValue,
                                    reportID: i.1["reportID"].intValue,
                                    userID: i.1["userID"].intValue,
                                    name: i.1["name"].stringValue,
                                    employeeID: i.1["employeeId"].stringValue,
                                    employeeName: i.1["employeeName"].stringValue,
                                    description: i.1["description"].stringValue,
                                    startDate: i.1["startDate"].stringValue,
                                    dueDate: i.1["dueDate"].stringValue,
                                    priority: i.1["priority"].stringValue,
                                    workerReportResponse: i.1["workerReportResponse"].stringValue,
                                    assigned: i.1["assigned"].stringValue,
                                    etaskStatus: i.1["etaskStatus"].stringValue
                                    
                                )
                                self.ViewdataModeldata.append(acc)
                                
                            }
                            
                            let acc = WorkerTaskListModel(
                                id: "", data: self.ViewdataModeldata,
                                status: j.1["status"].stringValue
                            )
                            self.datastatus.append(acc)
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
