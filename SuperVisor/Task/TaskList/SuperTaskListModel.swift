//
//  SuperTaskListModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 04/03/24.
//

import Foundation

//struct TaskListResponse: Codable {
//    let status: Bool
//    let message: String
//    let taskListData: TaskListData
//}

struct TaskListData: Codable , Hashable{
    let totalPages: Int
    let currentPage: Int
    let content: [Tasklist]
    let totalElements: Int
}

struct Tasklist: Codable , Hashable {
    let ID: Int
    let taskId: Int
    let name: String
    let description: String
    let startDate: String
    let dueDate: String
    let priority: String
    let etaskStatus: String?
    let employeeId: String
    let userId: String
    let employeeName: String

    

    
}

