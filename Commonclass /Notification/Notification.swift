

import SwiftUI

struct Notification: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var notificationlist = WorkerSubmittedReportVM()
    @StateObject var Noticount = WorkerSubmittedReportVM()

    
    @State private var selectedNotificationID: String? = nil

    @State var reportid : Int = 0

    var body: some View {
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack(spacing:5.0){

                    HStack(spacing:10){
                        
                        Button(action: {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RemoveNotificationView"), object: self)
                            
                        })
                        {
                            Image("Arrow Left-8")
                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                        }
                        Text("Notifications")
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                        
                        Spacer()
                    }
                    
                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                    
                        if notificationlist.Notificationlist.count !=  0  {
                            
                            ScrollView(.vertical , showsIndicators: false){
                                VStack(spacing:5.0){
                                    
                                    VStack(alignment: .leading) {
                                        
                                        // ForEach(notificationlist.Notificationlist, id: \.self) { index in
                                        ForEach(Array(notificationlist.Notificationlist.enumerated()), id: \.element) { index, index1 in
                                            
                                            VStack(alignment: .leading){
                                                
                                                HStack {
                                                    Image("Ellipse 20")
                                                    
                                                    Text(index1.title)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        .foregroundColor(Color.greenapp)
                                                        .multilineTextAlignment(.leading)
                                                    Spacer()
                                                }
                                                
                                                HStack{
                                                    Text(index1.description)
                                                        .fontWeight(.semibold)
                                                        .lineLimit(5)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        .foregroundColor(Color.gray)
                                                        .multilineTextAlignment(.leading)
                                                    
                                                 //   Spacer()
                                                }
                                                
                                            }
                                            .padding()
                                            
                                        
                                            .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(13))
                                            .background(index1.status == "DELIVERED" ? Color.white : Color.offwhite)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.gray.opacity(0.17), lineWidth: 0.5)
                                            )
                                            .shadow(color: Color.gray.opacity(0.15), radius: 5, x: 0, y: 2)
                                            
                                            .onTapGesture {
                                                
                                                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "callnotify"), object: nil, queue: OperationQueue.main) {_ in
                                                    notificationlist.getallnotification()

                                                    
                                                    
                                                }
                                      
                                                selectedNotificationID = String(index1.id)
                                                notificationlist.notificationid = String(index1.id)
                                                notificationlist.readnotification()
                                                
                                                notificationlist.getallnotification()

                                            }
                                        }
                                    }
                                    
                                
                                    
                                }
                                
                                
                                
                            }
                        }
                        else {
                            Spacer()
                            EmptyListView(screenName: "timsheet")
                            Spacer()
                        }
                    
                }
                    .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                }
            } .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .onAppear(){
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RemoveGpsView"), object: self)

                    notificationlist.getallnotification()
                }
        }
        
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

#Preview {
    Notification()
}
