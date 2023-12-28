//
//  ChannelListVm.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/05/24.
//

import Foundation
import Alamofire
import SSSwiftUILoader

class ChannelListVm: ObservableObject {
    
    @Published   var showview = false
    @Published   var Chatchannel: [ChatchennelModel] = []
    
    @Published   var Chatviewdatamodel: [ChatViewdataModel] = []
    @Published   var ChatImage: [ChatImagemodel] = []

    @Published   var userSummaryModel : UserSummary?
    @Published   var recentMessageModel : RecentMessage?
    @Published   var reciverid = Int()
    @Published   var senderid  = Int()

    @Published var errorState = NSDictionary()
    @Published  var showError = false
    @Published   var dataArr = NSMutableArray()
    
    func getchannellist()  {
        
       let companyid = String(UserDefaults.standard.integer(forKey: "usercompanyid"))
        let str = "chat/company/" + companyid + "/users-with-messages"
  
        AccountAPI.getsigninw(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    print("Josn",json)
                    
                    let events = json["data"]
                    
                    self.Chatchannel = []

                        for j in events {
                            
                            let usersummary = j.1["userSummary"]
                            
                            let recentmessage = j.1["recentMessage"]
                            
                            self.userSummaryModel = UserSummary(
                            
                            userID: usersummary["userId"].intValue,
                            email: usersummary["email"].stringValue,
                            name: usersummary["name"].stringValue,
                            imageName: usersummary["imageName"].stringValue

                        )
                        
                        print("print" , self.userSummaryModel)

                            
                            self.recentMessageModel = RecentMessage(
                                
                                id: recentmessage["id"].intValue,
                                chatID: recentmessage["chatID"].stringValue,
                                senderID: recentmessage["senderId"].intValue,
                                recipientID: recentmessage["recipientId"].intValue,
                                senderName: recentmessage["senderName"].stringValue,
                                recipientName: recentmessage["recipientName"].stringValue,
                                content: recentmessage["content"].stringValue,
                                timestamp: recentmessage["timestamp"].stringValue,
                                status: recentmessage["status"].stringValue
                            )
                            
                            print("print" , self.recentMessageModel)
                            
                            let acc = ChatchennelModel(
                                
                                userSummary: self.userSummaryModel ?? UserSummary(userID: 0, email: "", name: "", imageName: ""),
                                messageCount: j.1["messageCount"].intValue,
                                recentMessage: self.recentMessageModel ?? RecentMessage(id: 0, chatID: "", senderID: 0, recipientID: 0, senderName: "", recipientName: "", content: "", timestamp: "", status: "")
                            )
                            self.Chatchannel.append(acc)
                            
                        }
                       
                  //  if (self.Chatchannel.count>0)  {
                        self.showview = true
                  //  }
                  
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    
    
    func Getallmessageonview()  {
        
        var images = [String]()

        let sendidstrng = String(senderid)
        let receiveridstrg = String(reciverid)

        
        let str = "messages/" + sendidstrng + "/" + receiveridstrg
  
        
        
  //  http://62.171.153.83:8080/tappme-api-development/messages/12/57

        AccountAPI.getsignin(servciename: str, nil){ res in
            switch res {
            case .success:
                
                if let json = res.value{
                    self.ChatImage.removeAll()
                    images = []

                    print("Josn",json)
                    
                    let events = json["data"]
  
                    
                 self.Chatviewdatamodel = []

                        for j in events {
                            self.ChatImage.removeAll()
                            images = []

                            let Chatimages = j.1["chatImages"]

                            
                            for i in Chatimages {
                                
                                let acc1 = ChatImagemodel(
                                    chatID: i.1["chatId"].intValue,
                                    imageURL: i.1["imageUrl"].stringValue
                                )
                                
                                images.append(i.1["imageUrl"].stringValue)
                                
                                self.ChatImage.append(acc1)
                                 
                            }
                            var is_sent_by_me = false
                            if (String(j.1["senderId"].intValue) == UserDefaults.standard.string(forKey: "id") ?? ""){
                                is_sent_by_me = true
                            }else{
                                is_sent_by_me = false
                            }
                            let acc = ChatViewdataModel(
                               
                                id: j.1["id"].intValue,
                                chatID: j.1["chatID"].stringValue,
                                senderID: j.1["senderId"].intValue,
                                recipientID: j.1["recipientId"].intValue,
                                senderName: j.1["senderName"].stringValue,
                                recipientName: j.1["recipientName"].stringValue,
                                content: j.1["content"].stringValue,
                                timestamp: j.1["timestamp"].stringValue,
                                chatImages: self.ChatImage,         
                                status: j.1["status"].stringValue, chatImagesss: images,
                                is_sent_by_me: is_sent_by_me
                          
                            )
                            self.Chatviewdatamodel.append(acc)
                        }
                       print(self.Chatviewdatamodel)
                    self.showview = true
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    
}
