//
//  ChannelListModel.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/05/24.
//

import Foundation

// MARK: - Datum
struct ChatchennelModel: Codable , Hashable {
    let userSummary: UserSummary
    let messageCount: Int
    let recentMessage: RecentMessage?
}

// MARK: - RecentMessage
struct RecentMessage: Codable, Hashable {
    let id: Int
    let chatID: String
    let senderID, recipientID: Int
    let senderName, recipientName, content, timestamp: String
 //   let chatImages: []
    let status: String

}

// MARK: - UserSummary
struct UserSummary: Codable , Hashable {
    let userID: Int
    let email, name: String
    let imageName: String

}

// MARK: - Encode/decode helpers

// MARK: - Welcome
struct ChatViewdataModel: Codable , Hashable{
    let id: Int
    let chatID: String
    let senderID, recipientID: Int
    let senderName, recipientName, content: String
    let timestamp: String
    let chatImages: [ChatImagemodel]
    let status: String 
    let chatImagesss: [String]
    let is_sent_by_me: Bool
}

// MARK: - ChatImage
struct ChatImagemodel: Codable, Hashable {
    let chatID: Int
    let imageURL: String
 
}
