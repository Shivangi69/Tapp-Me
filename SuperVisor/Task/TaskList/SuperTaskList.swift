//
//  SuperTaskList.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI
struct SuperTaskList: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showcompanypicker: Bool = false
    @State var createtask: Bool = false
    
    @State var CompanyName: String = ""
    
    
    @State var taskidmain :Int?
    @State var taskdetails: Bool = false

    @StateObject var supertasklistvm = SuperTaskListVM()
    
    @State private var workertaskassign = false
    @State private var issassigned = false

    @State var taskIndex = Int()
    @StateObject var obs = workerassigntaskVM()

    let isaasigned = "NA" // Assuming taskId is of type String, modify if it's of different type
    @State private var scrollViewOffset: CGFloat = 0.0

    
    
    let taskId: Int // Assuming taskId is of type String, modify if it's of different type
     
     init(taskId: Int) {
         self.taskId = taskId
     }
     
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
                            
                            Text("Tasks")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            TypetasklistPickerView2(value: $CompanyName,
                                                    showCompanyPicker: $showcompanypicker,
                                                    showassignedtask: $supertasklistvm.showassignedtask,
                                                    showantssignedtask: $supertasklistvm.showantssignedtask,
                                                    onChange: {
                                                        if CompanyName == "Assigned" {
                                                            // Perform actions when "Assigned" is selected
                                                            supertasklistvm.istaskassigned = true
                                                        supertasklistvm.TaskListdata = []
//                                                                  
                                                            supertasklistvm.iq = 0
                                                                    supertasklistvm.page = 0
                                                            supertasklistvm.Getalltasklist()
                                                            
                                                        } else if CompanyName == "Not assigned" {
                                                            // Perform actions when "Not assigned" is selected
                                                            supertasklistvm.istaskassigned = false
                                                            supertasklistvm.TaskListdata = []
//                                                                 
                                                            supertasklistvm.iq = 0
                                                                   supertasklistvm.page = 0
                                                            supertasklistvm.Getalltasklist()
                                                        }
                                                        // You can add more conditions or actions based on the selected value
                                                    })

                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))

                        
                 if supertasklistvm.TaskListdata.count !=  0  {
                            
                        if supertasklistvm.showassignedtask == true    {
                            ScrollViewReader { scrollViewProxy in
                                ScrollView(.vertical , showsIndicators: false) {
                                    LazyVStack(spacing:10) {
                                        ForEach(Array(supertasklistvm.TaskListdata.enumerated()), id: \.1.taskId) { (index, task) in
                                            VStack{
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 4){
                                                        Text(task.name)
                                                            .fontWeight(.semibold)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.black)
                                                        HStack{
                                                            Text("Assigned to")
                                                                .font(Font.custom("Poppins-Black-ExtraBold", size: Responsiveframes.responsiveFontSize(1.6)))
                                                                .lineLimit(1)
                                                                .foregroundColor(Color.accentColor)
                                                            HStack(alignment: .center) {
                                                                Text("#" + task.employeeId)
                                                                    .foregroundColor(Color.accentColor)
                                                                    .font(Font.custom("Poppins-Black-ExtraBold", size: Responsiveframes.responsiveFontSize(1.6)))
                                                                    .lineLimit(1)
                                                                    .frame(width: Responsiveframes.widthPercentageToDP(20))
                                                                Spacer()
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
                                                                .frame(height: Responsiveframes.heightPercentageToDP(4))
                                                                .overlay(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .stroke(Color.lightblue, lineWidth: 1)
                                                                )
                                                            }
                                                        }
                                                    }
                                                    Spacer()
                                                }
                                                .padding()
                                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                            }
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.gray, lineWidth: 1)
                                            )
                                            
                                            .onAppear(){
                                                print("index",index)
                                                if index == supertasklistvm.TaskListdata.count - 1 {
                                                                        supertasklistvm.loadMoreContent(currentItem: task)
                                                                    }
                                            }
                                        }
//                                            .onAppear {
//                                            // Call loadMoreContent() when the last task appears
//                                            if let lastTask = supertasklistvm.TaskListdata.last {
//                                                supertasklistvm.loadMoreContent(currentItem: lastTask)
//                                            }
//                                        }
                                    }
                                }
                          
                            }

                            Spacer()
                                }
                           //    else if CompanyName == "Not assigned" {
                     else if  supertasklistvm.showantssignedtask == true {
                         
                         ScrollViewReader { scrollViewProxy in
                         ScrollView(.vertical , showsIndicators: false) {
                             LazyVStack(spacing:10) {
                                 //                                            ForEach(supertasklistvm.TaskListdata, id: \.self) { task in
                                 ForEach(Array(supertasklistvm.TaskListdata.enumerated()), id: \.1.taskId) { (index, task) in
                                     VStack{
                                         HStack {
                                             VStack(alignment: .leading, spacing: 4){
                                                 Text(task.name)
                                                     .fontWeight(.semibold)
                                                     .lineLimit(1)
                                                     .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                     .foregroundColor(Color.black)
                                                 
                                                 let startDate = DateConverter.convertDateFormat(dateString: task.startDate)
                                                 Text("Start date: " + startDate)
                                                     .lineLimit(1)
                                                     .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                     .foregroundColor(.gray)
                                                 
                                                 let dueDate = DateConverter.convertDateFormat(dateString: task.dueDate)
                                                 Text("Due Date: " + dueDate)
                                                     .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                     .foregroundColor(.gray)
                                                 
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
                                             Spacer()
                                             Button(action: {
                                                 workertaskassign.toggle()
                                                 
                                                 taskidmain = task.taskId
                                                 // workertaskid = taskid
                                                 
                                                 
                                                 //    print(obs.taskid)
                                                 
                                             }) {
                                                 Text("Assign Task")
                                                     .foregroundColor(.white)
                                                     .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                             }
                                             .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(6))
                                             .background(Color.accentColor)
                                             .cornerRadius(6)
                                             .onTapGesture(){
                                                 workertaskassign.toggle()
                                                 taskidmain = task.taskId
                                                 //  workertaskid = taskid
                                                 
                                             }
                                         }
                                         .padding()
                                         .frame(width: Responsiveframes.widthPercentageToDP(90))
                                         .onTapGesture {
                                             print(index)
                                             self.taskIndex = index
                                             taskdetails.toggle()
                                             
                                         }
                                     }
                                     .background(Color.white)
                                     .cornerRadius(8)
                                     .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                     )
                                     
                                     .onAppear(){
                                         print("index",index)
                                         if index == supertasklistvm.TaskListdata.count - 1 {
                                             supertasklistvm.loadMoreContent(currentItem: task)
                                         }
                                     }
                                 }
//                                 .onAppear {
//                                    // Call loadMoreContent() when the last task appears
//                                    if let lastTask = supertasklistvm.TaskListdata.last {
//                                        supertasklistvm.loadMoreContent(currentItem: lastTask)
//                                    }
//                                }
                                 
                             }
                             
                         }
//                         .onAppear {
//                                        // Call loadMoreContent() when the ScrollView appears
//                             supertasklistvm.Getalltasklist()
//                                    }
                     }
                                  Spacer()
                                }
                                
                                else{
                                    
                                    Spacer()
                                    EmptyListView(screenName: "supertasklist")
                                    Spacer()
                            }
                        }
                        
                        else{
                            
                            Spacer()
                            EmptyListView(screenName: "completedtask")
                            Spacer()
          
                        }
                    }
                .frame(width: geometry.size.width) // Adjusted frame width based on geometry

                    if UIDevice.current.hasNotch {
                        
                        VStack{
                            Button(action: {
                                createtask.toggle()
                            }) {
                                Image("addtask")
                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                
                            }
                            .padding()
                            //                        .onTapGesture {
                            //                            createtask.toggle()
                            //                        }
                        }
                        
                        .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                       .offset(x: Responsiveframes.widthPercentageToDP(80), y: Responsiveframes.heightPercentageToDP(60))
                        
                    }
                    else {
                        VStack{
                        Button(action: {
                            createtask.toggle()
                        }) {
                            Image("addtask")
                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                            
                        }
                        .padding()
                    }
                    
                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                    
                    .offset(x: Responsiveframes.widthPercentageToDP(70), y: Responsiveframes.heightPercentageToDP(50))
                }
                    
                    
                    
                    NavigationLink(destination: SuperCreateNewTask(), isActive: $createtask) {
                        EmptyView()}
                    if (supertasklistvm.TaskListdata.count>0){
                        NavigationLink(destination: SuperTaskDetails(TaskDetaildata: supertasklistvm.TaskListdata[self.taskIndex]), isActive: $taskdetails) {
                            EmptyView()}
                    }
                  
                    NavigationLink(
                        destination: WorkerTaskAssignList(taskidworker: taskidmain ), // Pass task.taskId to destination view
                        isActive: $workertaskassign
                    ) {
                        EmptyView()
                    }
                }
            }
            .onAppear(){
                supertasklistvm.TaskListdata = []
                supertasklistvm.iq = 0
                supertasklistvm.page = 0
                supertasklistvm.Getalltasklist()
             
                
//                if UIDevice.current.hasNotch {
//                                heightplus = 35
//                            } else {
//                                //... don't have to consider notch
//                                heightplus = 20
//                            }
                            
            }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

}





struct TypetasklistPickerView2: View {
    
    @Binding var value: String
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    @Binding var showassignedtask: Bool
    @Binding var showantssignedtask: Bool
    var onChange: (() -> Void)? // Callback function to notify parent
    
    let typetasklist = ["Assigned", "Not assigned"]
    var placeholder = "Not assigned"
    
    var body: some View {
        
        HStack {
            Menu {
                ForEach(typetasklist, id: \.self) { company in
                    Button(action: {
                        self.value1 = company
                        self.value = company
                        self.showCompanyPicker.toggle()
                        onChange?() // Invoke callback
                    }) {
                        Text(company)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .foregroundColor(Color.blue)
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .blue : .blue)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .padding(.leading, 10)
                            .onChange(of: value1) { _ in
                                onChange?() // Invoke callback
                            }
                        Spacer()
                        Image("Alt Arrow Down")
                            .foregroundColor(.blue)
                            .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                            .padding(.trailing, 2)
                    }
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(33), height: Responsiveframes.heightPercentageToDP(5))
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.blue, lineWidth: 1)
        )
    }
}


#Preview {
    SuperTaskList(taskId: 0)
}
