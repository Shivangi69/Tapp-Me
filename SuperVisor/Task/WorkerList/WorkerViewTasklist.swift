//
//  WorkerViewTasklist.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 23/02/24.
//

import SwiftUI

struct WorkerViewTasklist: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    @State private var searchText = ""
    @StateObject var obs = WorkerListViewTaskVM()

    var reportidmodeldata :  WorkerTaskassignModel
    @State private var taskdetails = false
    @State private var WorkerGeneralReport = false
    @State private var WorkkerCheckin = false

    @State private var selectedIndex: Int? // Using an optional Int to track which status's tasks are shown

   @State private var showTasks = false
    

    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack(spacing:10.0){
                        
                        HStack(){
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            })
                            {
                                Image("Arrow Left-8")
                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                            }
                            
                            Text(reportidmodeldata.name)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            Spacer()
                            
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))

                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack {
                                ForEach(Array(obs.datastatus.enumerated()), id: \.element) { index, datastate in
                                    VStack {
                                        HStack {
                                            Text(datastate.status)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                .padding()

                                            Spacer()

                                            Button(action: {
                                                obs.datastatus[index].isDataVisible.toggle() // Toggle visibility for the current cell
                                            }) {
                                                Text(obs.datastatus[index].isDataVisible ? "Hide" : "View")
                                                    .foregroundColor(.blue)
                                                    .padding(.horizontal)
                                            }
                                        }

                                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(9))
                                        .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )

                                        if datastate.isDataVisible {
                                      
                                            ForEach(datastate.data, id: \.self) { task in
                                                
                                                VStack {
                                                    HStack{
                                                        VStack(alignment: .leading) {
                                                            Text(task.name)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            Spacer()
                                                            
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
                                                        
                                                        
                                                        .padding()
                                                        
                                                        Spacer()
                                                        
                                                        Button(action: {
                                                            
                                                            //    taskdetails.toggle()
                                                            
                                                        }) {
                                                            Text(task.etaskStatus)
                                                                .foregroundColor(.white)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        }
                                                        .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(5))
                                                        
                                                        
                                                        .background(Color.gray)
                                                        
                                                        .cornerRadius(6)
                                                        .padding()
                                                        
                                                        .onTapGesture {
                                                            
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                    .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(7))
                                                    
                                                    Divider()
                                                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(1))
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                        }

                        

                    }
                    
                    .frame(width: geometry.size.width)
                    .onAppear(){
                        obs.usertaskid = String(reportidmodeldata.id)
                        obs.GetWorkerListView()
                        
                    }
                }
           
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}


struct TaskListView: View {


    var tasks = [ViewdataModel]()


    var body: some View {

            

            ForEach(tasks, id: \.self) { task in
                   
                }
            
        }
    }
