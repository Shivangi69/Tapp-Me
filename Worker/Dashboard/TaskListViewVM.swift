//
//  TaskListViewVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 01/04/24.
//

import Foundation
import Alamofire
import SSSwiftUILoader


class TaskListViewVM: ObservableObject {
    
    @Published   var showview = false
    @Published  var tasklistdata: [tasklistmodel] = []
    @Published  var docfilemodelupload: [tasklistmodel] = []
    @Published   var dataArr = NSMutableArray()

    
 //   @Published  var workerReportDocRes: [workerReportDocResponses] = []
    
    
    
    @Published  var lat = Double()
    @Published  var long = Double()
 
    @Published  var workerdashboard: workerdashboardmodel?
    
    
    @Published  var isDraft = Bool()
    @Published  var uploaddone = Bool()

    
    @Published  var ismailsent = Bool()

    @Published  var eTaskReportStatus = String()
    @Published  var eTaskReportStatus1 = "Before"

    
    @Published  var Reportname = String()


    @Published  var place: String = ""
    
    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published var showassignedtask = Bool()
    @Published var showantssignedtask = Bool ()
    @Published  var issuccessfull = Bool()
    @Published  var iscomplete = false
    @Published  var isstart = ""

    @Published  var name = ""
    @Published  var descriptionText: String = ""
    @Published  var startDate = ""
    @Published  var dueDate = ""
    @Published  var priority = "Medium"
    @Published  var taskid = Int()

    @Published  var uploaddocarr: [String] = []
    @Published  var token =  UserDefaults.standard.string(forKey: "jwttoken")
    
    
    //func starttask () {
        
        func starttask(completion: @escaping () -> Void) {

    let taskidstrng = String(taskid)
    let str = "task/start/" + taskidstrng
    AccountAPI.signin(servciename: str, nil){ res in
        switch res {
        case .success:
            
            if let json = res.value{
                
                
                if json["status"] == true {
                    
                    let event = json["data"]
                    
                
                    if self.issuccessfull == event["taskStart"].boolValue {
                        print("iss \(self.issuccessfull)")
                    }

                    
                    
                    if let msg = json["message"].string {
                        print("msg is \(msg)")
                        Toast(text: msg).show()
                    }
                 //   completion()
                    self.issuccessfull = true
                    completion()
                 
                    
                    
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
}
    
 
func Closetask(completion: @escaping () -> Void) {

    
    let taskidstrng = String(taskid)
 
    let str = "task/complete/" + taskidstrng
    
    
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
                    self.iscomplete = true
                    
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
}
    
    
    
    
    func CreateTaskReport(completion: @escaping () -> Void) {
        
        var logInFormData: Parameters {
            [
                "description": descriptionText,
                "lat": lat,
                "lng": long,
                "location": place,
                "etaskReportStatus": eTaskReportStatus1,
                "certificateRequest":  dataArr,
                
            ]
        }
        
        print(logInFormData)
        print("hello")
        
        let isdraftstring = isDraft.description.lowercased()
        let taskidstrng = String(taskid)
        
        let ismailstring = ismailsent.description.lowercased()

        let str =  "worker/report/save?taskId=" + taskidstrng + "&isDraft=" +  isdraftstring + "&isSentToEmail="  + ismailstring

        
        
        AccountAPI.signinwithHeader(servciename: str , logInFormData) { [self] res in
            
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
    
    
    func UpdateTaskReport(completion: @escaping () -> Void) {
        
        var logInFormData: Parameters {
            [
                "description": descriptionText,
                "lat": lat,
                "lng": long,
                "location": place,
                "etaskReportStatus": eTaskReportStatus,
                "certificateRequest":  dataArr,
                
            ]
        }
        
        print(logInFormData)
        print("hello")
        
        let isdraftstring = isDraft.description.lowercased()
        let taskidstrng = String(taskid)
        
        let str =  "worker/report/update/" + taskidstrng + "/" +  isdraftstring
        
        
//        'http://62.171.153.83:8080/tappme-api-development/worker/report/update/12/true' \

        
        AccountAPI.updateEdittask(servciename: str , logInFormData) { [self] res in
            
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
    
    
    func UpdateGenralReport(completion: @escaping () -> Void) {
        
        var logInFormData: Parameters {
            [
                
                "name": Reportname,
                "description": descriptionText,
                "lat": lat,
                "lng": long,
                "location": place,
                "etaskReportStatus": eTaskReportStatus,
                "certificateRequest":  dataArr,
                
            ]
        }
        
        print(logInFormData)
        print("hello")
        
        let isdraftstring = isDraft.description.lowercased()
        let taskidstrng = String(taskid)
        
        let str =  "general/report/update/" + taskidstrng + "/" +  isdraftstring
        
        
        
//        'http://62.171.153.83:8080/tappme-api-development/worker/report/update/12/true' \

        
        AccountAPI.updateEdittask(servciename: str , logInFormData) { [self] res in
            
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
    
    func uploaadProfileImage(images: UIImage) {
        
        SSLoader.shared.startloader("Loading...", config: .defaultSettings)//http://eventsapp.biz/

        let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-staging/user/profile/photo")!
//        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        
        guard let jwtToken = UserDefaults.standard.string(forKey: "jwttoken") else {
                print("JWT token not found")
                return
            }
            
            let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer \(jwtToken)"
            ]
            Alamofire.upload(multipartFormData: { (formData) in
                    guard let imageData = images.jpegData(compressionQuality: 0.5) else {
                        return // Exit if unable to get JPEG data
                    }
                    formData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                }, to: baseURL, method: .put, headers: headers) { (result) in
            switch result {
                
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    SSLoader.shared.stopLoader()

                    if let json = response.value as? [String: Any] {
                        if let status = json["status"] as? Bool, status {
                            
                            
                            if let imageUrl = json["data"] as? String {
                                
                                UserDefaults.standard.set(imageUrl, forKey: "imageurlw")
                                 print(imageUrl)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setprofileupdated"), object: nil)

                            }
                
                            
                            
                            if let message = json["message"] as? String {
                                Toast(text: message).show()

                                print("Message: \(message)")
                            }
                        
                        } else {
                            if let errorMessage = json["errorMessage"] as? String {
                                print("Error: \(errorMessage)")
                            }
                        }
                    }
                }
                case .failure(let error):
                SSLoader.shared.stopLoader()

                print("Error in upload: \(error.localizedDescription)")
                // Handle error here
            }
        }
    }
    
    
    
    
    func uploadImage(images: [UIImage]) {
        
        SSLoader.shared.startloader("Loading...", config: .defaultSettings)//http://eventsapp.biz/

        let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-staging/upload/report/doc")!
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { (formData) in

            // Iterate over each image and append it to the formData
            for (index, image) in images.enumerated() {
                guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                    continue // Skip to the next image if unable to get JPEG data
                }
                formData.append(imageData, withName: "files", fileName: "image\(index).jpg", mimeType: "image/jpeg")
            }
        }, to: baseURL, method: .post, headers: headers) { (result) in
            switch result {
                
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    SSLoader.shared.stopLoader()

                    if let json = response.value as? [String: Any] {
                        if let status = json["status"] as? Bool, status {

                            if let message = json["message"] as? String {
                                print("Message: \(message)")
                            }
                            

                            
                            if let dataArray = json["data"] as? [[String: String]] {
                                let filenames = dataArray.map { $0["filename"] ?? "" }
                                // Do something with the filenames array, such as storing it or using it further
                                print("Uploaded filenames: \(filenames)")
                              
                                // Append dictionaries to dataArr
                                var dic  = NSDictionary()
                                
                                for filename in filenames {
                                    let dic: [String: String] = [
                                        "filename": filename
                                    ]
                                    self.showview = true

                                    self.dataArr.add(dic)
                                }
                                
                            //    CreateTaskReport(completion: @escaping () -> Void)
                                
                                
                                
                            }
     
                            
                            
                            

                        } else {
                            if let errorMessage = json["errorMessage"] as? String {
                                print("Error: \(errorMessage)")
                            }
                        }
                    }
                }
                case .failure(let error):
                SSLoader.shared.stopLoader()

                print("Error in upload: \(error.localizedDescription)")
                // Handle error here
            }
        }
    }
    
    
    
    func CreateGeneralReport(completion: @escaping () -> Void) {
        
        var logInFormData: Parameters {
            [
                "description": descriptionText,
                "lat": lat,
                "lng": long,
                "location": place,
                "etaskReportStatus": eTaskReportStatus,
                "certificateRequest":  dataArr,
                "name": Reportname,
                
                
            ]
        }
        
     
      print(logInFormData)
        

        let isdraftstring = isDraft.description.lowercased()
        
        let workforceId =   UserDefaults.standard.string(forKey: "workforceId") ?? ""

        let ismainstring = ismailsent.description.lowercased()

        let str =  "general/report/save?workforceId=" + workforceId + "&isDraft=" + isdraftstring + "&isSentViaEmail=" + ismainstring
        
        
        
 //   http://62.171.153.83:8080/tappme-api-staging/general/report/save?workforceId=19&isDraft=true&isSentViaEmail=false
        
        AccountAPI.signinwithHeader(servciename: str , logInFormData) { [self] res in
            
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
    }

