//
//  SuperWorkerReqModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 16/02/24.
//

import Foundation

struct SuperWorkerReqModel: Codable, Hashable {
    let requestId: Int
    let requestTime, flag, status: String
    let siteId: Int
    let employeeID, name: String
   
}

//
//
//struct UserModeldata: Codable, Hashable {
//    let id: Int
//    let employeeID, address, unionMembership, hireDate: String
//    let employmentType: String
//  
//    let emergencyNumber, bloodType, allergiesName, createdAt: String
//    let createdBy, updatedAt, updatedBy: String?
//  
//}
