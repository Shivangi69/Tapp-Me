//
//  WorkerCheckinModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 16/02/24.
//

//import Foundation





//
//// MARK: - ProfileModal/ Datalass
//struct ProfileModal: Codable, Hashable {
//    let userID: Int
//    let username, name, email, phoneNo: String
//    let imageURL: String
//    let dob, citizenship: String
//    let ssn: String?
//    let userProfile: UserProfile
//  //  let company: Company
//    let languageSkills: [LanguageSkill]
//    let userType: String
//    let status, isAccountBlocked, isGoogleLinked, isFacebookLinked: Bool
//    let createdAt: String
//
//    
//}
//
//// MARK: - Company
//struct Company: Codable, Hashable{
//    let companyID: Int
//    let companyName, email: String
//    let phoneNo: String?
//    let registrationNo, taxAgencyNo: String
//  let companySites: [CompanySite]
//    let subscription: String?
//    let currentPaymentStatus, createdAt: String
//    let createdBy, updatedAt, updatedBy: String?
//    //let active: Bool
//
//}
//
//// MARK: - LanguageSkill
//struct LanguageSkill: Codable , Hashable {
//    let languageID: Int
//    let name: String
//    let status: Bool
//    let createdAt, createdBy, updatedAt, updatedBy: String?
//}
//
//// MARK: - UserProfile
//struct UserProfile: Codable, Hashable {
//    let id: Int
//    let employeeID, address, unionMembership, hireDate: String
//    let employmentType: String
//    let payRate: Int
////  let timeSheets: [TimeSheet]
//    let certificates: [Certificate]
//    let skills: String
//  //  let companySites: [CompanySite]
//    let bankDetails: BankDetails
////    let assignedTask: [AssignedTask]
//    let emergencyNumber, bloodType, allergiesName, createdAt: String
//    let createdBy, updatedAt, updatedBy: String?
//  
//}
//
//
//// MARK: - TimeSheet
//
////struct TimeSheet: Codable, Hashable {
////    let timesheetId: Int
////    let userProfile: String
////    let checkIn, checkOut, todayDate: String
////    let isOverTime: Bool
////    let createdAt, createdBy, updatedAt, updatedBy: String
////    let breakTime: [BreakTime]
////}
////
//
//// MARK: - Certificate
//
//struct Certificate: Codable, Hashable {
//    let certificateId: Int
//    let certificateName: String
//    let documents: Document
//}
//
//// MARK: - Document
//struct Document: Codable, Hashable {
//    let documentId: Int
//    let name, documentUrl, fileType, fileSize: String
//}
//
//// MARK: - AssignedTask
////struct AssignedTask: Codable, Hashable {
////    let taskId, assignedTo: Int
////    let name, description, dueDate: String
////    let assigned: Bool
////    let assignedUser: User
////    let taskStatusList: [TaskStatus]
////    let workerReports: [WorkerReport]
////    let createdAt, createdBy, updatedAt, updatedBy: String
////}
////
//
//
//// MARK: - CompanySite
//struct CompanySite: Codable , Hashable {
//    let siteID: Int
//    let siteName, boundaryAddress: String
//    let centerLatitude, centerLongitude: Double
//    let radius, zoomLevel: Int
//    let polygonVertices: [PolygonVertex]
//   // let users, tasks: [JSONAny]
//    let active: Bool
//    let createdAt: String
//    let createdBy: String?
//    let updatedAt: String?
//    let updatedBy: Int?
//
//}
//
//// MARK: - PolygonVertex
//struct PolygonVertex: Codable , Hashable {
//    let lat, lng: Double
//}
//
//
//
//
//// MARK: - BankDetails
//struct BankDetails: Codable , Hashable {
//    let id: Int
//    let holderName, bankName, accountNumber, accountType: String
//    let ibanNumber: String?
//    let createdAt: String
//    let createdBy, updatedAt, updatedBy: String?
//}
//

struct SiteidModel: Codable, Hashable {
    let siteID: Int
    let siteName, boundaryAddress: String
    let centerLatitude, centerLongitude: Double
    let radius, zoomLevel: Int
    let polygonVertices: [PolygonVertex1]
    let workForces: String?
    let active: Bool
  //  let createdAt: String
 //   let createdBy, updatedAt, updatedBy: String?
}

// MARK: - PolygonVertex
struct PolygonVertex1: Codable, Hashable {
    let lat, lng: Double
}

