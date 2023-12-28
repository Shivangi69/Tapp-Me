//
//  WorkerdashbaordVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 22/03/24.
//

import Foundation

class WorkerdashbaordVM: ObservableObject {
    
    @Published   var showview = false
    @Published  var tasklistdata: [tasklistmodel] = []
    
    @Published  var workerdashboard: workerdashboardmodel?
    
    @Published var shouldReload = UUID()
    @Published  var workerdas: dasworkermodel?
    @Published  var superdas: superdasworker?


    @Published  var isDraft = Bool()
    @Published  var eTaskReportStatus = "Pending"
    @Published  var filtername = ""
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published var showassignedtask = Bool()
    @Published var showantssignedtask = Bool ()
    
    var totalPages : Int = 0
    var page : Int = 0
    var iq : Int = 0
    
    //    func loadMoreContent(currentItem item: Tasklist){
    //        let thresholdIndex = self.TaskListdata.index(self.TaskListdata.endIndex, offsetBy: -1)
    //        print(thresholdIndex)
    //
    //        if thresholdIndex == item.ID   {
    //            page += 1
    //            print(item.ID)
    //
    //            Getalltasklist()
    //        }
    //    }
    //
    
    
    func getcompletedTask()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
  
        let str = "task/allCompletedTask?userId=" + userid + "&pageNumber=0&pageSize=10000&sortBy=createdAt&sortDir=desc"
// 
//    http://62.171.153.83:8080/tappme-api-staging/task/allCompletedTask?userId=57&pageNumber=0&pageSize=10&sortBy=createdAt&sortDir=desc

        
        
        AccountAPI.getsigninw(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                    let tasklist = events["content"]
                    
                    self.tasklistdata = []
                    
                    for i in tasklist {
                        
                        let acc = tasklistmodel(
                            taskID: i.1["taskId"].intValue,
                            name: i.1["name"].stringValue,
                            employeeID: i.1["employeeId"].stringValue,
                            employeeName: i.1["employeeName"].stringValue,
                            description: i.1["description"].stringValue,
                            startDate: i.1["startDate"].stringValue,
                            dueDate: i.1["dueDate"].stringValue,
                            priority: i.1["priority"].stringValue,
                            workerReportResponse: i.1["workerReportResponse"].stringValue,
                            etaskStatus: i.1["etaskStatus"].stringValue,
                            taskCompletedTime: i.1["taskCompletedTime"].stringValue

                            
                            
                        )
                        
                        self.tasklistdata.append(acc)
                    }
                        
                        self.workerdashboard = workerdashboardmodel(totalPages: events["totalPages"].intValue,
                                                                    currentPage: events["currentPage"].intValue,
                                                                    tasklist: self.tasklistdata, totalElements: events["totalElements"].intValue
                        )
                        
                        print(" self.workermodal%@" ,self.workerdashboard as Any)
                        
                     
                    
                }
                ///  }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getdasworker()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
  
        let str = "task/worker/list?workforceId=" + workforceId + "&userId=" + userid + "&eTaskStatus=" + eTaskReportStatus + "&pageNumber=0&pageSize=10&sortBy=id&sortDir=desc"
 
        
        
        
        AccountAPI.getsigninw(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                    let tasklist = events["content"]
                    
                    self.tasklistdata = []
                    
                    for i in tasklist {
                        
                        let acc = tasklistmodel(
                            taskID: i.1["taskId"].intValue,
                            name: i.1["name"].stringValue,
                            employeeID: i.1["employeeId"].stringValue,
                            employeeName: i.1["employeeName"].stringValue,
                            description: i.1["description"].stringValue,
                            startDate: i.1["startDate"].stringValue,
                            dueDate: i.1["dueDate"].stringValue,
                            priority: i.1["priority"].stringValue,
                            workerReportResponse: i.1["workerReportResponse"].stringValue, 
                            etaskStatus: i.1["etaskStatus"].stringValue,
                            taskCompletedTime: i.1["taskCompletedTime"].stringValue

                            
                            
                        )
                        
                        self.tasklistdata.append(acc)
                    }
                        
                        self.workerdashboard = workerdashboardmodel(totalPages: events["totalPages"].intValue,
                                                                    currentPage: events["currentPage"].intValue,
                                                                    tasklist: self.tasklistdata, totalElements: events["totalElements"].intValue
                        )
                        
                        print(" self.workermodal%@" ,self.workerdashboard as Any)
                        
                     
                    
                }
                ///  }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getsuperwprker()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
  
        let str = "dashboard/supervisor/" + workforceId
        

        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
            if json["status"] == true {
                    
                    let events = json["data"]
                    
                    
                    self.superdas = superdasworker(totalTasks: events["totalTasks"].intValue,
                                                   totalCompletedTasks: events["totalCompletedTasks"].intValue,
                                                   totalWorkers: events["totalWorkers"].intValue,
                                                   totalCheckedInWorkerToday: events["totalCheckedInWorkerToday"].intValue
                                                   
                                                   
                                                   
                                                   
                                                   
                    )
                    
                    print(" self.workermodal%@" ,self.superdas as Any)
                
                self.showview = true
//                
//                if let msg = json["message"].string {
//                    print("msg is \(msg)")
//                    Toast(text: msg).show()
//                }
                    
                }
                    else {
                        if let msg = json["message"].string {
                            print("msg is \(msg)")
                            Toast(text: msg).show()
                        }
                    }
                    
                }
                ///  }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getworkerdash()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
  
        let str = "dashboard/worker/" + workforceId


        AccountAPI.getsigninw(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                        
                        self.workerdas = dasworkermodel(tasksAssignedCount: events["tasksAssignedCount"].intValue,
                                                     completedTasksCount: events["completedTasksCount"].intValue
//                                                       totalWorkers: events["totalWorkers"].intValue,
//                                                       totalCheckedInWorkerToday: events["totalCheckedInWorkerToday"].intValue
                                                       
                        )
                        
                        print(" self.workermodal%@" ,self.workerdas as Any)
                    
                }
         
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    

}
