//
//  WorkerGeneralReportVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 23/04/24.
//

import Foundation

class WorkerGeneralReportVM: ObservableObject {
    
    @Published   var showview = false
    

    @Published  var WorkerGenralModel: [WorkerGenralReportModel] = []
    @Published  var workerReportDocResponses: [generalReportDocResponses] = []
    
    
    @Published  var isDraft = Bool()
    @Published  var eTaskReportStatus = ""
    @Published  var filtername = ""
    
    
    @Published var issuccessfull = Bool()
    @Published  var reportid = Int()
    
    
    @Published  var workReportDocID = Int()
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published var showassignedtask = Bool()
    @Published var showantssignedtask = Bool ()
    
    var totalPages : Int = 0
    var page : Int = 0
    var iq : Int = 0
    
    
    func Getallgeneralreport()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
        let isdraftstring = isDraft.description.lowercased()
        let str = "general/report/worker/list?workforceId=" + workforceId + "&userId=" + userid +  "&eTaskReportStatus=" + eTaskReportStatus  +  "&isDraft=" + isdraftstring
        
//    http://62.171.153.83:8080/tappme-api-development/general/report/worker/list?workforceId=20&userId=57&isDraft=false
//    http://62.171.153.83:8080/tappme-api-development/general/report/worker/list?workforceId=20&userId=57&eTaskReportStatus=During&isDraft=false

        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                    self.WorkerGenralModel = []
                    
                    //   self.workerReportDocRes.removeAll()
                    
                    for i in events {
                        
                        //   let workerreport = i.1["workerReportResponse"]
                        let workerreportdoc = i.1["generalReportDocResponses"]
                        
                        for j in workerreportdoc {
                            
                            let acc1 = generalReportDocResponses(
                                generalReportDocId: j.1["generalReportDocId"].intValue,
                                documentUrl: j.1["documentUrl"].stringValue,
                                fileName: j.1["fileName"].stringValue
                                
                            )
                            self.workerReportDocResponses.append(acc1)
                            
                            print("datapring", self.workerReportDocResponses )
                        }
                        
                        
                        let acc = WorkerGenralReportModel(
                            reportId: i.1["reportId"].intValue,
                            description: i.1["description"].stringValue,
                            name: i.1["name"].stringValue,
                            lat: i.1["lat"].stringValue,
                            lng: i.1["lng"].stringValue,
                            createdAt: i.1["createdAt"].stringValue,
                            etaskReportStatus: i.1["etaskReportStatus"].stringValue,
                            isDraft: i.1["isDraft"].boolValue,
                            isSubmitted: i.1["isSubmitted"].boolValue,
                            isReportSent: i.1["isReportSent"].boolValue,
                            location: i.1["location"].stringValue,
                            generalReportDocResponses: self.workerReportDocResponses)
                        
                        
                        self.WorkerGenralModel.append(acc)
                        
                        
                    }
                    self.showview = true
                }
                ///  }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    func Getreportbyid()  {
        
        let str = "general/report/" + String(reportid)
        
        
        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                    let workerreportdoc = events["generalReportDocResponses"]
                    
                    //     self.workerReportDocResponses = []
                    
                    
                    for j in workerreportdoc {
                        
                        let acc1 = generalReportDocResponses(
                            generalReportDocId: j.1["generalReportDocId"].intValue,
                            documentUrl: j.1["documentUrl"].stringValue,
                            fileName: j.1["fileName"].stringValue
                        )
                        self.workerReportDocResponses.append(acc1)
                        
                        
                        print("datapring", self.workerReportDocResponses )
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func downloadgeneralreport() {
        
      //  let str = "http://62.171.153.83:8080/tappme-api-development/general/report/download/pdf/" + String(reportid)

        let str = "http://62.171.153.83:8080/tappme-api-staging/general/report/download/pdf/" + String(reportid)

        
        
        
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
  
    
    func GetsuperVisorgenrallist()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""
        
        
        let isdraftstring = isDraft.description.lowercased()
      
        let str = "general/report/supervisor?workforceId=" + workforceId  + "&eTaskReportStatus=" + eTaskReportStatus + "&reportId=" + filtername +  "&pageNumber=0&pageSize=10&sortBy=id&sortDir=desc"
       

        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
             
                    
                    let events = json["data"]
                    let event = events["content"]
                    
                    self.WorkerGenralModel = []
                    
                  //  self.workerReportDocRes.removeAll()

                    
                    for i in event {
                        let workerreportdoc = i.1["generalReportDocResponses"]

                        for j in workerreportdoc {
                            
                            let acc1 = generalReportDocResponses(
                                generalReportDocId: j.1["generalReportDocId"].intValue,
                                documentUrl: j.1["documentUrl"].stringValue,
                                fileName: j.1["fileName"].stringValue
                                
                            )
                            self.workerReportDocResponses.append(acc1)
                            
                            print("datapring", self.workerReportDocResponses )
                        }
                        
                        
                        
                        let acc = WorkerGenralReportModel(
                            reportId: i.1["reportId"].intValue,
                            description: i.1["description"].stringValue,
                            name: i.1["name"].stringValue,
                            lat: i.1["lat"].stringValue,
                            lng: i.1["lng"].stringValue,
                            createdAt: i.1["createdAt"].stringValue,
                            etaskReportStatus: i.1["etaskReportStatus"].stringValue,
                            isDraft: i.1["isDraft"].boolValue,
                            isSubmitted: i.1["isSubmitted"].boolValue,
                            isReportSent: i.1["isReportSent"].boolValue,
                            location: i.1["location"].stringValue,
                            generalReportDocResponses: self.workerReportDocResponses)
                        
                        
                        self.WorkerGenralModel.append(acc)

                    }
                    
                    
                    
                }
                ///  }
            case let .failure(error):
                print(error)
            }
        }
    }
    

    
        func deletedata() {

        let str =  "general/report/documents/remove/" + String(workReportDocID)

            

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


