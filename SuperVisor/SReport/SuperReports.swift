//
//  SuperReports.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct SuperReports: View {

    @State private var showtask = false

    @State private var generalreport = false
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
   
    @State var listcompanyname : String? = nil

    @State private var isSubmittedSelected = true
    @State private var WorkerReportdsptn = false
   
    @State private var genraldescriptionsubmit = false
    @State private var genraldescriptiondraft = false
    
    @State var reportid : Int = 0

    @State private var isdraftselected = false
    @State private var searchText = ""
    @State private var mainview = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject var obs = WorkerSubmittedReportVM()
    @StateObject var GNobs = WorkerGeneralReportVM()

    @State private var Reportdescriptionsubmit = false
    @State private var Reportdescriptiondraft = false

    @State private var datestrng = ""

    @State private var WorkerGeneralReport = false
    @State private var WorkkerCheckin = false
    @State var taskIndex = Int()

    
    
    var body: some View {
        
        NavigationView{

        ZStack {
            GeometryReader { geometry in
          

                ScrollView(.vertical , showsIndicators: false){
                    VStack(spacing:20.0){
                        
                        
                        HStack(){
                            
                            Text("Reports")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            Spacer()
                            
                            
                            VStack{
                                ReportlistPickerViewwitpic(value: $CompanyName,
                                                           showCompanyPicker: $showcompanypicker,
                                                           // showassignedtask: $supertasklistvm.showassignedtask,
                                                           //   showantssignedtask: $supertasklistvm.showantssignedtask,
                                                           onChange: {
                                    
                                    
                                    
                                    
                                    if CompanyName == "All" {
                                        
                                        
                                        if showtask {
                                            obs.eTaskReportStatus = ""
                                            obs.workerreportlist = []
                                            obs.GetsuperVisorReportlist()
                                            
                                        }
                                        
                                        
                                        else if generalreport {
                                            GNobs.eTaskReportStatus = ""
                                            GNobs.WorkerGenralModel = []
                                            GNobs.GetsuperVisorgenrallist()
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    else if CompanyName == "After" {
                                        
                                        
                                        if showtask {
                                            obs.eTaskReportStatus = "After"
                                            obs.workerreportlist = []
                                            obs.GetsuperVisorReportlist()
                                            
                                        }
                                        
                                        
                                        else if generalreport {
                                            GNobs.eTaskReportStatus = "After"
                                            GNobs.WorkerGenralModel = []
                                            GNobs.GetsuperVisorgenrallist()
                                            
                                        }
                                        
                                        
                                        
                                    } else if CompanyName == "Before" {
                                        
                                        
                                        if showtask{
                                            
                                            obs.eTaskReportStatus = "Before"
                                            obs.workerreportlist = []
                                            obs.GetsuperVisorReportlist()
                                        }
                                        
                                        
                                        else if generalreport {
                                            GNobs.eTaskReportStatus = "Before"
                                            GNobs.WorkerGenralModel = []
                                            GNobs.GetsuperVisorgenrallist()
                                            
                                        }
                                        
                                    }
                                    
                                    else if CompanyName == "During" {
                                        
                                        if showtask{
                                            
                                            obs.eTaskReportStatus = "During"
                                            obs.workerreportlist = []
                                            obs.GetsuperVisorReportlist()
                                        }
                                        
                                        else if generalreport {
                                            GNobs.eTaskReportStatus = "During"
                                            GNobs.WorkerGenralModel = []
                                            GNobs.GetsuperVisorgenrallist()
                                            
                                        }
                                        
                                    }
                                })
                                
                                .transition(.opacity)
                                .frame(width: Responsiveframes.widthPercentageToDP(10), height: Responsiveframes.heightPercentageToDP(5))
                                
                            }
                            
                            Listview(value: $listcompanyname,
                                                 showCompanyPicker: $showcompanypicker,
                                            
                                                 onChange: {
                                if listcompanyname == "General Report" {
                                    
                                    showtask = false
//                                    GNobs.eTaskReportStatus = ""
//                                    GNobs.WorkerGenralModel = []
                                    GNobs.GetsuperVisorgenrallist()
                                    generalreport = true
                                    
                                } else if listcompanyname == "Task Report" {
                                    showtask = true
                                    generalreport = false

                                }


                            })
                            .transition(.opacity)
                            .frame(width: Responsiveframes.widthPercentageToDP(33), height: Responsiveframes.heightPercentageToDP(5))
                            
                        }
                        
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        
                        VStack{
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                VStack {
                                    if showtask {

                                    if (obs.workerreportlist.count>0){
                           
                                        ForEach(Array(obs.workerreportlist.enumerated()).filter { _, pokemon in
                                            return pokemon.name.contains(obs.filtername) ||
                                            pokemon.name.lowercased().contains(obs.filtername.lowercased()) ||
                                            obs.filtername.isEmpty
                                        }, id: \.element.self) { index, obss in
                                            
                                            VStack(alignment: .leading, spacing: 10 ){
                                                
                                                VStack( alignment: .leading, spacing:10 ){
                                                    HStack{
                                                        
                                                        Text(obss.name)
                                                            .fontWeight(.semibold)
                                                            .lineLimit(1)
                                                            .multilineTextAlignment(.leading)
                                                            .foregroundColor(.black)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                                        
                                                        Spacer()
                                             
                                                        HStack(alignment: .center) {
                                                            let taskid = String(obss.taskID)
                                                            let reportid = String(obss.workerReportResponse.reportID)
                                                            
                                                        Text("#"  + taskid  + "-" + reportid)
                                                       
                                                                .lineLimit(1)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))                         .multilineTextAlignment(.center)
                                                                .foregroundColor(.white)
                                                        }
                                                        .padding(6)
                                                        .background(Color.lightblue)
                                                        
                                                    }
                                                    
                                                    VStack( alignment: .leading){
                                                        
                                                        Text("Submitted: \(obss.workerReportResponse.etaskReportStatus) Work by \(obss.employeeID)")
                                                            .multilineTextAlignment(.leading)
                                                            .foregroundColor(.white)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                                            .frame(width: Responsiveframes.widthPercentageToDP(50), height: Responsiveframes.heightPercentageToDP(4))
                                                            .background(Color.accentColor)
                                                            .cornerRadius(6)
                                                        
                                                    }
                                                    
                                                    VStack( alignment: .leading){
                                                        
                                                        let  data = obss.workerReportResponse.createdAt
                                                        let datestrng = DateConverter.convertDateFormatwithtime(dateString: data)
                                                        
                                                        Text("Time & Date: " + datestrng)
                                                        
                                                            .foregroundColor(.black)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                        HStack {
                                                            Image("Map Point")
                                                                .frame(width: 24, height: 24) // Adjust the size of the image as needed
                                                            
                                                            Text(obs.WorkerReportmodel?.location ?? "")
                                                            
                                                            
                                                                .foregroundColor(.black)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            
                                                            Spacer()
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                                .frame(width: Responsiveframes.widthPercentageToDP(80))
                                                
                                                .onTapGesture {
                                                    
                                                    self.taskIndex = index
                                                    Reportdescriptionsubmit.toggle()
                                                    
                                                }
                                                
                                            }
                                            
                                            .padding()
                                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                                            .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .inset(by: 0.5)
                                                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                            )
                                        }

                                        
                                    }
                                       
                                        else{
                                            
                                            EmptyListView(screenName: "WorkersubmittedReport")
                                            Spacer()
                                        }
                                          
                                    
                                }
                                    
                             
                              else if generalreport {
                                    
                                     
                                  if (GNobs.WorkerGenralModel.count>0){
                              
                                      ScrollView(.vertical, showsIndicators: false) {

                                      
                                      ForEach(Array(GNobs.WorkerGenralModel.enumerated()), id: \.element.self) { index, obss in
                                          
                                          
                                          VStack(alignment: .leading, spacing: 10 ){
                                              
                                              VStack( alignment: .leading, spacing:5 ){
                                                  HStack{
                                                      
                                                      Text(obss.name)
                                                          .fontWeight(.semibold)
                                                          .lineLimit(1)
                                                          .multilineTextAlignment(.leading)
                                                          .foregroundColor(.black)
                                                          .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                                      
                                                      Spacer()
                                                      
                                                      HStack(alignment: .center) {
                                                          Text("#"  + String(obss.reportId ))
                                                              .lineLimit(1)
                                                              .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))                         .multilineTextAlignment(.center)
                                                              .foregroundColor(.white)
                                                      }
                                                      .padding(6)
                                                      .background(Color.lightblue)
                        
                                                  }
                                                  
                                                  HStack{
                                                      
                                                      Text("Submitted: \(obss.etaskReportStatus ?? "") ")
                                                          .multilineTextAlignment(.leading)
                                                          .foregroundColor(.white)
                                                          .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                          .frame(width: Responsiveframes.widthPercentageToDP(40), height: Responsiveframes.heightPercentageToDP(4))
                                                          .background(Color.accentColor)
                                                          .cornerRadius(6)
                                                      
                                                      Spacer()
                                                  }
                                                  
                                                  VStack( alignment: .leading){
                                                      
                                                      // let datestrng = DateConverter.convertDateFormatwithtime(dateString: obs.WorkerReportmodel?.createdAt ?? "")
                                                      
                                                      //   print(datestrng)
                                                      
                                                      
                                                      
                                                      let  data = obss.createdAt
                                                       let datestrng = DateConverter.convertDateFormatwithtime(dateString: data)
                                                      Text("Time & Date: " + datestrng)
                                                      
                                                          .foregroundColor(.black)
                                                          .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                      
                                                      
                                                      HStack {
                                                          Image("Map Point")
                                                          //.resizable()
                                                              .frame(width: 24, height: 24) // Adjust the size of the image as needed
                                                          
                                                          Text(obss.location)
                                                              .foregroundColor(.black)
                                                              .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                          
                                                          Spacer()
                                                      }
                                                      
                                                      //  .padding()
                                                      
                                                  }
                                                  
                                              }
                                              
                                              .frame(width: Responsiveframes.widthPercentageToDP(80))
                                              
                                              
                                              .onTapGesture {
                                                  
                                                  self.reportid = index
                                                  genraldescriptionsubmit.toggle()
                                                  
                                              }
                                              
                                          }
                                   
                                          .onAppear(){
                                              
                                              
                                              datestrng = DateConverter.convertDateFormatwithtime(dateString: obss.createdAt)
                                          }

                                          
                                          
                                          .padding()
                                          .frame(width: Responsiveframes.widthPercentageToDP(90))
                                          .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                          .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                          )
                                          
                                      }
                                  }
                                         
                                     }
                                                
                                         
                                         else{
                                             
                                             EmptyListView(screenName: "WorkersubmittedReport")
                                             Spacer()
                                         }
                                         
                                     }
                                    
                                 }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))

                            }

                    }           
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                    }
                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                    
                    
                    if (obs.workerreportlist.count>0){
                        NavigationLink(destination: SuperReportDetails(reportidmodeldata: obs.workerreportlist[self.taskIndex]), isActive: $Reportdescriptionsubmit) {
                            EmptyView()}
                    }

                    if (GNobs.WorkerGenralModel.count>0){
                        NavigationLink(destination: GeneralReportsupersubmit(reportidmodeldata: GNobs.WorkerGenralModel[self.reportid]), isActive: $genraldescriptionsubmit) {
                            EmptyView()}
                    }
                    
                    
                }
               .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
            }
        }
            
        .onAppear(){
            
            
            if listcompanyname != "Task Report" {
                showtask = false
                GNobs.eTaskReportStatus = ""
                GNobs.WorkerGenralModel = []
                GNobs.GetsuperVisorgenrallist()
                generalreport = true
            
//
            }
//      
            
            if listcompanyname != "General Report" {
                generalreport = false
                CompanyName = "All"
                obs.eTaskReportStatus = ""
                obs.workerreportlist = []
                obs.GetsuperVisorReportlist()
                showtask = true
            }
            

        }
            
            
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
        
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

}

#Preview {
    SuperReports()
}
