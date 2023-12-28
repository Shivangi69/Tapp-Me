//
//  ComapanyListModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 24/01/24.
//

import Foundation

struct CompanyListModel: Codable, Hashable {
    let companyID: Int
    let companyName: String
    let email: String?
    let registrationNo, taxAgencyNo: String
    let companySites: [String]
    let subscription: String?
    let skills: [String]
    let currentPaymentStatus, createdAt: String
    let createdBy, updatedAt, updatedBy: String?
    let active: Bool


}

