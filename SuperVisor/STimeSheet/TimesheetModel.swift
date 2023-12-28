//
//  TimesheetModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 01/05/24.
//

import Foundation

struct TimesheetModel: Codable , Hashable {
    let timesheetID, userId: Int
    let userName : String
    let  checkIn: String?
    let checkOut: String?
    let normalHours: Int?
    let checkInOvertime, checkOutOvertime: String?
   let breakTimearray: [breaktimemodel]
    let todayDate: String?
    let isOverTime: Bool
    let createdAt: String?
    let createdBy, updatedAt, updatedBy, totalBreakTime: String?
    let overTimeHours: Int?
    let goOutsideTime: String?

    
}



struct breaktimemodel: Codable , Hashable {
    let name, startTime ,endTime: String?
    let employeeId: Int
    let breakDuration: Int

}




struct Normalhours: Codable , Hashable {
    let hours, minutes: Int
    let percentage: String?
  
    
}


struct Overtime: Codable , Hashable {
    let hours, minutes: Int
    let percentage: String
  
    
}


struct totalhours: Codable , Hashable {
    let hours, minutes: Int
    
}
