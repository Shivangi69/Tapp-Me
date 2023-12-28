//
//  ProfileVM.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 02/02/24.
//

import Foundation
    class ProfileVM: ObservableObject {
        
        @Published   var showview = false
      //  @Published  var ProfileModel: [ProfileModal] = []
        @Published  var ProfileModel: ProfileModal?
        @Published  var UserProfilemodel: UserProfile?
        @Published  var bankdetails: BankDetails?
        @Published  var workforce: WorkForcemodel?

        @Published  var document: Document?

        @Published  var languageskill: [LanguageSkill] = []
        @Published   var languageskillarray = [String]()
        
        @Published  var certificatearray: [Certificate] = []
      //  @Published  var certificatename = [String]()


        func  profilefetch(){
            let username =   UserDefaults.standard.string(forKey: "username") ?? ""
            
            let str =  "user/" + username
            AccountAPI.getsignin(servciename: str, nil){ res in
                switch res {
                case .success:
                    //  print("resulllll",res)
                    
                        
                        if let json = res.value{
                            
                        //    print("Josn",json)
                            
                            let Profilemodel = json["data"]
                            

                            let languageskills = Profilemodel["languageSkills"]
                            

                            let Userprofile = Profilemodel["userProfile"]

                            let bankDetailsData = Userprofile["bankDetails"]
                            let certificatesarray = Userprofile["certificates"]

                            let documents = certificatesarray["documents"]

                            self.languageskillarray = []

                            self.languageskill = []

                            self.certificatearray = []
                            
                            for i in languageskills {
                                
                                let acc = LanguageSkill(languageID: i.1["languageID"].intValue,
                                                        name: i.1["name"].stringValue,
                                                        status: i.1["status"].boolValue,
                                                        createdAt: i.1["createdAt"].stringValue,
                                                        createdBy: i.1["updatedAt"].stringValue, updatedAt: i.1["createdBy"].stringValue,
                                                        updatedBy: i.1["updatedBy"].stringValue)
                                
                                
                                self.languageskillarray.append(i.1["name"].stringValue)
                                self.languageskill.append(acc)
                                
                            }
                            
                            self.ProfileModel = ProfileModal(userID: Profilemodel["userID"].intValue,
                                                             username: Profilemodel["username"].stringValue,
                                                             name: Profilemodel["name"].stringValue,
                                                             email: Profilemodel["email"].stringValue,
                                                             phoneNo: Profilemodel["phoneNo"].stringValue,
                                                             imageURL: Profilemodel["imageUrl"].stringValue,
                                                             dob: Profilemodel["dob"].stringValue,
                                                             citizenship: Profilemodel["citizenship"].stringValue,
                                                             ssn: Profilemodel["ssn"].stringValue,
                                                             userProfile: self.UserProfilemodel ?? UserProfile(id: 0, employeeID: "", address: "", unionMembership: "", hireDate: "", employmentType: "", payRate: 0, certificates: self.certificatearray, skills: "",
                                                             
                                                            bankDetails: BankDetails(id: 0, holderName: "", bankName: "", accountNumber: "", accountType: "", ibanNumber: "", createdAt: "", createdBy: "", updatedAt: "", updatedBy: ""), emergencyNumber: "", bloodType: "", allergiesName: "", createdAt: "", createdBy: "", updatedAt: "", updatedBy: ""),
                                                             
                                                             languageSkills: self.languageskill,
                                                             userType: Profilemodel["userType"].stringValue,
                                                             status: Profilemodel["status"].boolValue,
                                                             isAccountBlocked: Profilemodel["isAccountBlocked"].boolValue,
                                                             isGoogleLinked: Profilemodel["isGoogleLinked"].boolValue,
                                                             isFacebookLinked: Profilemodel["isFacebookLinked"].boolValue,
                                                             createdAt: Profilemodel["createdAt"].stringValue)
                            
                      

                            UserDefaults.standard.synchronize() // Ensure UserDefaults are cleared immediately
                            UserDefaults.standard.set(Profilemodel["name"].string, forKey: "fname")
                            UserDefaults.standard.set(Profilemodel["isGoogleLinked"].bool, forKey: "isGoogleLinked")
                            UserDefaults.standard.set(Profilemodel["imageUrl"].string, forKey: "imageUrl")
                            UserDefaults.standard.set(Profilemodel["imageUrl"].string, forKey: "imageurlw")


                            
//                            UserDefaults.standard.string(forKey: "imageUrl")
                            self.UserProfilemodel = UserProfile(
                                
                                id: Userprofile["id"].intValue,
                                employeeID: Userprofile["employeeId"].stringValue,
                                address: Userprofile["address"].stringValue,
                                unionMembership: Userprofile["unionMembership"].stringValue,
                                hireDate: Userprofile["hireDate"].stringValue,
                                employmentType: Userprofile["employmentType"].stringValue,
                                payRate: Userprofile["payRate"].intValue,
                                certificates: self.certificatearray, // Provide the appropriate initialization for certificates
                                skills: "", // Provide the appropriate initialization for skills
                                bankDetails: BankDetails( // Provide the appropriate initialization for bankDetails
                                    id: 0,
                                    holderName: "",
                                    bankName: "",
                                    accountNumber: "",
                                    accountType: "",
                                    ibanNumber: "",
                                    createdAt: "",
                                    createdBy: "",
                                    updatedAt: "",
                                    updatedBy: ""
                                ),
                                emergencyNumber: Userprofile["emergencyNumber"].stringValue,
                                bloodType: Userprofile["bloodType"].stringValue,
                                allergiesName: Userprofile["allergiesName"].stringValue,
                                createdAt: Userprofile["createdAt"].stringValue,
                                createdBy: Userprofile["createdBy"].stringValue,
                                updatedAt: Userprofile["updatedAt"].stringValue,
                                updatedBy: Userprofile["updatedBy"].stringValue
                                
                            )

     
                            UserDefaults.standard.synchronize() // Ensure UserDefaults are cleared immediately

                            UserDefaults.standard.set(Userprofile["employeeID"].stringValue, forKey: "employeeID")

                            self.bankdetails = BankDetails(id: bankDetailsData["id"].intValue,
                                                            holderName: bankDetailsData["holderName"].stringValue,
                                                            bankName: bankDetailsData["bankName"].stringValue,
                                                            accountNumber: bankDetailsData["accountNumber"].stringValue,
                                                            accountType: bankDetailsData["accountType"].stringValue,
                                                           ibanNumber: bankDetailsData["ibanNumber"].stringValue,
                                                            createdAt: bankDetailsData["createdAt"].stringValue,
                                                            createdBy: bankDetailsData["createdBy"].stringValue,
                                                            updatedAt: bankDetailsData["updatedAt"].stringValue,
                                                            updatedBy: bankDetailsData["updatedBy"].stringValue)
                    
//
//                            self.document = Document(documentId: documents["documentId"].intValue,
//                                                     name: documents["name"].stringValue,
//                                                     documentUrl: documents["documentUrl"].stringValue,
//                                                     fileType: documents["fileType"].stringValue,
//                                                     fileSize: documents["fileSize"].stringValue)
                            
                            for i in certificatesarray {
                                
                                
                                let documents = i.1["documents"]

                                self.document = Document(documentId: documents["documentId"].intValue,
                                                         name: documents["name"].stringValue,
                                                         documentUrl: documents["documentUrl"].stringValue,
                                                         fileType: documents["fileType"].stringValue,
                                                         fileSize: documents["fileSize"].stringValue)
                                
                                print(self.document)
                                
                                let acc = Certificate(certificateId: i.1["certificateId"].intValue,
                                                      certificateName: i.1["certificateName"].stringValue,
                                                      documents: self.document ?? Document(documentId: 0, name: "", documentUrl: "", fileType: "", fileSize: "")
                                                       )
                                self.certificatearray.append(acc)
                                  
                            }
                            
                            
                      
                     
                        }
                    self.showview = true

                    
                case let .failure(error):
                    print(error)
                }
            }
        }
        
        func  WorkForceapi(){
            let userid =   UserDefaults.standard.string(forKey: "id") ?? ""
            
            let str =  "workforce/worker/" + userid
            
            AccountAPI.getsignin(servciename: str, nil){ res in
                switch res {
                case .success:
                    //  print("resulllll",res)
                    
                        
                        if let json = res.value{
                            
                            print("Josn",json)
                            
                            let workforcejson = json["data"]


                            print(workforcejson)

                          
                            self.workforce = WorkForcemodel(id: workforcejson["id"].intValue,
                                                       name: workforcejson["name"].stringValue,
                                                       supervisorName: workforcejson["supervisorName"].stringValue,
                                                       workers: workforcejson["workers"].intValue,
                                                       companySites: workforcejson["companySites"].stringValue)

                            print(" workforce%@" ,self.workforce)

                     
                            UserDefaults.standard.setValue(workforcejson["id"].intValue, forKey: "workforceid")
                            
                            
                            self.showview = true
                        }
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

