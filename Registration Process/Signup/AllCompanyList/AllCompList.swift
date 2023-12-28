//
//  AllCompList.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/02/24.
//

import Foundation

struct AllCompList: Codable, Hashable {
    let companyID: Int
    let companyName, email: String
    let phoneNo: String?
  //  let currentPaymentStatus: CurrentPaymentStatus
    let registrationNo, taxAgencyNo: String?
    let active: Bool

//    enum CodingKeys: String, CodingKey {
//        case companyID = "companyId"
//        case companyName, email, phoneNo, currentPaymentStatus, registrationNo, taxAgencyNo, active
//    }
}
