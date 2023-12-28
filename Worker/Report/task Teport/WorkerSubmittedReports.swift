//
//  WorkerSubmittedReports.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 09/01/24.
//

import SwiftUI

struct WorkerSubmittedReports: View {
    
     @State var showcompanypicker: Bool = false
     @State var CompanyName : String? = nil
    
     @State private var isSubmittedSelected = true
     @State private var WorkerReportdsptn = false
    
     @State private var isdraftselected = false
     @State private var searchText = ""
     @State private var mainview = false
     @Environment(\.presentationMode) var presentationMode
     @StateObject var obs = WorkerSubmittedReportVM()
    @StateObject var GNobs = WorkerGeneralReportVM()

     @State private var Reportdescriptionsubmit = false
     @State private var Reportdescriptiondraft = false

    @State private var genraldescriptionsubmit = false
    @State private var genraldescriptiondraft = false
    
     @State private var datestrng = ""

     @State private var WorkerGeneralReport = false
     @State private var WorkkerCheckin = false
    
    @State var taskIndex : Int = 0
    @State var reportid : Int = 0


    @State private var showtask = false

    @State private var generalreport = false

//    @ObservedObject var WorkerSubmittedReportVM =
    var body: some View {
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack{
                        VStack(spacing:5.0){
                            
                            // HeaderView()
                            
                            HStack(){
                                
                                Text("Reports")
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                
                                Spacer()
                                

                                Listview(value: $CompanyName,
                                                     showCompanyPicker: $showcompanypicker,
                                                    
                                                     onChange: {
                                    if CompanyName == "General Report" {
                                        showtask = false
                                        generalreport = true
                                       GNobs.Getallgeneralreport()

                                    } else if CompanyName == "Task Report" {
                                        showtask = true
                                        generalreport = false

                                    }

                                })
                                .transition(.opacity)
                                .frame(width: Responsiveframes.widthPercentageToDP(33), height: Responsiveframes.heightPercentageToDP(5))
                                
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            Divider()
                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(1))
                            
                            HStack(spacing: 10){
                                
                                Button(action: {
                         
                                    if showtask {
                                        self.taskIndex = 0
                                           isSubmittedSelected = true
                                           isdraftselected = false
                                            obs.isDraft = false
                                            obs.workerreportlist = []
                                            obs.Getalltaskreport()
                                        
                                    }
                                    else if generalreport{
                                        self.taskIndex = 0
                                        isSubmittedSelected = true
                                        isdraftselected = false
                                        GNobs.isDraft = false
                                        GNobs.WorkerGenralModel = []
                                        GNobs.Getallgeneralreport()
                                        
                                    }
                                    
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Submitted")
                                            .foregroundColor(isSubmittedSelected ? .white : .gray)
                                            .font(ConstantClass.AppFonts.medium)
                                        //    .multilineTextAlignment(.center)
                                        //   .background(isSubmittedSelected ? Color.blue : Color.white)
                                        
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                }
                                .onTapGesture {
                                    
                                          if showtask {
                                              self.taskIndex = 0
                                              isdraftselected = false

                                                 isSubmittedSelected = true
                                                  obs.isDraft = false
                                                  obs.workerreportlist = []
                                                  obs.Getalltaskreport()
                                              
                                          }
                                          else if generalreport{
                                              self.taskIndex = 0
                                              isdraftselected = false

                                              isSubmittedSelected = true
                                              GNobs.isDraft = false
                                              GNobs.WorkerGenralModel = []
                                              GNobs.Getallgeneralreport()
                                              
                                          }
                                }
                                
                                .frame(width: Responsiveframes.widthPercentageToDP(80)/2,height: Responsiveframes.heightPercentageToDP(6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(isSubmittedSelected ? Color.blue : Color.gray, lineWidth: 0.5)
                                )
                                .background(isSubmittedSelected ? Color.blue : Color.white)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                
                                
                                Button(action: {
                                    // Add your sign-in action here
                                 //   WorkerReportDraftDescription.toggle()
                                    
                                    
                                    if showtask {
                                        
                                        self.taskIndex = 0
                                        isSubmittedSelected = false
                                        isdraftselected = true
                                        obs.isDraft = true
                                        
                                        obs.workerreportlist = []
                                        obs.Getalltaskreport()
                                        
                                    }
                                    else if generalreport{
                                        self.taskIndex = 0
                                        isSubmittedSelected = false
                                        isdraftselected = true
                                        GNobs.isDraft = true
                                        
                                        GNobs.WorkerGenralModel = []
                                        GNobs.Getallgeneralreport()
                                        
                                        
                                    }
                                    
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Draft")
                                            .foregroundColor(isdraftselected ? .white : .gray)
                                            .font(ConstantClass.AppFonts.medium)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                         
                                    }
                                }
                                .onTapGesture {
                          
                                    if showtask {
                                        
                                        
                                        isSubmittedSelected = false
                                        isdraftselected = true
                                        obs.isDraft = true
                                        
                                        obs.workerreportlist = []
                                        obs.Getalltaskreport()
                                        
                                    }
                                    else if generalreport{
                                        
                                        isSubmittedSelected = false
                                        isdraftselected = true
                                        GNobs.isDraft = true
                                        
                                        GNobs.WorkerGenralModel = []
                                        GNobs.Getallgeneralreport()
                                        
                                        
                                    }
                                }
                                .frame(width: (Responsiveframes.widthPercentageToDP(80))/2,height: Responsiveframes.heightPercentageToDP(6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(isdraftselected ? Color.blue : Color.gray, lineWidth: 0.5)
                                )
                                .background(isdraftselected ? Color.blue : Color.white)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                
                            }
                            .padding()
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            Divider()
                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(1))
                            
                            HStack{
                                
                                VStack{
                                    
                                    SearchBarView(searchText: $obs.filtername)
                                    
                                }
                               // .frame(width: Responsiveframes.widthPercentageToDP(75))
                                .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(10))

                                
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
                                                obs.Getalltaskreport()
                                                
                                            }
                                            
                                            
                                            else if generalreport {
                                            GNobs.eTaskReportStatus = ""
                                                GNobs.WorkerGenralModel = []
                                                GNobs.Getallgeneralreport()
                                                
                                            }
                                            
                                        }
                                        
                                        
                                        else if CompanyName == "After" {
                                            
                                            
                                            if showtask {
                                                obs.eTaskReportStatus = "After"
                                                obs.workerreportlist = []
                                                obs.Getalltaskreport()
                                                
                                            }
                                            
                                            
                                            else if generalreport {
                                                GNobs.eTaskReportStatus = "After"
                                                GNobs.WorkerGenralModel = []
                                                GNobs.Getallgeneralreport()
                                                
                                            }
                                            
                                           
                                            
                                        } else if CompanyName == "Before" {
                                            
                                            
                                            if showtask{
                                                
                                                obs.eTaskReportStatus = "Before"
                                                obs.workerreportlist = []
                                                obs.Getalltaskreport()
                                            }
                                            
                                            
                                            else if generalreport {
                                                GNobs.eTaskReportStatus = "Before"
                                                GNobs.WorkerGenralModel = []
                                                GNobs.Getallgeneralreport()
                                                
                                            }
                                            
                                        }
                                        
                                        else if CompanyName == "During" {
                                            
                                            if showtask{
                                                
                                                obs.eTaskReportStatus = "During"
                                                obs.workerreportlist = []
                                                obs.Getalltaskreport()
                                            }
                                            
                                            else if generalreport {
                                                GNobs.eTaskReportStatus = "During"
                                                GNobs.WorkerGenralModel = []
                                                GNobs.Getallgeneralreport()
                                                
                                            }
                                            
                                        }
                                    })
                                    
                                    .transition(.opacity)
                                    .frame(width: Responsiveframes.widthPercentageToDP(10), height: Responsiveframes.heightPercentageToDP(5))
                                    
                                }
                                
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
                                                            
                                                            // let datestrng = DateConverter.convertDateFormatwithtime(dateString: obs.WorkerReportmodel?.createdAt ?? "")
                                                            
                                                            //   print(datestrng)
                                                            Text("Time & Date: " + datestrng)
                                                            
                                                                .foregroundColor(.black)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            
                                                            
                                                            HStack {
                                                                Image("Map Point")
                                                                //.resizable()
                                                                    .frame(width: 24, height: 24) // Adjust the size of the image as needed
                                                                
                                                                Text(obs.WorkerReportmodel?.location ?? "")
                                                                
                                                                
                                                                    .foregroundColor(.black)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                
                                                                Spacer()
                                                            }
                                                            
                                                            //  .padding()
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    .frame(width: Responsiveframes.widthPercentageToDP(80))
                                                    .onTapGesture {
                                                        
                                                        //    self.taskIndex = index
                                                        
                                                        print("index",index)
                                                        self.taskIndex = 0
                                                        print("index",index)
                                                        if   isdraftselected == true {
                                                            
                                                            self.taskIndex = index
                                                            Reportdescriptionsubmit =  false

                                                            Reportdescriptiondraft = true
                                                        }
                                                        
                                                        else if isSubmittedSelected == true{
                                                            
                                                            self.taskIndex = index
                                                            Reportdescriptiondraft = false

                                                            Reportdescriptionsubmit = true
                                                            
                                                        }
                                                        
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
                                            .onAppear(){
                                                
                                                datestrng = DateConverter.convertDateFormatwithtime(dateString: obs.WorkerReportmodel?.createdAt ?? "")
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
                                                                  .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))                         .multilineTextAlignment(.center)
                                                                  .foregroundColor(.white)
                                                          }
                                                          .padding(6)
                                                          .background(Color.lightblue)
                            
                                                      }
                                                      
                                                      HStack{
                                                          
                                                          Text("Submitted: \(obss.etaskReportStatus) ")
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
                                                      
                                                      //    self.taskIndex = index
                                                      
                                                      if  isdraftselected == true {
                                                          
                                                          self.reportid = index
                                                          genraldescriptiondraft.toggle()
                                                          
                                                      }
                                                      
                                                      
                                                      else if isSubmittedSelected == true {
                                                          
                                                          self.reportid = index
                                                          genraldescriptionsubmit.toggle()
                                                          
                                                      }
                                                      
                                                  }
                                                  
                                              }
                                              //
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
  
                            

                            if obs.workerreportlist.count > 0 {
                                let validIndex = min(self.taskIndex, obs.workerreportlist.count - 1)
                                NavigationLink(destination: WorkerReportsubmitDescription(reportidmodeldata: obs.workerreportlist[validIndex]), isActive: $Reportdescriptionsubmit) {
                                    EmptyView()
                                }
                            }
                                
                                if (obs.workerreportlist.count>0){
                                    let validIndex = min(self.taskIndex, obs.workerreportlist.count - 1)
                                    NavigationLink(destination: WorkerReportDraftDescription(reportidmodeldata: obs.workerreportlist[validIndex]), isActive: $Reportdescriptiondraft) {
                                        EmptyView()
                                        
                                    }
                                    
                                }
                                
                                
                                if (GNobs.WorkerGenralModel.count>0){
                                    let validIndex = min(self.taskIndex, GNobs.WorkerGenralModel.count - 1)
                                    NavigationLink(destination: GeneralSubmitReport(reportidmodeldata: GNobs.WorkerGenralModel[self.reportid]), isActive: $genraldescriptionsubmit) {
                                        EmptyView()}
                                }
                                
                                
                                if (GNobs.WorkerGenralModel.count>0){
                                    let validIndex = min(self.taskIndex, GNobs.WorkerGenralModel.count - 1)
                                    NavigationLink(destination: GeneralDraftReport(reportidmodeldata: GNobs.WorkerGenralModel[self.reportid]), isActive: $genraldescriptiondraft) {
                                        EmptyView()
                                    }
                                }
                        }
                    }
              
         .frame(width: min(geometry.size.width, geometry.size.height))
                    
                }
            
            }
            
      
            .edgesIgnoringSafeArea(.bottom)

            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onAppear(){
 
                obs.eTaskReportStatus = ""
                obs.workerreportlist = []
                obs.Getalltaskreport()
                showtask = true
                
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct HeaderView: View {
    var body: some View {
        VStack {
            Text("Header View")
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
        }
    }
}

struct ReportlistPickerView: View {
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    let typetasklist = ["After", "During" , "Before" ]
    var placeholder = "After"
    var onChange: (() -> Void)? // Callback function to notify parent

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
                            .foregroundColor(Color.blue) // Set text color to blue
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .blue : .blue) // Set text color to blue
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                           .padding(.leading, 10)
                           // .lineLimit(1)
                        Spacer()
                        Image("Alt Arrow Down")
                        .foregroundColor(.blue) // Set arrow color to blue
                       .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                       .padding(.trailing, 2)

                    }
                   // .padding()
                    
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(33), height: Responsiveframes.heightPercentageToDP(5))
        
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.blue, lineWidth: 1) // Set border color to blue
        )
    }
}


struct Listview: View {
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    let typetasklist = [ "Task Report" ,"General Report"  ]
    var placeholder = "Task Report"
    var onChange: (() -> Void)? // Callback function to notify parent

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
                            .foregroundColor(Color.blue) // Set text color to blue
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .blue : .blue) // Set text color to blue
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                           .padding(.leading, 10)
                           // .lineLimit(1)
                        Spacer()
                        Image("Alt Arrow Down")
                        .foregroundColor(.blue) // Set arrow color to blue
                       .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                       .padding(.trailing, 2)

                    }
                   // .padding()
                    
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(33), height: Responsiveframes.heightPercentageToDP(5))
        
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.blue, lineWidth: 1) // Set border color to blue
        )
    }
}


struct ReportlistPickerViewwitpic: View {

    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    let typetasklist = ["All","After", "During" , "Before" ]
    var placeholder = "All"
    var onChange: (() -> Void)? // Callback function to notify parent

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
                            .foregroundColor(Color.blue) // Set text color to blue
                    }
                }
            } label: {
                VStack{
                    HStack {
//                        Text(value1.isEmpty ? placeholder : value1)
//                            .foregroundColor(value1.isEmpty ? .blue : .blue) // Set text color to blue
//                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
//                           .padding(.leading, 10)
                           // .lineLimit(1)
                    //    Spacer()
                        Image("sliders")
                            .resizable()
                        .foregroundColor(.blue) // Set arrow color to blue
                       .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                     .padding()

                    }
                   // .padding()
                    
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(10), height: Responsiveframes.heightPercentageToDP(5))
        
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.lightblue, lineWidth: 1) // Set border color to blue
        )
    }
}


struct SearchBarView: View {
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    var onCommit: () -> Void = { print("onCommit") }

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image("xmark.circle.fill")
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text("Search Worker by Name...")
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                .lineLimit(1)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                            
                        }
                        
                        TextField("", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: onCommit)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Clear button
                    Button(action: {
                        self.searchText = ""
                        hideKeyboard()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                .background(Color.white)
                .cornerRadius(10.0)
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                 .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(10))
               //  .padding(27)
           
            }
            .padding(.horizontal)
          .edgesIgnoringSafeArea(.bottom)
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}




#Preview {
    WorkerSubmittedReports(taskIndex: 0)
}


public class DateConverter {
    public static func convertDateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMM, yyyy"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    public static func convertDateFormat1(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    public static func convertDateFormatwithtime(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let date = dateFormatter.date(from: dateString) {
            // Set the desired format for displaying the date
            dateFormatter.dateFormat = "dd MMM, yyyy 'at' hh:mm a"
            // Convert the date to the desired format
            let formattedDate = dateFormatter.string(from: date)
            // Return the formatted date string
            return formattedDate
        } else {
            //print("Error: Unable to parse the date string.")
            return "" // Return an empty string if there's an error
        }
    }
    
//    public static func chattimedate(dateString: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
//        
//        if let date = dateFormatter.date(from: dateString) {
//            // Set the desired format for displaying the date
//            dateFormatter.dateFormat = "dd MMM, yyyy 'at' hh:mm a"
//            // Convert the date to the desired format
//            let formattedDate = dateFormatter.string(from: date)
//            // Return the formatted date string
//            return formattedDate
//        } else {
//            //print("Error: Unable to parse the date string.")
//            return "" // Return an empty string if there's an error
//        }
//    }
    
    
    public static func convertDateFormatwithouttime(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let date = dateFormatter.date(from: dateString) {
            // Set the desired format for displaying the date
            dateFormatter.dateFormat = "dd MMM, yyyy"
            // Convert the date to the desired format
            let formattedDate = dateFormatter.string(from: date)
            // Return the formatted date string
            return formattedDate
        } else {
            //print("Error: Unable to parse the date string.")
            return "" // Return an empty string if there's an error
        }
    }
    
    public static func convertDatetotime(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let date = dateFormatter.date(from: dateString) {
            // Set the desired format for displaying the date
            dateFormatter.dateFormat = "hh:mm a"
            // Convert the date to the desired format
            let formattedDate = dateFormatter.string(from: date)
            // Return the formatted date string
            return formattedDate
        } else {
            //print("Error: Unable to parse the date string.")
            return "" // Return an empty string if there's an error
        }
    }

    public static func converrecettime(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        guard let date = dateFormatter.date(from: dateString) else {
            // Return an empty string if there's an error parsing the date string
            return ""
        }

        let calendar = Calendar.current
        
        // Check if the date is today
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: date)
        }
        
        // Check if the date is yesterday
        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }
        
        // Check if the date is within the last 7 days
        if let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date()), date >= sevenDaysAgo {
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }

        // Otherwise, show the date in the format "dd/MMM/yyyy"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }


}


