import UIKit
import SwiftUI
import SwiftyJSON
import Alamofire
import SSSwiftUILoader



struct ChatVC: View {
    
    @State private var chatText: String = ""
    var chatdata: ChatchennelModel
    @StateObject  var ChatchannelVM =  ChannelListVm()
    
    @State  var showview = false

    @State var cmrstr = String()
    @State var showImagePicker: Bool = false
    
    @State   var dataArr = NSMutableArray()

    @State private var showingActionSheet = false
    @State private var selectedImages: [UIImage] = []
    @StateObject  var Viewcntrl =  ViewController()
    var images = [String]()
    @Environment(\.presentationMode) var presentationMode
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    @State private var scrollProxy: ScrollViewProxy? = nil

    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    VStack{
                        HStack{
                            HStack {
                                Button(action: {
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image("Arrow Left-8")
                                        .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                }
                                
                            }
                            
                            
                                HStack{
                                    
                                    AsyncImage(
                                        url: NSURL(string: chatdata.userSummary.imageName ?? "")! as URL,
                                        placeholder: {
                                            Image("profileimg")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(25)
                                              //  .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        },
                                        image: { Image(uiImage: $0).resizable() }
                                        
                                    )
                                  
                                    .frame(width: 50, height: 50)
                                        .cornerRadius(25)
                                        .aspectRatio(contentMode: .fit)

                                        
                                        Text(chatdata.userSummary.name)
                                            .font(.headline)
                                        
                                      
                                    

                                    Spacer()
                                }
                            
                            Spacer()
                          
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))

                        
                        
                        
                        
                        ScrollView {
                            ScrollViewReader { scrollView in
                                VStack {
                                    ForEach(ChatchannelVM.Chatviewdatamodel, id: \.self) { chat in
                                        ChatBubble(chat: chat)
                                            .id(chat.id)
                                    }
                                }
                                .onChange(of: ChatchannelVM.Chatviewdatamodel) { _ in
                                    if let lastChat = ChatchannelVM.Chatviewdatamodel.last {
                                        withAnimation {
                                            scrollView.scrollTo(lastChat.id, anchor: .bottom)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                            .frame(width: UIScreen.main.bounds.width)
                        }
                        
                        
                        HStack {
                            VStack{
                                Button(action: {
                                    // Trigger the action to open gallery or camera
                                    self.showingActionSheet = true
                                }) {
                                    HStack {
                                        Image("icons8-attachment-50") // Ensure this image is correctly named in your assets
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: ConstantClass.mediumlogosize.logoWidth2, height: ConstantClass.mediumlogosize.logoHeight2)
                                            .multilineTextAlignment(.center)
                                        
                                    }
                                    
                                }
                                .overlay(
                                    Button(action: {
                                        self.showingActionSheet = true
                                    }) {
                                        Image("icon")
                                            .clipShape(Circle())
                                            .background(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: 2)
                                            )
                                    }
                                        .offset(x: offset, y: -offset)
                                )
                                .actionSheet(isPresented: $showingActionSheet) {
                                    ActionSheet(title: Text("Choose"), message: Text(""), buttons: [
                                        .default(Text("Camera")) {
                                            self.showImagePicker.toggle()
                                            cmrstr = "Camera"
                                        },
                                        .default(Text("Gallery")) {
                                            self.showImagePicker.toggle()
                                            cmrstr = "Gallery"
                                        },
                                        .cancel()
                                    ])
                                }
                                .sheet(isPresented: $showImagePicker) {
                                    if cmrstr == "Camera" {
                                        ImagePickerView1(sourceType: .camera) { images in
                                            for image in images {
                                                self.selectedImages.append(image)
                                            }
                                        }
                                    } else if cmrstr == "Gallery" {
                                        ImagePickerView1(sourceType: .photoLibrary) { images in
                                            for image in images {
                                                self.selectedImages.append(image)
                                            }
                                        }
                                    }
                                }
                                
                                
                            }
                            
                            .onChange(of: selectedImages) { _ in
                                if !selectedImages.isEmpty {
                                    //
                                    uploadImagesToAPI()
                                    
                                }
                            }
                            
                            
                            VStack{
                                TextField("Type a message", text: $chatText)
                                //    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .frame(width: ConstantClass.HstackTextFieldSize.wwi,height: ConstantClass.HstackTextFieldSize.hhi)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.black.opacity(0.3), lineWidth: 1))
                            
                            }
                  
                            Button(action: sendMessage) {
                                Text("Send")
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                         .padding(.trailing)
                        }
                       
                   
                       // .padding(.horizontal)
                        
                    
                
                    }   
                    .frame(width: geometry.size.width)
                    
                    
                    
                    // Adjusted frame width based on geometry
                        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NewMessage"))) { notification in
                            if let message = notification.object as? [String:Any] {
                                
                                
                                
                                
                                var imageUrls: [String] = []

                                if let chatImages = message["chatImages"] as? [[String: Any]] {
                                    
                                    // Iterate over the chatImages array and collect URLs
                                    for imageInfo in chatImages {
                                        if let imageUrl = imageInfo["imageUrl"] as? String {
                                            imageUrls.append(imageUrl)
                                        }
                                    }
                                    
                                    // Now you can use imageUrls array here
                                } else {
                                    print("No chat images found.")
                                }
                                
                                let time  = message["timestamp"]
                                
                                let timestamp: TimeInterval = time as! Double / 1000 // Convert milliseconds to seconds

                                // Convert timestamp to Date
                                let date = Date(timeIntervalSince1970: timestamp)

                                // Create date formatter
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

                                // Format date to desired string format
                                let formattedDateString = dateFormatter.string(from: date)

                                
                                
                                
                                let acc = ChatViewdataModel(
                                   
                                    id: message["id"] as! Int,
                                    chatID: "",
                                    senderID: message["senderId"] as! Int,
                                    recipientID:  message["recipientId"] as! Int,
                                    senderName: message["senderName"] as! String,
                                    recipientName: message["recipientName"] as! String,
                                    content: message["content"] as! String,
                                    timestamp:formattedDateString, //message["timestamp"] as! String,
                                    chatImages: [],
                                    status:  message["status"] as! String, chatImagesss: imageUrls,
                                    is_sent_by_me: false
                              

                                )
                                print("jsonString",acc )

                                ChatchannelVM.Chatviewdatamodel.append(acc)
                                
                                    }
                                }
                }
            }
        }
        .onAppear(){
            print(chatdata)
            ChatchannelVM.reciverid = chatdata.userSummary.userID
            ChatchannelVM.senderid = UserDefaults.standard.integer(forKey: "id")
            ChatchannelVM.Getallmessageonview()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
   

    }
    

    
    

    func uploadImage(images: [UIImage]) {
        SSLoader.shared.startloader("Loading...", config: .defaultSettings)
        var Imagesss = [String]()
        var Imagesssname = [String]()

        let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-staging/chat/image/upload")!
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        
        Alamofire.upload(multipartFormData: { (formData) in
            for (index, image) in images.enumerated() {
                guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                    continue
                }
                formData.append(imageData, withName: "files", fileName: "image\(index).jpg", mimeType: "image/jpeg")
            }
        }, to: baseURL, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    SSLoader.shared.stopLoader()
                    Imagesss = []
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any],
                           let dataArray = json["data"] as? [[String: Any]] {
                            
                            Imagesss = dataArray.compactMap { $0["imageUrl"] as? String }
                            Imagesssname = dataArray.compactMap { $0["data"] as? String }

                            // Print or use the image URLs as needed
                            print("Image URLs: \(Imagesss)")
                            
                            
                            
                            let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                                                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                
                                                let currentDateTime = Date()
                                                let formattedDateTime = dateFormatter.string(from: currentDateTime)
                
                                                print(formattedDateTime)
                
                                                let dict: [String: Any] = [
                                                    "senderId": UserDefaults.standard.integer(forKey: "id"),
                                                    "recipientId": chatdata.userSummary.userID,
                                                    "senderName": UserDefaults.standard.string(forKey: "name") ?? "",
                                                    "recipientName": chatdata.userSummary.name,
                                                    "content": "",
                                                    "timestamp": formattedDateTime,
                                                    "chatImages": dataArray,
                                                ]
                                                print("jsonString",dict )
                            
                                                Viewcntrl.socketClient.sendJSONForDict(dict: dict, toDestination: "/app/chat/upload")
                                                var id = Int()
                
                                                if (ChatchannelVM.Chatviewdatamodel.count>0){
                                                    id =  ChatchannelVM.Chatviewdatamodel[ChatchannelVM.Chatviewdatamodel.count-1].id + 1
                
                                                }else{
                                                    id =   1
                
                                                }
                
                
                                                let acc = ChatViewdataModel(
                
                                                    id: id ,
                                                    chatID: "",
                                                    senderID: UserDefaults.standard.integer(forKey: "id"),
                                                    recipientID: chatdata.userSummary.userID,
                                                    senderName: UserDefaults.standard.string(forKey: "name") ?? "",
                                                    recipientName: chatdata.userSummary.name,
                                                    content: "",
                                                    timestamp: formattedDateTime,
                                                    chatImages: [],
                                                    status: "",
                                                    chatImagesss: Imagesss,
                                                    is_sent_by_me: true
                
                
                                                )
                                                print("jsonString",acc )
                
                                                ChatchannelVM.Chatviewdatamodel.append(acc)
                            selectedImages.removeAll()
                            Imagesss.removeAll()
                            
                            
                            
                        } else {
                            print("Failed to parse JSON data")
                        }
                    case .failure(let error):
                        print("Error parsing response: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                SSLoader.shared.stopLoader()
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }

    func uploadImagesToAPI() {
        // Call your API function with the array of selected images
       uploadImage(images: selectedImages)
    }
    
    private func sendMessage() {
        guard !chatText.isEmpty else { return }
        sendMessage(msg: chatText)
    }

    
   func sendMessage(msg: String) {
        if !msg.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {

            print(Viewcntrl.socketClient,"socketClient")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

            let currentDateTime = Date()
            let formattedDateTime = dateFormatter.string(from: currentDateTime)

            print(formattedDateTime)

            let dict: [String: Any] = [
                "senderId": UserDefaults.standard.integer(forKey: "id"),
                "recipientId": chatdata.userSummary.userID,
                "senderName": UserDefaults.standard.string(forKey: "name") ?? "",
                "recipientName": chatdata.userSummary.name,
                "content": msg,
                "timestamp": formattedDateTime
            ]
            print("jsonString",dict )
            Viewcntrl.socketClient.sendJSONForDict(dict: dict, toDestination: "/app/chat")
            var id = Int()
            
            if (ChatchannelVM.Chatviewdatamodel.count>0){
                id =  ChatchannelVM.Chatviewdatamodel[ChatchannelVM.Chatviewdatamodel.count-1].id + 1

            }else{
                id =   1

            }
            
            
            let acc = ChatViewdataModel(
               
                id: id ,
                chatID: "",
                senderID: UserDefaults.standard.integer(forKey: "id"),
                recipientID: chatdata.userSummary.userID,
                senderName: UserDefaults.standard.string(forKey: "name") ?? "",
                recipientName: chatdata.userSummary.name,
                content: msg,
                timestamp: formattedDateTime,
                chatImages: [],
                status: "", chatImagesss: [],
                is_sent_by_me: true
          

            )
            print("jsonString",acc )

            ChatchannelVM.Chatviewdatamodel.append(acc)
            
            chatText = ""
            
            
            
//            let dict1: [String: Any] = [
//                "senderId": UserDefaults.standard.integer(forKey: "id"),
//                "recipientId": chatdata.userSummary.userID,
//                "senderName": UserDefaults.standard.string(forKey: "name") ?? "",
//                "recipientName": chatdata.userSummary.name,
//                "content": msg,
//                "timestamp": formattedDateTime
//            ]
//            print("jsonString",dict )
//            Viewcntrl.socketClient.sendJSONForDict(dict: dict1, toDestination: "/app/chat/upload")
//            
//            let acc1 = ChatViewdataModel(
//               
//                id: id ,
//                chatID: "",
//                senderID: UserDefaults.standard.integer(forKey: "id"),
//                recipientID: chatdata.userSummary.userID,
//                senderName: UserDefaults.standard.string(forKey: "name") ?? "",
//                recipientName: chatdata.userSummary.name,
//                content: msg,
//                timestamp: formattedDateTime,
//              //  chatImages: [ChatchannelVM.dataArr],
//                status: "", chatImagesss: [],
//                is_sent_by_me: true
//          
//
//            )
//            print("jsonString",acc )
//
//            ChatchannelVM.Chatviewdatamodel.append(acc1)
//            
//            
            
        }
    }
    
    
    

}


struct ChatBubble: View {
    let chat: ChatViewdataModel
    @State var imageshow: Bool = false

    var body: some View {
      
    
        HStack {
            if chat.is_sent_by_me {
                Spacer()
                VStack(alignment: .trailing) {
                    if chat.chatImagesss.isEmpty {
                        Text(chat.content)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    } else {
                        imageGrid(for: chat.chatImagesss)
                    }

                    Text(convertDateString(chat.timestamp))
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                .onTapGesture {
                    imageshow.toggle()
                }
                .padding()
               // .background(Color.blue)
                .cornerRadius(8)
            } else {
                VStack(alignment: .leading) {
                    Text(chat.senderName)
                        .font(.caption)
                    if chat.chatImagesss.isEmpty {
                        Text(chat.content)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(8)
                    } else {
                        imageGrid(for: chat.chatImagesss)
                    }
                    
                    
                  //  let recenttimechange = DateConverter.converrecettime(dateString: chat.timestamp)
                    
//                    Text(recenttimechange)
//                        .lineLimit(1)
//                        .multilineTextAlignment(.leading)
//                        .foregroundColor(.gray)
//                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
//                    
                    
                    Text(convertDateString(chat.timestamp))
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                .padding()
                //.background(Color.gray)
                .cornerRadius(8)
                .onTapGesture {
                    imageshow.toggle()
                }
                Spacer()
            }
        }  .fullScreenCover(isPresented:$imageshow, content: {
            ImageViewer( imageUrls : chat.chatImagesss )
        })
    
        .padding(.vertical, 4)
    }
//
//    func convertDateString(_ dateString: String) -> String {
//            let inputFormatter = DateFormatter()
//            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            
//            if let date = inputFormatter.date(from: dateString) {
//                let outputFormatter = DateFormatter()
//                outputFormatter.dateStyle = .medium
//                outputFormatter.timeStyle = .short
//                return outputFormatter.string(from: date)
//                
//            } else {
//                return "Invalid date"
//            }
//        }
    
    func convertDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            
            // Check if the date is today
            if Calendar.current.isDateInToday(date) {
                outputFormatter.dateStyle = .none
                outputFormatter.timeStyle = .short
            } else {
                outputFormatter.dateStyle = .medium
                outputFormatter.timeStyle = .short
            }
            
            return outputFormatter.string(from: date)
            
        } else {
            return "Invalid date"
        }
    }

    
    
    
//     func imageGrid(for images: [String]) -> some View {
//         // Your existing implementation of imageGrid
//         Text("Images go here")
//     }
}
    
    @ViewBuilder
    private func imageGrid(for images: [String]) -> some View {
        let displayImages = Array(images.prefix(4))
        let additionalImagesCount = images.count - 4
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 4) {
            ForEach(displayImages.indices, id: \.self) { index in
                ZStack {
//                    Image(displayImages[index])
                    AsyncImage(
                        url: NSURL(string: displayImages[index] )! as URL,
                        placeholder: {
                            Image("")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(25)
                              //  .resizable()
                                .aspectRatio(contentMode: .fill)
                        },
                        image: { Image(uiImage: $0).resizable() }
                        
                    )
                        
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(8)
                    if index == 3 && additionalImagesCount > 0 {
                        Color.black.opacity(0.5)
                            .cornerRadius(8)
                        Text("+\(additionalImagesCount)")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            }
        }
        .frame(maxWidth: 200) // Adjust to your preferred size
    }






//struct Chat: Identifiable, Codable {
//    var id: UUID
//    var user_name: String
//    var user_image_url: String
//    var is_sent_by_me: Bool
//    var text: String
//}
