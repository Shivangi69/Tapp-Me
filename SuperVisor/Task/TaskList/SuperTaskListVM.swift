//
//  SuperTaskListVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 04/03/24.
//

import Foundation

class SuperTaskListVM: ObservableObject {
    
    @Published   var showview = false
    @Published   var TaskListdata: [Tasklist] = []

    @Published  var Taskmodel: TaskListData?


    @Published  var istaskassigned = false
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published var showassignedtask = Bool()
    @Published var showantssignedtask = Bool ()

    var totalPages : Int = 0
    var page : Int = 0
    var iq : Int = 0
//    
//    
    func loadMoreContent(currentItem item: Tasklist){
        let thresholdIndex = self.TaskListdata.index(self.TaskListdata.endIndex, offsetBy: -1)
        print(thresholdIndex)
        print("item.ID",item.ID)

        if thresholdIndex == item.ID   {
            page += 1
            print(item.ID)
            
            Getalltasklist()
        }
    }
    
    
//    func loadMoreContent(currentItem item: User){
//           let thresholdIndex = self.users.index(self.users.endIndex, offsetBy: -1)
//           if thresholdIndex == item.id, (page + 1) <= totalPages {
//               page += 1
//               Getalltasklist()
//           }
//       }
////
    func Getalltasklist()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        let istaskassignedString = istaskassigned.description.lowercased()
        
        let str = "task/allTask?supervisorId=" + userid + "&status=" + istaskassignedString + "&pageNumber=" + String(page) + "&pageSize=10&sortBy=createdAt&sortDir=desc"
        
        
        AccountAPI.getsigninwithoutLoader(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    let event = events["content"]
                    
              //  self.TaskListdata = []

                        for i in event {
                            
                            let acc = Tasklist(
                                ID: self.iq,
                                taskId: i.1["taskId"].intValue,
                                name: i.1["name"].stringValue,
                                description: i.1["description"].stringValue,
                                startDate: i.1["startDate"].stringValue,
                                dueDate: i.1["dueDate"].stringValue,
                                priority: i.1["priority"].stringValue,
                                etaskStatus: i.1["etaskStatus"].stringValue,
                                employeeId: i.1["employeeId"].stringValue,
                                userId: i.1["userId"].stringValue,
                                employeeName: i.1["employeeName"].stringValue

                            )
                            self.TaskListdata.append(acc)
                            self.iq = self.iq + 1

                          //
                        }
                    
                    
                    print(self.TaskListdata)
                    
                    self.Taskmodel = TaskListData(totalPages: events["totalPages"].intValue,
                                                  currentPage: events["currentPage"].intValue,
                                                  content: self.TaskListdata, totalElements: events["totalElements"].intValue
                                                  )
                    
                    print(" self.profilemodel%@" ,self.Taskmodel as Any)
                    
                    if (self.istaskassigned == true){
                        self.showassignedtask = true
                        self.showantssignedtask = false
                    }
                    
                    
                    else{
                        self.showassignedtask = false
                        self.showantssignedtask = true
                    }

                    
                    self.showview = true


              
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

