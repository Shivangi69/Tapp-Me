//
//  SupertimesheetVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 01/05/24.
 import Foundation

class SupertimesheetVM: ObservableObject {
    
    @Published   var showview = false
    @Published   var Timesheet: [TimesheetModel] = []
    @Published   var breaktime: [breaktimemodel] = []


    @Published   var normaltime: Normalhours?
    @Published   var overtime: Overtime?
    @Published   var totalhrs: totalhours?



    @Published  var requesttype = "checkIn"
  
    @Published   var datestrng = String()
    @Published   var fromdate = String()
    @Published   var todate = String()

    @Published  var filter = String()


    @Published var errorState = NSDictionary()
    @Published  var showError = false

    var totalPages : Int = 0
    var page : Int = 0
    var iq : Int = 0


////
    func Getsupertimesheet()  {
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
      //  let requesttype = requesttypestrng.description.lowercased()
        

        
        let str = "timesheet/list/supervisor?supervisorId=" + userid + "&date=" + datestrng +  "&requestTypeEnum=" + requesttype + "&pageNumber=0&pageSize=10&sortBy=timesheetId&sortDir=desc"
  
        
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
               print("Josn",json)
                    
                    let events = json["data"]
  
                    
                 self.Timesheet = []
                 //   self.breaktime = []


                        for i in events {
                            
                            self.breaktime = []
                            let event = i.1["breakTime"]

                            
                            for j in event {
                       
                                
                                let acc = breaktimemodel(
                                    
                                    name: j.1["name"].stringValue,
                                    startTime: j.1["startTime"].stringValue,
                                    endTime: j.1["endTime"].stringValue,
                                    employeeId: j.1["employeeId"].intValue,
                                    breakDuration: j.1["breakDuration"].intValue
                                )
                                self.breaktime.append(acc)
                            }
                       
                            
                            let acc = TimesheetModel(
                        
                                timesheetID: i.1["timesheetId"].intValue,
                                userId: i.1["userId"].intValue,
                                userName: i.1["name"].stringValue,
                                checkIn: i.1["checkIn"].stringValue,
                                checkOut: i.1["checkOut"].stringValue,
                                normalHours: i.1["normalHours"].intValue,
                                checkInOvertime: i.1["checkInOvertime"].stringValue,
                                checkOutOvertime: i.1["checkOutOvertime"].stringValue,
                                breakTimearray: self.breaktime,
                                todayDate: i.1["todayDate"].stringValue,
                                isOverTime: i.1["isOverTime"].boolValue,
                                createdAt: i.1["createdAt"].stringValue,
                                createdBy: i.1["createdBy"].stringValue,
                                updatedAt: i.1["updatedAt"].stringValue,
                                updatedBy: i.1["updatedBy"].stringValue,
                                totalBreakTime: i.1["totalBreakTime"].stringValue,
                                overTimeHours: i.1["overTimeHours"].intValue,
                                goOutsideTime: i.1["goOutsideTime"].stringValue
 
                            )
                            self.Timesheet.append(acc)
                           
                            
                       
                        }
                    self.showview = true
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    func downloadtimesheet() {
        

        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""

        let str = "http://62.171.153.83:8080/tappme-api-staging/timesheet/export-to-excel?supervisorId=" + String(190) + "&date=" + datestrng

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
    func Getworkertimesheet()  {
  
        
        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
     
        let str = "timesheet/worker/timesheet?userId=" + userid + "&fromDate=" + fromdate +  "&toDate=" + todate + "&requestTypeEnum=" + requesttype + "&pageNumber=0&pageSize=10&sortBy=timesheetId&sortDir=desc"
      
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
               print("Josn",json)
                    
                    let events = json["data"]
  
                    self.Timesheet = []
                    
                        for i in events {
                            
                            self.breaktime = []
                            let event = i.1["breakTime"]

                            
                            for j in event {
                                
                                let acc = breaktimemodel(
                                    
                                    name: j.1["name"].stringValue,
                                    startTime: j.1["startTime"].stringValue,
                                    endTime: j.1["endTime"].stringValue,
                                    employeeId: j.1["employeeId"].intValue,
                                    breakDuration: j.1["breakDuration"].intValue
                                )
                                self.breaktime.append(acc)
                            }
                       
                            
                            let acc = TimesheetModel(
                        
                                timesheetID: i.1["timesheetId"].intValue,
                                userId: i.1["userId"].intValue,
                                userName: i.1["name"].stringValue,
                                checkIn: i.1["checkIn"].stringValue,
                                checkOut: i.1["checkOut"].stringValue,
                                normalHours: i.1["normalHours"].intValue,
                                checkInOvertime: i.1["checkInOvertime"].stringValue,
                                checkOutOvertime: i.1["checkOutOvertime"].stringValue,
                                breakTimearray: self.breaktime,
                                todayDate: i.1["todayDate"].stringValue,
                                isOverTime: i.1["isOverTime"].boolValue,
                                createdAt: i.1["createdAt"].stringValue,
                                createdBy: i.1["createdBy"].stringValue,
                                updatedAt: i.1["updatedAt"].stringValue,
                                updatedBy: i.1["updatedBy"].stringValue,
                                totalBreakTime: i.1["totalBreakTime"].stringValue,
                                overTimeHours: i.1["overTimeHours"].intValue,
                                goOutsideTime: i.1["goOutsideTime"].stringValue
 
                            )
                            self.Timesheet.append(acc)
                           
                            
                       
                        }
                    self.showview = true
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    func Getallhours()  {
        

        let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
        
        let str = "api/checkinout/monthly-hours/" + userid +  "/" + filter
  
        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                 //   print("Josn",json)
                    
                    let events = json["data"]
                    let normalhrs = events["normalHours"]
                    let overtimehrs = events["overtimeHours"]
                    let totalhrs = events["totalHours"]

                    self.normaltime = Normalhours(
                        hours: normalhrs["hours"].intValue,
                        minutes: normalhrs["minutes"].intValue,
                        percentage: normalhrs["percentage"].stringValue)
                    
                    self.overtime = Overtime(
                        hours: overtimehrs["hours"].intValue,
                        minutes: overtimehrs["minutes"].intValue,
                        percentage: overtimehrs["percentage"].stringValue)
                    
                    
                    self.totalhrs = totalhours(
                        hours: totalhrs["hours"].intValue,
                        minutes: totalhrs["minutes"].intValue
                    )
            
                    self.showview = true

                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

