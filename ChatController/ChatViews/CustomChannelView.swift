
import StreamChat
import StreamChatSwiftUI

import SwiftUI


//struct CustomChannelView: View {
//    @State private var messageText = ""
//    @State private var messages: [String] = []
//    
//    var body: some View {
//        VStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(messages, id: \.self) { message in
//                        MessageBubble(message: message, isSender: false)
//                    }
//                }
//            }
//            
//            HStack {
//                TextField("Type a message", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                Button(action: sendMessage) {
//                    Text("Send")
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                .padding(.trailing)
//            }
//            .padding(.horizontal)
//        }
//        .navigationBarTitle("Chat")
//    }
//    
//    func sendMessage() {
//        if !messageText.isEmpty {
//            messages.append(messageText)
//            messageText = ""
//        }
//    }
//}

//struct ChatScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatScreen()
//    }
//}



struct MessageBubble: View {
    var message: String
    var isSender: Bool
    
    var body: some View {
        HStack {
            if isSender {
                Spacer()
            }
            Text(message)
                .padding()
                .foregroundColor(isSender ? .white : .black)
                .background(isSender ? Color.blue : Color.gray)
                .cornerRadius(10)
                .padding(5)
            if !isSender {
                Spacer()
            }
        }
    }
}
