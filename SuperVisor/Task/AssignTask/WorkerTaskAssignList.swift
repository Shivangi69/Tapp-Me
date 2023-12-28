//
//  WorkerTaskAssignList.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct WorkerTaskAssignList: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    @State private var searchText = ""
    @State  var taskidworker : Int?
    
    @State  var workername = ""
    @State  var workerid = ""
    @State private var selectedIndex: Int? = nil
    
    @State private var shivangiText = "shivangi"
     @State private var isPopupVisible = false
     @State private var newText = ""
    @State private var showUndoButton = true // State variable to control the visibility of the Undo button

    
    @StateObject var obs = workerassigntaskVM()
    
    @State private var isShowingPopupassign = false
    
    @State private var backgroundDisabled = false
    
    @State  var showTasks = false
    
    var body: some View {
        NavigationView{
            
            ZStack {
                GeometryReader { geometry in
                    VStack(spacing:5){
                        
                        HStack(spacing:10){
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            })
                            {
                                Image("Arrow Left-8")
                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                
                            }
                            
                            Text("Assign task to")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            //                            WorkPicker1(value: $CompanyName, showCompanyPicker: $showcompanypicker)
                            //                               // .animation(.linear)
                            //                                .transition(.opacity)
                            //                                .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(5))
                            //
                        }
                        
                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.widthPercentageToDP(6))
                        
                        VStack{
                            SearchBarView1(searchText: $obs.filtername)
                        }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(Array(obs.workerTaskassignModel.enumerated()).filter { _, taskassign in
                                    return taskassign.employeeId.lowercased().contains(obs.filtername) ||
                                        taskassign.name.lowercased().contains(obs.filtername.lowercased()) ||
                                        obs.filtername.isEmpty
                                }, id: \.element) { index, taskassign in
                                    
                                    VStack{
                                        
                                        
                                  
                                            if taskassign.asiignd == true {
                                                
                                                HStack {
                                                    VStack(alignment: .leading ,spacing : 5) {
                                                        Text(taskassign.name)
                                                            .fontWeight(.semibold)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.black)
                                                        
                                                        Text("#" + taskassign.employeeId + " - " + taskassign.skills)
                                                            .fontWeight(.semibold)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                            .foregroundColor(Color.black)
                                                    }
                                                    Spacer()
                                                    Button(action: {
                                                        withAnimation {
                                                            isShowingPopupassign = true
                                                            obs.taskid = taskidworker!
                                                            obs.workerid = taskassign.id
                                                            workername = taskassign.name
                                                            workerid = taskassign.employeeId
                                                            obs.taskassigned = "true"
                                                            obs.Assignedvalue = false
                                                            obs.AssignedIndex = index
                                                            
                                                        }
                                                    }) {
                                                        Text("Assign")
                                                            .foregroundColor(.white)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    }
                                                    .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(8))
                                                    .background(Color.accentColor)
                                                    .cornerRadius(6)
                                                    
                                                }
                                                .padding()
                                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(10))
                                                .background(Color.white)
                                                .cornerRadius(8)
                                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.gray, lineWidth: 1)
                                                )
                                                
                                                
                                                
                                                
                                            }
                                            
                                        
                                          
                                        
                                        else  {
                                            
                                            //                                            HStack {
                                            //                                                Text("Task Assigned to " + taskassign.name)
                                            //                                                    .foregroundColor(.black)
                                            //                                                //  .padding()
                                            //                                                Spacer()
                                            //
                                            //                                                Button(action: {
                                            //                                                    // Add your undo logic here
                                            //                                                    // For example, you can reset the text value
                                            //                                                    withAnimation {
                                            //                                                        obs.taskid = taskidworker!
                                            //                                                        obs.workerid = taskassign.id
                                            //                                                        workername = taskassign.name
                                            //                                                        workerid = taskassign.employeeId
                                            //                                                        obs.taskassigned = "false"
                                            //                                                        obs.Assignedvalue = true
                                            //                                                        obs.AssignedIndex = index
                                            //                                                        obs.assigntasktoworker()
                                            //                                                    }
                                            //                                                }) {
                                            //                                                    Text("Undo")
                                            //                                                        .foregroundColor(.blue)
                                            //                                                        .underline()
                                            //                                                        .padding()
                                            //                                                }
                                            //
                                            //                                            }
                                            //                                            .padding()
                                            //                                            .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(8))
                                            //                                            .background(Color.lightgreen)
                                            //                                            .cornerRadius(8)
                                            //
                                            VStack{
                                            if showUndoButton {
                                                
                                                HStack {
                                                    Text("Task Assigned to " + taskassign.name)
                                                        .foregroundColor(.black)
                                                    Spacer()
                                                    
                                                    
                                                    Button(action: {
                                                        // Add your undo logic here
                                                        // For example, you can reset the text value
                                                        withAnimation {
                                                            obs.taskid = taskidworker!
                                                            obs.workerid = taskassign.id
                                                            workername = taskassign.name
                                                            workerid = taskassign.employeeId
                                                            obs.taskassigned = "false"
                                                            obs.Assignedvalue = true
                                                            obs.AssignedIndex = index
                                                            obs.assigntasktoworker()
                                                        }
                                                        // Set a timer to hide the Undo button after 5 seconds
                                                        
                                                    }) {
                                                        Text("Undo")
                                                            .foregroundColor(.blue)
                                                            .underline()
                                                            .padding()
                                                    }
                                                }
                                                .padding()
                                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(8))
                                                .background(Color.lightgreen)
                                                .cornerRadius(8)
                                                
                                            }
                                            
                                        }
                                            .onAppear() {
                                                
                                                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                                                    withAnimation {
                                                        showUndoButton = false // Hide the Undo button after 5 seconds
                                                    }
                                                }
                                            }

                                          
                                            
                                        }
                                        
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                    .disabled(backgroundDisabled)
                    
                    .frame(width: geometry.size.width)
                    
                    if isShowingPopupassign {
                        StandardPopUp(
                            isShowingPopup: $isShowingPopupassign,
                            title: "Are you sure, you want to assign task to " +  workername + " ( #" +  workerid + " ) ?",
                            yesButtonLabel: "Yes",
                            noButtonLabel: "No",
                            onYesTapped: {
                                self.showTasks = true
                                self.isShowingPopupassign = false
                                self.backgroundDisabled = false
                                obs.assigntasktoworker()
                                
                            },
                            onNoTapped: {
                            //    self.showTasks = true

                                self.isShowingPopupassign = false
                                self.backgroundDisabled = false
                            }
                            
                        )
                        .onAppear(){
                            self.backgroundDisabled = true
                        }
                    }
                    
                }
            }
            
            // .edgesIgnoringSafeArea(.all)
            // Disable user interaction on the background view
            
            
            .onAppear(){
                obs.Getworkerlist()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

#Preview {
    WorkerTaskAssignList()
}
