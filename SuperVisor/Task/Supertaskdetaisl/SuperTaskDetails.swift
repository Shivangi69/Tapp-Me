//
//  SuperTaskDetails.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct SuperTaskDetails: View {
    
    @State private var description: String = ""
    @State private var isTaskCompleted = false
    @State private var mainview = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.presentationMode) var presentationMode1

      var TaskDetaildata: Tasklist
    @State var FromWhere  = String()


   @State  var textStyle = UIFont.TextStyle.body
    @State private var edittask = false
    @State private var workertaskassign = false
    @State  var isdeletetask = false

    @StateObject var obs = supertaskdetailsVM()

    @State var taskidmain :Int?

    var body: some View {
        
        NavigationView{
            
            ZStack {
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false){
                        VStack(alignment: .leading, spacing:40.0){
                            
                            HStack(spacing: 10){
                                Button(action: {
                                    self.presentationMode1.wrappedValue.dismiss()
                                    
                                })
                                {
                                    Image("Arrow Left-8")
                                        .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                }
                                Text(TaskDetaildata.name)
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                
                                Spacer()
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    edittask.toggle()
                                }) {
                                    HStack {
                                        
                                        Image("Image 4") // Set your image name here
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: Responsiveframes.widthPercentageToDP(5), height: Responsiveframes.heightPercentageToDP(5))
                                        // Adjust the size of the image as needed
                                        Text("Edit")
                                            .foregroundColor(.accentColor)
                                            .font(ConstantClass.AppFonts.medium)
                                        //  .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(20), height: Responsiveframes.heightPercentageToDP(6))
                                .cornerRadius(6)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .inset(by: 0.5)
                                        .stroke(Color.accentColor, lineWidth: 1)
                                )
                                // .background(Color.accentColor)
                                
                                
                                .onTapGesture {
                                    edittask.toggle()
                                }
                           
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            
                            HStack(spacing:10){
                                
                                Text("Priority:")
                                    .font(ConstantClass.AppFonts.light)
                                    .foregroundColor(.black)
                                    .padding(.leading, 5.0)
                                
                                HStack(spacing:2){
                                    
                                        if TaskDetaildata.priority == "Medium"{
                                            Image("medium")
                                                .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                            
                                            Text(TaskDetaildata.priority)
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.yellow)
                                                .padding(.leading, 5.0)
                                        } else if TaskDetaildata.priority == "High"{
                                            Image("high")
                                                .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                            
                                            Text(TaskDetaildata.priority)
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.red)
                                                .padding(.leading, 5.0)
                                        } else {
                                            Image("low")
                                                .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                            
                                            Text(TaskDetaildata.priority)
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.lightorange)
                                                .padding(.leading, 5.0)
                                        }
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                
                            }  .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            VStack(alignment: .leading){
                                Text("Description")
                                    .font(ConstantClass.AppFonts.light)
                                    .foregroundColor(.black)
                                    .padding(.leading, 5.0)
                                
                                TextView(text: $description, textStyle: $textStyle)
                                    .padding(.leading, 5.0)
                                    .multilineTextAlignment(.leading)
                                    .font(ConstantClass.AppFonts.light)
                                    .frame(width: ConstantClass.Emptytextfield.textdescriptionwidth, height: ConstantClass.Emptytextfield.textdescriptionheight)
                                    .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                    .overlay(
                                        ConstantClass.Emptytextfield.getOverlay()
                                    )
                                    .disabled(true) // Disable editing

                            }
                            
                            
                            VStack(spacing: 2){
                                HStack{
                                    
                                    let startDate = DateConverter.convertDateFormat(dateString: TaskDetaildata.startDate)
                                    Text("Start Date: " + startDate )
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.black)
                                        .frame(width: Responsiveframes.widthPercentageToDP(50))
                                    Spacer()
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(50))
                                //.cornerRadius(4)
                                
                                HStack{
                                    let dueDate = DateConverter.convertDateFormat(dateString: TaskDetaildata.dueDate)
                                    Text("Due Date: " + dueDate)
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.black)
                                        .frame(width: Responsiveframes.widthPercentageToDP(50))
                                    Spacer()
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(50))
                                //  .cornerRadius(4)
                                
                            }
                            
                            if TaskDetaildata.employeeId != "" {
                                HStack(spacing:5){
                                    
                                    Text("Assigned to:")
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.black)
                                    // .padding(.leading, 5.0)
                                    //     .frame(width: Responsiveframes.widthPercentageToDP(50))
                                    
                                    
                                    HStack(alignment: .center) {
                                        Text( " #" + (String(TaskDetaildata.employeeId ?? "")) + " - " + TaskDetaildata.employeeName)
                                            .lineLimit(1)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))                         .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(40))
                                    .padding(6)
                                    .background(Color.lightblue)
                                    
                                    Spacer()
                                    
                                    //  }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                .cornerRadius(4)
                                
                            }
                            
                            VStack(spacing: 15){
                                
                                if TaskDetaildata.etaskStatus == "Pending" {
                                Button(action: {
                                    obs.taskid =  TaskDetaildata.taskId
                                    obs.workeridstrng = TaskDetaildata.userId
                                    obs.unaasignedtask {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    HStack {
                                        Spacer()
                                        
                                        if TaskDetaildata.employeeId != ""   {
                                            
                                            Text("Unassign Task")
                                                .foregroundColor(.white)
                                                .font(ConstantClass.AppFonts.medium)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)
                                        }
                                        
                                        else{
                                            Text("Assign Task")
                                                .foregroundColor(.white)
                                                .font(ConstantClass.AppFonts.medium)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)
                                                .onTapGesture(){
                                                    workertaskassign.toggle()
                                                    taskidmain = TaskDetaildata.taskId
                                                }
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                                .background(Color.accentColor)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    if TaskDetaildata.employeeId != "" {
                                        obs.taskid =  TaskDetaildata.taskId
                                        obs.workeridstrng = TaskDetaildata.userId
                                        obs.unaasignedtask {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                    
                                    else{
                                        workertaskassign.toggle()
                                        taskidmain = TaskDetaildata.taskId
                                    }
                                }
                                
                            }
                                
                                
                                
                                
                                if TaskDetaildata.employeeId == "" {
                                    
                                    VStack{
                                        Button(action: {
                                            // Add your sign-in action here
                                            isdeletetask = true
                                            
//                                            obs.taskid  = TaskDetaildata.taskId
//
//                                            obs.deletetaskdetails{
//                                                
//                                               self.presentationMode.wrappedValue.dismiss()
//                                            }
                                            
                                      
                                        }) {
                                            HStack {
                                                Spacer()
                                                Text("Delete Task")
                                                    .foregroundColor(.white)
                                                    .font(ConstantClass.AppFonts.medium)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                              
                                                Spacer()
                                            }
                                        }
                                        .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                                        .background(Color.red)
                                        .cornerRadius(10)
                                        .multilineTextAlignment(.center)
                                        .onTapGesture {
                                            
                                            
                                            isdeletetask = true
//                                            obs.taskid  = TaskDetaildata.taskId
//
//                                            obs.deletetaskdetails{
//                                                
//                                               self.presentationMode.wrappedValue.dismiss()
//                                            }
                                        }
                                        
                                    }
                                }
                                
                                
                        Spacer()

                                
                            }
                            
                            
                        }
                        Spacer()
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        
                        NavigationLink(destination: Edittaskdetails(TaskDetaildata: TaskDetaildata), isActive: $edittask) { EmptyView() }
                        NavigationLink(
                            destination: WorkerTaskAssignList(taskidworker: taskidmain ), // Pass task.taskId to destination view
                            isActive: $workertaskassign
                        ) {
                            EmptyView()
                        }

                    }
                    
                    
                    .frame(width: geometry.size.width)  // Adjusted frame width based on geometry
                }
                
                   if isdeletetask == true {
                   
                       StandardPopUp(
                           isShowingPopup: $isdeletetask,
                           title: "Are you sure you want to Delete this task?",
                           yesButtonLabel: "Yes",
                           noButtonLabel: "No",
                           onYesTapped: {
                           
                               withAnimation{
                                
                                   obs.taskid  = TaskDetaildata.taskId

                                   obs.deletetaskdetails{
                                       
                                      self.presentationMode.wrappedValue.dismiss()
                                   }
                                   
                          
                                   
                               }
                           },
                           onNoTapped: {
                               // Custom action for No button
                               withAnimation{
                                   isdeletetask = false
                               }
                               
                               
                           }
                       )
                       
                   }
            }
            
            
            .onAppear(){
                description = TaskDetaildata.description
                      refreshTaskDetailData()
                    
            }
            
            
     
            
//            
//            .navigationBarBackButtonHidden(true)
//            .navigationBarHidden(true)
//         
//            
       
  
            
            
        }    
        
        
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func refreshTaskDetailData() {
        // Here you can put the logic to refresh the data
        // For example, fetch new data from an API or update it based on some condition
        // Assuming you're updating taskDetailData from some source
       // taskDetailData = TaskDetaildata// Update taskDetailData here with the new value
    }
}
//
//#Preview {
//    SuperTaskDetails(TaskDetaildata: Tasklist(ID: 0, taskId: 0, name: "", description: "", startDate: "", dueDate: "", priority: "", etaskStatus: "", employeeId: "", userId: "", employeeName: ""))
//}
