
//import SwiftUI
//
//struct CustomChannelList: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    CustomChannelList()
//}

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct CustomChannelList: View {
    //
    @ObservedObject  var ChatchannelVM =  ChannelListVm()

    @State  var customchannellist = false


    @State private var searchText = ""
    @State var reportid : Int = 0

    
    @State  var senderName: String
    @State  var unreadMessageCount: Int
    @State  var recentTime: String
    @State  var recentMessage: String
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {

            ZStack {
                
                GeometryReader { geometry in
                    VStack(spacing:5.0){
                        
                        HStack{
                            
                            Text("Messages")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                               // .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                .padding()
                            Spacer()
                        }
                        
                        
                        VStack{
                            
                            SearchBarView1(searchText: $searchText)
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(10))

                        if ChatchannelVM.Chatchannel.count !=  0  {
                            if  ChatchannelVM.showview{
                                
                                ScrollView(.vertical , showsIndicators: false){
                                    VStack{
                                        // ForEach(Array(ChatchannelVM.Chatchannel.enumerated()), id: \.element) { index, chatname in
                                        
                                        ForEach(Array(ChatchannelVM.Chatchannel.enumerated()).filter { _, obs in
                                            return ( obs.userSummary.name.contains(searchText)) ||   searchText.isEmpty
                                        }, id: \.element) { index, chatname in
                                            
                                            
                                            VStack{
                                                ChatListItem(senderName: chatname.userSummary.name, unreadMessageCount: chatname.messageCount,
                                                             recentTime: chatname.recentMessage?.timestamp ?? "",
                                                             recentMessage: chatname.recentMessage?.content ?? "",
                                                             imageView: chatname.userSummary.imageName)
                                            }
                                            .onTapGesture {
                                                
                                                
                                                
                                                
                                                self.reportid = index
                                                
                                                self.customchannellist.toggle()
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    .fullScreenCover(isPresented: $customchannellist, content: {
                                        ChatVC( chatdata :  ChatchannelVM.Chatchannel[self.reportid] )
                                    })
                                    
                                    
                                }
                            }
                        }
                        else {
                            Spacer()
                            EmptyListView(screenName: "timsheet")
                            Spacer()
                        }
                    }
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry
                   
                }

            }
   
                .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
        .onAppear(){
            
            ChatchannelVM.getchannellist()
            
        }
        .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}




struct ChatListItem: View {
    var senderName: String
    var unreadMessageCount: Int
    var recentTime: String
    var recentMessage: String
    
    var imageView: String

    @State var taskIndex = Int()

    var body: some View {
        VStack{
            HStack{
                HStack{
                    
                    AsyncImage(
                        url: NSURL(string: imageView ?? "")! as URL,
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

 
                    VStack(alignment: .leading){
                        
                        Text(senderName)
                            .font(.headline)
                        
                        Text(recentMessage)
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                    }

                }
                
                Spacer()
                
                VStack{
                    if unreadMessageCount > 0 {
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 20, height: 20)
                            
                            Text("\(unreadMessageCount)")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                    }
                    
                    
                 //   let recenttimechange = formatRecentTime(recentTime: recentTime)

                    let recenttimechange = DateConverter.converrecettime(dateString: recentTime)
                    
                    Text(recenttimechange)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                    
                }
                
            }
            .frame(width: Responsiveframes.widthPercentageToDP(90))
            
        }
                       
        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(7) )
        .padding(8)
        .background(Color.white) // Set background color
        .cornerRadius(10) // Set corner radius
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2) // Add shadow
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Add border
        )
    }
    
}

