//
//  ContainerGroup.swift
//
//  Created by codia-figma
//

import SwiftUI

struct ContainerGroup: View {
    @State public var containerGroup1Path: String = "notify"
    
    @State public var textPpText: String = UserDefaults.standard.string(forKey: "employeeId") ?? ""
        
    @State public var skills: String = UserDefaults.standard.string(forKey: "skills") ?? ""

    @State public var combinedSkillsEmp: String = ""

    @StateObject var notificationlist = WorkerSubmittedReportVM()

    @StateObject var Profileimageupload = TaskListViewVM()
    @ObservedObject var statuscheck = CompanylistbyemailVMgoogle()

    init() {
        // Initialize combinedSkillsEmp after the object has been fully initialized
        combinedSkillsEmp = "\(textPpText) - \(skills)"
    }
    
    
    
    var dynamicHeight: CGFloat {
           if workercheckin {
               return Responsiveframes.heightPercentageToDP(CGFloat(28))
           } else {
               return Responsiveframes.heightPercentageToDP(CGFloat(22))
           }
       }
    
    @State public var textHeyPeterParkerText = UserDefaults.standard.string(forKey: "name") ?? ""
    @State private var notificationshow = false
    @State private var Profileshow = false

  //  @State public var imageRectangle2Path = UserDefaults.standard.string(forKey: "imageurlw")

//    var imageRectangle2Path = String()

    @StateObject var profilemodel = ProfileVM()

    @State private var workercheckin = false

    @State private var height = 15
    @State private var workerheight1 = 15

    @State private var spacerheight:Int = 5
    @StateObject var WorkerCheckin = WorkerCheckinVM()

    @State private var ProfileShow = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            BottomRoundedRectangle(cornerRadius: 40)
                      .fill(Color(red: 0.12, green: 0.45, blue: 1.00, opacity: 1.00))
                      .frame(width: UIScreen.main.bounds.width)
                      .edgesIgnoringSafeArea(.bottom)

//            BottomRoundedRectangle(cornerRadius: 40)
//                      .fill(Color(red: 0.12, green: 0.45, blue: 1.00, opacity: 1.00))
//                      .frame(width: UIScreen.main.bounds.width) // Adjust height as needed
//                      .padding()
            
            VStack(spacing:0){
                
                Spacer()
                    .frame(height: Responsiveframes.heightPercentageToDP(CGFloat(spacerheight)))
                HStack{
                    if(Profileshow == true){
                        
                        HStack{
                            Button(action: {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                            }) {
                                AsyncImage(
                                    url: NSURL(string: UserDefaults.standard.string(forKey: "imageurlw") ?? "")! as URL,
                                    placeholder: {
                                        Image("profileimg")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: ConstantClass.bigimagesize.notifyw, height: ConstantClass.bigimagesize.notifyH, alignment: .topLeading)
                                        
                                    },
                                    image: { Image(uiImage: $0).resizable() }
                                )
                                .frame(width: ConstantClass.bigimagesize.notifyw, height: ConstantClass.bigimagesize.notifyH, alignment: .topLeading)
                                .cornerRadius(10)
                                
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                )
                                
                                .onTapGesture {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                                }
                                
                            }
                            
                            .onTapGesture {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                            }
                        }
                        
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                        }
                        .padding()
                        
                    }else{
                        HStack{
                            Button(action: {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                            }) {
                                AsyncImage(
                                    url: NSURL(string: UserDefaults.standard.string(forKey: "imageurlw") ?? "")! as URL,
                                    placeholder: {
                                        Image("profileimg")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: ConstantClass.bigimagesize.notifyw, height: ConstantClass.bigimagesize.notifyH, alignment: .topLeading)
                                        
                                    },
                                    image: { Image(uiImage: $0).resizable() }
                                )
                                .frame(width: ConstantClass.bigimagesize.notifyw, height: ConstantClass.bigimagesize.notifyH, alignment: .topLeading)
                                .cornerRadius(10)
                                
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                )
                                
                                .onTapGesture {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                                }
                                
                            }
                            
                            .onTapGesture {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                            }
                        }
                        
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetProfileView"), object: self)
                        }
                        .padding()
                    }
                    
                    
                    
                 
                        VStack(alignment: .leading){
                            HStack{
                                VStack(alignment: .leading){
                                    
                                    Text(textHeyPeterParkerText)
                                        .foregroundColor(Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00))
                                        .font(ConstantClass.AppFonts.medium)
                                        .lineLimit(1)
                                    //  .frame(alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    ContainerFrame(textPpText: "\(textPpText) - \(skills)")
                                    
                                    
                                    
                                }
                                Spacer()
                                
                            }
                            .padding(.top,10)
                            .frame(width: (Responsiveframes.widthPercentageToDP(50)))
                            
                            if (UserDefaults.standard.bool(forKey: "Checkedin") == true) && (UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR") &&  UserDefaults.standard.integer(forKey: "workforceId") != 0{
                                
                                SiteRoleChangeframe()
                            }
                            Spacer()
                            
                            
                        }
                    
              Spacer()
                    VStack {
                             Button(action: {
                                 print("Button tapped!")
          
                                 
                            //     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "callnotify"), object: self)
                                 
                                 
                                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetNotificationView"), object: self)
                             }) {
                                 ZStack {
                                     Image(containerGroup1Path)
                                         .resizable()
                                        .aspectRatio(contentMode: .fit)
                                         .frame(width: ConstantClass.bigimagesize.notifywidth, height: ConstantClass.bigimagesize.notifyHeight, alignment: .topLeading)
                                         .cornerRadius(10)
                                
                                     Text(String(notificationlist.noticount))
                                             .foregroundColor(.white)
                                             .font(.system(size: 12))
                                             .padding(4)
                                             .background(Color.red)
                                             .clipShape(Circle())
                                             .offset(x: 10, y: -10) // Adjust position as needed
                                     
                                                   }
                             }
                             .padding()
                             .background(Color.white) // Set background color of the button
                             
                             .onTapGesture {

//                                 notificationlist.getallnotification()
                                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetNotificationView"), object: self)
                             }
                    }
//                    .padding()
                         .background(Color.white)
                         .cornerRadius(10)
                    Spacer()
                         
                }
                
              // Spacer()

                .frame(width: UIScreen.main.bounds.width-0)
                
                
                
                
                if workercheckin == true{
                    HStack{
                        Button(action: {
                       //     self.presentationMode.wrappedValue.dismiss()
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CALLAPI"), object: self)

                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RemoveGpsView"), object: self)
                            
                        })
                        {
                            Image("Arrow Left")
                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                            
                            
                        }
                        Spacer()
                        Text("GPS Attendance")
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            .foregroundColor(.white)
                        
                       Spacer()
                        
                        
                    }
                 //   .cornerRadius(15)
                    .frame(width: UIScreen.main.bounds.width-20  )
                   // .cornerRadius(15)
                   // Spacer()
                }
                
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 0, height: calculateHeight())
     //   .disabled(WorkerCheckin.siteidarray.count == 0)
         
        
        .onAppear(){
            
         //   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "callnotify"), object: self)

            notificationlist.getallnotification()
            
            if UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR" {
                height = 17
            } else {
                height = 15
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Showworkercheckin"), object: nil, queue: OperationQueue.main) {_ in
                workercheckin = true
//                height = 22
                if UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR" {
                    height = 25
                } else {
                    height = 17
                }
                spacerheight = 5
               
                print(height)
            }
            
            
            if (UserDefaults.standard.string(forKey: "MainRole") == "WORKER")  {
                
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Showworkercheckin"), object: nil, queue: OperationQueue.main) {_ in
                    workercheckin = true
    //                height = 22
                    if UserDefaults.standard.string(forKey: "MainRole") == "WORKER" {
                        height = 23
                    } else {
                        height = 17
                    }
                    spacerheight = 5
                   
                    print(height)
                }
                 
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "NotificationCountUpdated"), object: nil, queue: nil) { _ in
                notificationlist.getallnotification()
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetNotificationView"), object: self)
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "setprofileupdated"), object: nil, queue: nil) { _ in
                
                
                Profileshow.toggle()
                
               // self.imageRectangle2Path = UserDefaults.standard.string(forKey: "imageurlw") ?? ""
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RemoveGpsView"), object: nil, queue: OperationQueue.main) {_ in
                workercheckin = false
                if UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR" {
                    height = 17
                } else {
                    height = 15
                }
                spacerheight = 5
                
                print(height)

            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "calldashboard"), object: nil, queue: OperationQueue.main) {_ in
                workercheckin = false
               // height = 22
                
                
                if UserDefaults.standard.string(forKey: "MainRole") == "SUPERVISOR" {
                    height = 17
                } else {
                    height = 15
                }
               spacerheight = 5
                }
            
     textPpText = profilemodel.UserProfilemodel?.employeeID ?? ""
   
     skills = profilemodel.UserProfilemodel?.skills ?? ""
            
            statuscheck.GetallStatus()
            profilemodel.profilefetch()

        print(height)
            
        }
        
    }
  
    
 func updateNotificationCount() {
        // Update UI with new notification count
        // For example, if notificationlist is an ObservableObject, you can update its property holding the count
        notificationlist.getallnotification()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetNotificationView"), object: self)
    }
    
    func calculateHeight() -> CGFloat {
        return Responsiveframes.heightPercentageToDP(CGFloat(height))

    }

    
}

struct ContainerGroup_Previews: PreviewProvider {
    static var previews: some View {
        ContainerGroup()
    }
}




struct BottomRoundedRectangle: Shape {
    var cornerRadius: CGFloat = 40

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Top left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))

        // Bottom right corner with corner radius
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)

        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))

        // Bottom left corner with corner radius
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)

        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}
