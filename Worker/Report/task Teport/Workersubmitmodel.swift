//
//  Workersubmitmodel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/03/24.
//

import Foundation
struct reportidmodel: Codable, Hashable {
    let taskID: Int
    let userID: Int
    let name: String
    let employeeID: String
    let employeeName: String
    let description, startDate, dueDate, priority: String
    let etaskStatus: String
    let workerReportResponse: WorkerReportResponse


}

// MARK: - WorkerReportResponse
struct WorkerReportResponse: Codable , Hashable {
    let reportID: Int
    let description : String
    let location: String
   let  workerReportDocResponses: [workerReportDocResponses]
    let isDraft, isSubmitted, isReportSent: Bool
    let createdAt, etaskReportStatus: String

}
struct workerReportDocResponses: Codable ,Hashable {
    let documentURL: String
    let fileName: String
    let workReportDocID: Int
    
    
}


// MARK: - NotificationList
struct NotificationList: Codable , Hashable{
    let id, recipientID, workforceID: Int
    let title, description, type, timestamp: String
    let status: String
    let createdBy: Int

}

struct Notificationcount: Codable , Hashable{
    let notificationCount : Int

}

struct readnotificationdata: Codable , Hashable{


    let status: String
    let id: Int

}

struct WorkerGenralReportModel: Codable, Hashable {
    let reportId: Int
    let description: String
    let name: String
    let lat: String
    let lng: String
    let createdAt: String
    let etaskReportStatus: String
    let isDraft, isSubmitted, isReportSent : Bool
    let location: String
    let generalReportDocResponses: [generalReportDocResponses]

    
    
    
    

}


struct generalReportDocResponses: Codable ,Hashable {
    let generalReportDocId: Int
    let documentUrl: String
    let fileName: String
    
    
}




