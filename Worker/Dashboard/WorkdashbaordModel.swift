//
//  WorkdashbaordModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 22/03/24.
//

import Foundation
struct workerdashboardmodel: Codable , Hashable{
    let totalPages, currentPage: Int
    let tasklist: [tasklistmodel]
    let totalElements: Int
}

// MARK: - Content
struct tasklistmodel: Codable, Hashable {
    let taskID: Int
    let name, employeeID, employeeName: String
    let description, startDate, dueDate, priority: String
    let workerReportResponse: String
    let etaskStatus: String
    let taskCompletedTime: String
}

struct superdasworker: Codable, Hashable {
    let totalTasks: Int
    let totalCompletedTasks, totalWorkers, totalCheckedInWorkerToday: Int

}

struct dasworkermodel: Codable, Hashable {
    let tasksAssignedCount: Int
    let completedTasksCount : Int
   // , getovertime: Int

}
