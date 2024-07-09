//
//  HomeViewModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 05/04/24.
//

import Foundation


struct HomeViewModel: Codable, Hashable {
    var isAccountBlocked, isGoogleLinked, isFacebookLinked: Bool
    var isFirstLogin, isSupervisor, isWorkerCheckedIn,isWorkerCheckedOut, isBreak: Bool
    var isOutside, active ,isworkerovertimecheckin, status, isCheckInApproved: Bool
    var workforceId : Int
    
}

struct checkinmodel: Codable, Hashable {
    let timesheetId : Int
    let  checkIn, checkInOvertime: String
    let latestStartBreakTime ,  latestEndBreakTime : String
    

}
