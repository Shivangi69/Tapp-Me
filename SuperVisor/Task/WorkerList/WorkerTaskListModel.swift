//
//  WorkerTaskListModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 19/04/24.
//

import Foundation


struct WorkerTaskListModel: Codable, Hashable, Identifiable {
    var id: String
    let data: [ViewdataModel]
    let status: String
    var isDataVisible: Bool = false // Property to track visibility of nested data

}

// MARK: - DatumDatum
struct ViewdataModel: Codable, Hashable , Identifiable{
    var id: String
    let taskID: Int
    let reportID, userID: Int?
    let name: String
    let employeeID, employeeName: String?
    let description, startDate, dueDate, priority: String
    let workerReportResponse, assigned: String?
    let etaskStatus: String

}

