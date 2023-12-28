//
//  ViewController.swift
//  StompClientLibExample
//
//  Created by Kuray on 8.10.2020.
//

import UIKit
import StompClientLib
import Foundation
import Combine
import SwiftyJSON

extension ChatVC {
class ViewController: ObservableObject, StompClientLibDelegate {
    @Published var connectionLabel = ""
//    @Published var connectionLabelColor = Color.primary
    
    var socketClient = StompClientLib()
    let topic = "/user"
    let baseURL = "http://62.171.153.83:8080"
    var wsURL: String {
        String(baseURL.dropFirst(7))
    }
    var completedWSURL: String {
        "ws://\(wsURL)/tappme-api-staging/ws/websocket"
    }
    
    init() {
        registerSocket()
    }
    
    func registerSocket() {
        if let url = URL(string: completedWSURL) {
            socketClient.openSocketWithURLRequest(request: URLRequest(url: url) as NSURLRequest, delegate: self)
            print(" WebSocket URL connected: \(completedWSURL)")

            
        } else {
            print("Invalid WebSocket URL: \(completedWSURL)")
        }
    }
    
    
    func disconnect() {
        socketClient.disconnect()
    }
    
    func sendMessage() {
        //socketClient.sendMessage(message: "StompClientLib Foo", toDestination: "/app/hello", withHeaders: nil, withReceipt: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let currentDateTime = Date()
        let formattedDateTime = dateFormatter.string(from: currentDateTime)

        print(formattedDateTime)
        
        let senderId = UserDefaults.standard.integer(forKey: "id")
        let recipientId = 43 //chatdata.userSummary.userID
        let senderName = UserDefaults.standard.string(forKey: "name") ?? ""
        let recipientName = "Shivangi Bhargava Supervisor"//chatdata.userSummary.name
        let msg = "Hiiiii shivii"
        let timestamp = formattedDateTime

        let messageJSON = JSON([
            "senderId": senderId,
            "recipientId": recipientId,
            "senderName": senderName,
            "recipientName": recipientName,
            "content": msg,
            "timestamp": timestamp
        ])
//            let dict: [String: Any] = [
//                "senderId": UserDefaults.standard.integer(forKey: "id"),
//                "recipientId": chatdata.userSummary.userID,
//                "senderName": UserDefaults.standard.string(forKey: "name") ?? "",
//                "recipientName": chatdata.userSummary.name,
//                "content": msg,
//                "timestamp": formattedDateTime
//            ]
////
        let jsonString = messageJSON.rawString()
       // print("jsonString",dict )
//
       // socketClient.sendJSONForDict(dict: dict, toDestination: "/app/chat")
      //
        socketClient.sendMessage(message: jsonString ?? "", toDestination: "/app/chat", withHeaders: nil, withReceipt: nil)
        
    }
    
    func autoConnect() {
        socketClient.autoDisconnect(time: 3)
        socketClient.reconnect(request: NSURLRequest(url: URL(string: completedWSURL)!), delegate: self, time: 4.0)
    }
    
    // WebSocket delegate methods
    
    func stompClientDidConnect(client: StompClientLib!) {
        
        let userID = UserDefaults.standard.integer(forKey: "id")
        let topic = "/user/" + String(userID) + "/queue/messages"
        print("Socket is Connected : \(topic)")
        socketClient.subscribe(destination: topic)
        connectionLabel = "Socket is connected successfully!"
   //     connectionLabelColor = Color.green
        
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
        connectionLabel = "Socket is disconnected"
     //   connectionLabelColor = Color.purple
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
        print("STRING BODY : \(stringBody ?? "nil")")
//        NotificationCenter.default.post(name: Notification.Name(rawv"NewMessage"), object: destination)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewMessage"), object: self)

        NotificationCenter.default.post(name: NSNotification.Name("NewMessage"), object: jsonBody)

    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error : \(String(describing: message))")
        connectionLabel = "Failed to Connect!"
      //  connectionLabelColor = Color.red
    }
    
    func serverDidSendPing() {
        print("Server Ping")
    }
}
}
//
//  ViewController.swift
//  StompClientLibExample
//
//  Created by Kuray on 8.10.2020.


extension ContentView {
class ViewController1: ObservableObject, StompClientLibDelegate {
    @Published var connectionLabel = ""
//    @Published var connectionLabelColor = Color.primary
    
    var socketClient = StompClientLib()
    let topic = "/user"
    let baseURL = "http://62.171.153.83:8080"
    var wsURL: String {
        String(baseURL.dropFirst(7))
    }
    var completedWSURL: String {
        "ws://\(wsURL)/tappme-api-staging/ws/websocket"
    }
    
    init() {
        registerSocket()
    }
    
    func registerSocket() {
        if let url = URL(string: completedWSURL) {
            socketClient.openSocketWithURLRequest(request: URLRequest(url: url) as NSURLRequest, delegate: self)
            print(" WebSocket URL connected: \(completedWSURL)")

            
        } else {
            print("Invalid WebSocket URL: \(completedWSURL)")
        }
    }
    
    
    func disconnect() {
        socketClient.disconnect()
    }
    
    func sendMessage() {
        //socketClient.sendMessage(message: "StompClientLib Foo", toDestination: "/app/hello", withHeaders: nil, withReceipt: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let currentDateTime = Date()
        let formattedDateTime = dateFormatter.string(from: currentDateTime)

        print(formattedDateTime)
        
        let senderId = UserDefaults.standard.integer(forKey: "id")
        let recipientId = 43 //chatdata.userSummary.userID
        let senderName = UserDefaults.standard.string(forKey: "name") ?? ""
        let recipientName = "Shivangi Bhargava Supervisor"//chatdata.userSummary.name
        let msg = "HHHHHHHHHHHiiiii"
        let timestamp = formattedDateTime

        let messageJSON = JSON([
            "senderId": senderId,
            "recipientId": recipientId,
            "senderName": senderName,
            "recipientName": recipientName,
            "content": msg,
            "timestamp": timestamp
        ])
//            let dict: [String: Any] = [
//                "senderId": UserDefaults.standard.integer(forKey: "id"),
//                "recipientId": chatdata.userSummary.userID,
//                "senderName": UserDefaults.standard.string(forKey: "name") ?? "",
//                "recipientName": chatdata.userSummary.name,
//                "content": msg,
//                "timestamp": formattedDateTime
//            ]
////
        let jsonString = messageJSON.rawString()
       // print("jsonString",dict )
//
       // socketClient.sendJSONForDict(dict: dict, toDestination: "/app/chat")
      //
        socketClient.sendMessage(message: jsonString ?? "", toDestination: "/app/chat", withHeaders: nil, withReceipt: nil)
        
    }
    
    func autoConnect() {
        socketClient.autoDisconnect(time: 3)
        socketClient.reconnect(request: NSURLRequest(url: URL(string: completedWSURL)!), delegate: self, time: 4.0)
    }
    
    // WebSocket delegate methods
    
    func stompClientDidConnect(client: StompClientLib!) {
        let userID = UserDefaults.standard.integer(forKey: "id")
        let topic = "/user/" + String(userID) + "/queue/messages"
        print("Socket is Connected : \(topic)")
        socketClient.subscribe(destination: topic)
        connectionLabel = "Socket is connected successfully!"
   //     connectionLabelColor = Color.green
        
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
        connectionLabel = "Socket is disconnected"
     //   connectionLabelColor = Color.purple
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
        print("STRING BODY : \(stringBody ?? "nil")")
    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error : \(String(describing: message))")
        connectionLabel = "Failed to Connect!"
      //  connectionLabelColor = Color.red
    }
    
    func serverDidSendPing() {
        print("Server Ping")
    }
}
}
