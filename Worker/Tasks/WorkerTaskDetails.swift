//
//  WorkerTaskDetails.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 09/01/24.
//


import SwiftUI

struct WorkerTaskDetails: View {
    @State private var description: String = ""
    @State private var isTaskCompleted = false
    @State private var CreateTaskReport = false
    @State private var ismarktaskshowpopup = false
    @State private var isShowingPopupstart = false
    @State private var isShowingPopupclose = false
    @State private var backgroundDisabled = false

    @State  var textStyle = UIFont.TextStyle.body
    var TaskDetaildata: tasklistmodel
    @StateObject var obs = TaskListViewVM()
        
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false){

                    VStack(alignment: .leading,spacing:30){
                     

                        HStack(spacing: 10){
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
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
                        }                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        
                        
                        
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
                        

                        
                        VStack(alignment: .leading, spacing: 2){
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

                        if TaskDetaildata.etaskStatus != "Completed"{
                                  
                            VStack(spacing: 30){
               
                                Button(action: {
                                    // Add your sign-in action here
                                    if TaskDetaildata.etaskStatus == "Working"{
                                        isShowingPopupclose = true
                                    }
                                    else{
                                        
                                        isShowingPopupstart = true

                                    }
                                    

                                    
                                }) {
                                    HStack {
                                        Spacer()
                                        
                                        if TaskDetaildata.etaskStatus == "Working"{
                                            
                                            Text("Close Task")
                                                .foregroundColor(.white)
                                                .font(ConstantClass.AppFonts.medium)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)

                                                .onTapGesture {
                                                    
                                                    isShowingPopupclose = true
                                                  
                                            }
                                        }
                                        
                                        else  {
                                            Text("Start Task")
                                                .foregroundColor(.white)
                                                .font(ConstantClass.AppFonts.medium)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)
                                                .onTapGesture(){
                                                    
                                                    isShowingPopupstart = true
                                                    
                                                }
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                              // .background(Color.accentColor)
                                
                                .background(TaskDetaildata.etaskStatus == "Working" ? Color.red : Color.accentColor)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                
                                .onTapGesture {
                                    
                                    if obs.issuccessfull == true{
                                        isShowingPopupclose = true
                                        
                                    }
                                    else{

                                        isShowingPopupstart = true
                                    }
                                }
                                
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    CreateTaskReport.toggle()
                                    
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Create Task Report")
                                            .foregroundColor(.white)
                                            .font(ConstantClass.AppFonts.medium)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                                .background(Color.accentColor)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    CreateTaskReport.toggle()
                                    
                                }
                                
                            }
                        }
                        
                    }
                        
                     Spacer()
                        
                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                  
                        NavigationLink(destination: Workertaskreport(TaskDetaildata:TaskDetaildata), isActive: $CreateTaskReport) { EmptyView() }
                        
                }
                    .frame(width: geometry.size.width)

                    .disabled(backgroundDisabled)

                    if isShowingPopupstart == true {
                        StandardPopUp(
                            isShowingPopup: $isShowingPopupstart,
                            title: "Are you sure you want to Start the task?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                withAnimation{
                                    
                                    obs.taskid = TaskDetaildata.taskID
//                                    obs.starttask()
                                    
                                    obs.starttask{
                                        self.presentationMode.wrappedValue.dismiss()

                                    }
                                    self.backgroundDisabled = false

                           
                                }
                                
                            },
                            onNoTapped: {
                                // Custom action for No button
                                self.backgroundDisabled = false

                                withAnimation{
                                    isShowingPopupstart = false
                                }
                            }
                        )
                        .onAppear(){
                            self.backgroundDisabled = true
                       }
                    }
                    
                    
           if isShowingPopupclose == true
                    {
                        
                        StandardPopUp(
                            isShowingPopup: $isShowingPopupclose,
                            title: "Are you sure you want to Close the task?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                         
                                withAnimation{                            
                                    self.backgroundDisabled = false
                                    obs.taskid = TaskDetaildata.taskID
                                    obs.Closetask{
                                        self.presentationMode.wrappedValue.dismiss()

                                    }
                                   // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Calldash"), object: self)

                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Calldash"), object: self)

                                }

                            },
                            onNoTapped: {
                                // Custom action for No button
                                self.backgroundDisabled = false

                                withAnimation{
                                    isShowingPopupclose = false
                                }
                                
                            }
                        )
                        .onAppear(){
                            self.backgroundDisabled = true
                       }
                        
                    }
                    

                }
                .onAppear(){
                    description = TaskDetaildata.description
                      
                }
            }
          
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        
        //        .offset(y:Responsiveframes.heightPercentageToDP(5))
        //       .padding(.bottom,30)
    }
}
//
//#Preview {
//    WorkerTaskDetails()
//}
