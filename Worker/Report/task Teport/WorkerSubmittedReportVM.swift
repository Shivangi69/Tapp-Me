//
//  WorkerSubmittedReportVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/03/24.
//

import Foundation

class WorkerSubmittedReportVM: ObservableObject {
    
    @Published   var showview = false
    @Published   var colorchange = false

    @Published  var workerreportlist: [reportidmodel] = []
    @Published  var Notificationlist: [NotificationList] = []

  //  @Published  var readnotificationmodeo: [readnotificationdata] = []

    
    @Published  var Noticount: Notificationcount?

    @Published  var readnotificationmodeo: readnotificationdata?

    @Published  var workerReportDocRes: [workerReportDocResponses] = []

    @Published  var WorkerReportmodel: WorkerReportResponse?
    
    @Published  var isDraft = Bool()
    @Published  var eTaskReportStatus = "After"
    @Published  var filtername = ""

    @Published  var noticount = Int()

    @Published var issuccessfull = Bool()
    @Published  var reportid = Int()
    
    @Published  var notificationid = String()

    @Published  var workReportDocID = Int()

    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published var showassignedtask = Bool()
    @Published var showantssignedtask = Bool ()
    
    var totalPages : Int = 0
    var page : Int = 0
    var iq : Int = 0
 
    
       func readnotification()  {
           
           
           let str = "notification/" + notificationid
       

           AccountAPI.getsigninw(servciename: str, nil){ res in
               switch res {
               case .success:
                   
                   if let json = res.value{
                       
                       print("Josn",json)
                       
                       let events = json["data"]
                       
                   //    self.readnotificationmodeo = []

                       
               
//                       for j in events {
//                           
//                           let acc1 = readnotificationdata(
//                            id: j.1["id"].intValue,
//                            recipientID: j.1["recipientId"].intValue,
//                            workforceID: j.1["workforceId"].intValue,
//                            title: j.1["title"].stringValue,
//                            description: j.1["description"].stringValue,
//                            type: j.1["type"].stringValue,
//                            timestamp: j.1["timestamp"].stringValue,
//                            status: j.1["status"].stringValue,
//                            createdBy: j.1["createdBy"].intValue
//                           )
//                           
//                           
//                           self.readnotificationmodeo.append(acc1)
//                           
//                           
//                           
//
//                           print("datapring", self.readnotification )
//                       }
             
                       
                       self.readnotificationmodeo = readnotificationdata(
         
                           status: events["status"].stringValue,
                           id: events["id"].intValue

                   )
                       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationCountUpdated"), object: nil)

                       print(self.readnotificationmodeo)
                        
                       
                       self.getallnotification()
                   //    self.colorchange = true
                       
                  // print(statuscheck)
                           
                       
                       self.showview = true
                   }
                   ///  }
               case let .failure(error):
                   print(error)
               }
           }
       }
    
       func getallnotification()  {
           
           let workforceId =   UserDefaults.standard.integer(forKey: "workforceId")
           
//           workforceId
           let str = "notification/worker/" + String(workforceId)
       
           
           AccountAPI.getsigninw(servciename: str, nil){ res in
               switch res {
               case .success:
                   
                   if let json = res.value{
                       
                       print("Josn",json)
                       
                       let events = json["data"]
             
//                       let notificationcnt = events["notificationCount"]
             
                       self.Notificationlist = []
                       
                       let notification = events["notificationList"]
                     
                           for j in notification {
                               
                               let acc1 = NotificationList(
                                id: j.1["id"].intValue,
                                recipientID: j.1["recipientId"].intValue,
                                workforceID: j.1["workforceId"].intValue,
                                title: j.1["title"].stringValue,
                                description: j.1["description"].stringValue,
                                type: j.1["type"].stringValue,
                                timestamp: j.1["timestamp"].stringValue,
                                status: j.1["status"].stringValue,
                                createdBy: j.1["createdBy"].intValue
                               )
                               
                          self.Notificationlist.append(acc1)
                               
                               print("datapring", self.Notificationlist )
                           }
                       
                       if let notificationCount = events["notificationCount"].int {
                        self.noticount = notificationCount

                                   }
                       
                       
//                       self.Noticount = Notificationcount(
         
                      //  notificationcnt: events["notificationCount"].intValue
                
                 //  )
                       

                    
                       
                       self.showview = true
                   }
                   ///  }
               case let .failure(error):
                   print(error)
               }
           }
       }
    
    func Getalltaskreport()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
        
        
        let isdraftstring = isDraft.description.lowercased()

        let str = "worker/report/list?workforceId=" + workforceId + "&userId=" + userid + "&reportId=" + filtername +  "&isDraft=" + isdraftstring + "&eTaskReportStatus=" + eTaskReportStatus
    
   // http://62.171.153.83:8080/tappme-api-development/general/report/worker/list?workforceId=20&userId=57&isDraft=false

        
        
        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
          
                    self.workerreportlist = []
                    
                 //   self.workerReportDocRes.removeAll()

                    
                    for i in events {
                        
                        let workerreport = i.1["workerReportResponse"]
                        let workerreportdoc = workerreport["workerReportDocResponses"]

                        for j in workerreportdoc {
                            
                            let acc1 = Tapp_Me.workerReportDocResponses(
                                documentURL: j.1["documentUrl"].stringValue,
                                fileName: j.1["fileName"].stringValue,
                                workReportDocID: j.1["workReportDocId"].intValue
                            )
                       self.workerReportDocRes.append(acc1)
                            
                            print("datapring", self.workerReportDocRes )
                        }
                        
                        
                       self.WorkerReportmodel = WorkerReportResponse(reportID: workerreport["reportId"].intValue,
                                                                      description: workerreport["description"].stringValue,
                                                                     location: workerreport["location"].stringValue, workerReportDocResponses: self.workerReportDocRes,
                                                                      isDraft: workerreport["isDraft"].boolValue,
                                                                      isSubmitted: workerreport["isSubmitted"].boolValue,
                                                                      isReportSent: workerreport["isReportSent"].boolValue,
                                                                      createdAt: workerreport["createdAt"].stringValue,
                                                                      etaskReportStatus: workerreport["etaskReportStatus"].stringValue)
                        
                        
                        let acc = reportidmodel(
                            taskID: i.1["taskId"].intValue,
                            
                            userID: i.1["userId"].intValue,
                            name: i.1["name"].stringValue,
                            employeeID: i.1["employeeId"].stringValue,
                            employeeName: i.1["employeeName"].stringValue,
                            description: i.1["description"].stringValue,
                            startDate: i.1["startDate"].stringValue,
                            dueDate: i.1["dueDate"].stringValue,
                            priority: i.1["priority"].stringValue,
                            etaskStatus: i.1["etaskStatus"].stringValue,
                            workerReportResponse: self.WorkerReportmodel ?? WorkerReportResponse(reportID: 0, description: "", location: "", workerReportDocResponses: self.workerReportDocRes, isDraft: true, isSubmitted: true, isReportSent: true, createdAt: "", etaskReportStatus: "")
                        )
                    
                        self.workerreportlist.append(acc)
                        
                    }
                    self.showview = true
                }
                ///  }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    
    
    func downloadtaskreport() {
        
      //  let str = "http://62.171.153.83:8080/tappme-api-development/worker/report/download/pdf/" + String(reportid)

        
        let str = "http://62.171.153.83:8080/tappme-api-staging/worker/report/download/pdf/" + String(reportid)

        
        
        
        
        if let pdfURL = URL(string: str),
           let pdfData = try? Data(contentsOf: pdfURL) {
            savePDFToCustomDirectory(pdfData: pdfData)
        } else {
            print("Invalid PDF URL or unable to fetch PDF data")
        }
    }
    
    
    
    func savePDFToCustomDirectory(pdfData: Data) {
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let customDirectory = documentsDirectory.appendingPathComponent(appName)
        
        // Check if the custom directory exists
        if !FileManager.default.fileExists(atPath: customDirectory.path) {
            // If not, create it
            do {
                try FileManager.default.createDirectory(at: customDirectory, withIntermediateDirectories: true, attributes: nil)
                print("Custom directory created: \(customDirectory)")
            } catch {
                print("Error creating custom directory: \(error.localizedDescription)")
                return
            }
        }
        
        let pdfFileName = "downloadedPDF-\(UUID().uuidString).pdf"
            let pdfFileURL = customDirectory.appendingPathComponent(pdfFileName)
            
            do {
                // Write the PDF data to the file URL
                try pdfData.write(to: pdfFileURL)
                print("PDF downloaded and saved to: \(pdfFileURL)")
                Toast(text: "PDF downloaded Successfully").show()

            } catch {
                print("Error saving PDF: \(error.localizedDescription)")
            }
        }
    
    func GetsuperVisorReportlist()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
        
        
        let isdraftstring = isDraft.description.lowercased()
      
        let str = "worker/report/supervisor/list?workforceId=" + workforceId + "&reportId=" + filtername + "&eTaskReportStatus=" + eTaskReportStatus + "&pageNumber=0&pageSize=10&sortBy=id&sortDir=desc"
       
   

        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
             
                    
                    let events = json["data"]
                    let event = events["content"]
                    
                    self.workerreportlist = []
                    

                    
                    for i in event {
                        
                        let workerreport = i.1["workerReportResponse"]
                        let workerreportdoc = workerreport["workerReportDocResponses"]

                        
                       self.WorkerReportmodel = WorkerReportResponse(reportID: workerreport["reportId"].intValue,
                                                                      description: workerreport["description"].stringValue,
                                                                     location: workerreport["location"].stringValue, workerReportDocResponses: self.workerReportDocRes,
                                                                      isDraft: workerreport["isDraft"].boolValue,
                                                                      isSubmitted: workerreport["isSubmitted"].boolValue,
                                                                      isReportSent: workerreport["isReportSent"].boolValue,
                                                                      createdAt: workerreport["createdAt"].stringValue,
                                                                      etaskReportStatus: workerreport["etaskReportStatus"].stringValue)
                        
                        
                        print(" self.workermodal%@" ,self.WorkerReportmodel as Any)
                        
                        //  self.workerreportlist.append(acc)

                        
                        for j in workerreportdoc {
                            
                            let acc1 = Tapp_Me.workerReportDocResponses(
                                documentURL: j.1["documentUrl"].stringValue,
                                fileName: j.1["fileName"].stringValue,
                                workReportDocID: j.1["workReportDocID"].intValue
                            )
                       self.workerReportDocRes.append(acc1)
                            
                            print("datapring", self.workerReportDocRes )
                        }
                        
                        
                        let acc = reportidmodel(
                            taskID: i.1["taskId"].intValue,
                            userID: i.1["userID"].intValue,
                            name: i.1["name"].stringValue,
                            employeeID: i.1["employeeId"].stringValue,
                            employeeName: i.1["employeeName"].stringValue,
                            description: i.1["description"].stringValue,
                            startDate: i.1["startDate"].stringValue,
                            dueDate: i.1["dueDate"].stringValue,
                            priority: i.1["priority"].stringValue,
                            etaskStatus: i.1["etaskStatus"].stringValue,
                            workerReportResponse: self.WorkerReportmodel ?? WorkerReportResponse(reportID: 0, description: "", location: "", workerReportDocResponses: self.workerReportDocRes, isDraft: true, isSubmitted: true, isReportSent: true, createdAt: "", etaskReportStatus: "")
                        )
                    
                        self.workerreportlist.append(acc)
                        print(self.workerreportlist)
                    }
                }
                ///  }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func Getreportbyid()  {
        
        let str = "worker/report/" + String(reportid)
    
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                    let workerreportdoc = events["workerReportDocResponses"]
                    
                    self.workerReportDocRes = []
                    
                    
                    for j in workerreportdoc {
                        
                        let acc1 = Tapp_Me.workerReportDocResponses(
                            documentURL: j.1["documentUrl"].stringValue,
                            fileName: j.1["fileName"].stringValue,
                            workReportDocID: j.1["workReportDocId"].intValue
                        )
                        self.workerReportDocRes.append(acc1)
                        
                        
                        print("datapring", self.workerReportDocRes )
                    }
                }
            
            case let .failure(error):
                print(error)
            }
        }
    }
    
   
    
        func deletedata() {

        let str =  "worker/report/documents/remove/" + String(workReportDocID)
            
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
              
                        self.issuccessfull = true

                    }
                    
                    else {
                        
                            if let msg = json["message"].string {
                                print("msg is \(msg)")
                                Toast(text: msg).show()
                            }
                    }
                    
             //   self.showview = true

                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
}


