//
//  MyCompletedTask.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 09/04/24.
//

import SwiftUI


struct  MyCompletedTask: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showcompanypicker: Bool = false
    @State var createtask: Bool = false
    
    @State var CompanyName: String = ""
    @State var taskidmain :Int?
    @State var taskdetails: Bool = false
    
    
    @State private var workertaskassign = false
    @State private var issassigned = false
    
    // @State var taskIndex = Int()
    @ObservedObject var  obs = WorkerdashbaordVM()
    
    @State var taskIndex = Int()
    
    let isaasigned = "NA" // Assuming taskId is of type String, modify if it's of different type
    @State private var scrollViewOffset: CGFloat = 0.0
    
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    VStack(spacing:5){
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("Arrow Left-8")
                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                            }
                            
                            Text("My Completed Tasks")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        
                        if (obs.tasklistdata.count > 0){
                        ScrollView(.vertical, showsIndicators: false){
                            
                            LazyVStack(spacing:10) {
                                
                                ForEach(Array(obs.tasklistdata.enumerated()), id: \.1.taskID) { (index, task) in
                                    
                                    VStack(spacing:5){
                                        HStack{
                                            VStack(alignment: .leading, spacing: 4){
                                                Text(task.name)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                
                                                
//                                                Spacer()
                                                
//                                                let  datestrng = DateConverter.convertDateFormatwithtime(dateString: task.taskCompletedTime)
//
//                                                 
//                                                 Text("Time & Date: " + datestrng)
//                                                 
//                                                     .foregroundColor(.black)
//                                                     .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                              
                                                
//
                                                HStack(spacing:2){
                                              
                                                    
                                                    if task.priority == "Medium"{
                                                        Image("medium")
                                                            .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                                        
                                                        Text(task.priority)
                                                            .font(ConstantClass.AppFonts.light)
                                                            .foregroundColor(.yellow)
                                                            .padding(.leading, 5.0)
                                                    } else if task.priority == "High"{
                                                        Image("high")
                                                            .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                                        
                                                        Text(task.priority)
                                                            .font(ConstantClass.AppFonts.light)
                                                            .foregroundColor(.red)
                                                            .padding(.leading, 5.0)
                                                    } else {
                                                        Image("low")
                                                            .frame(width: Responsiveframes.widthPercentageToDP(2), height: Responsiveframes.heightPercentageToDP(2))
                                                        
                                                        Text(task.priority)
                                                            .font(ConstantClass.AppFonts.light)
                                                            .foregroundColor(.lightorange)
                                                            .padding(.leading, 5.0)
                                                    }
                                                    Spacer()
                                            
                                                    
                                                }
                                                
                                             
                                              
                                                
                                            }
                                            
//                                            .padding()
                                            
                                          
                                            
                                            Button(action: {
                                                print(index)
                                                self.taskIndex = index
                                                taskdetails.toggle()
                                            }) {
                                                Text("View Details")
                                                    .lineLimit(1)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.lightblue)
                                                    .background(Color.white)
                                                    .cornerRadius(8)
                                            }
                                            .onTapGesture {
                                                print(index)
                                                self.taskIndex = index
                                                taskdetails.toggle()
                                            }
                                            .padding()
                                            .frame(height: Responsiveframes.heightPercentageToDP(5))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.lightblue, lineWidth: 1)
                                            )
//                                            
                                        }
                                        //.padding()
                                        .padding()
                                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(10))
                                        
                                    }
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    
                                    
                                    
                                    if (obs.tasklistdata.count>0){
                                        NavigationLink(destination: WorkerTaskDetails(TaskDetaildata: obs.tasklistdata[self.taskIndex]), isActive: $taskdetails) {
                                            EmptyView()}
                                    }
                                    
                                }
                            }
                            
                            
                        }
                    }
                        
                        else{
                            
                            Spacer()
                            EmptyListView(screenName: "completedtask")
                            Spacer()
          
                        }
                        
                    }
                    
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry
                    
                }
            }
            .onAppear(){
//                obs.eTaskReportStatus = "Completed"
                obs.getcompletedTask()

            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
}
