//
//  SuperTimesheet.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct SuperTimesheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    
    @ObservedObject var supertimsheet = SupertimesheetVM()
    
    @State private var scrollViewOffset: CGFloat = 0.0
    
    @State private var searchText = ""
    
    @State private var showingActionSheet = false
    @State private var selectedImages: [UIImage] = []
    @State private var mainview = false
    @State var showDatePicker: Bool = false
    @State var savedDate: Date? = nil
    @State var savedDatestr  : String? = nil
    @State var savedDatestr1 : String? = nil
    @State var setnewpassword: Bool = false
    
    
    @State private var isSubmittedSelected = true
    @State private var WorkerReportdsptn = false
    
    @State private var isdraftselected = false
    @StateObject var obs = WorkerSubmittedReportVM()
    @StateObject var GNobs = WorkerGeneralReportVM()
    
    @State private var Reportdescriptionsubmit = false
    @State private var Reportdescriptiondraft = false
    
    @State private var genraldescriptionsubmit = false
    @State private var genraldescriptiondraft = false
    
    @State private var datestrng = String()
    
    @State private var WorkerGeneralReport = false
    @State private var WorkkerCheckin = false
    
    @State var taskIndex : Int = 0
    @State var reportid : Int = 0
    
    
    @State private var showtask = false
    
    @State private var generalreport = false
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack(spacing:5.0){
                        
                        HStack{
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            })
                            {
                                Image("Arrow Left-8")
                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                            }
                            
                            
                            Text("Time Sheet")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            
                            Spacer()
                            
                            
                            VStack(alignment: .leading){
                                
                                HStack{
                                    
                                    Text(savedDatestr1 ?? "")
                                        .font(ConstantClass.AppFonts.light)
                                        .padding(.leading, 5.0)
                                        .foregroundColor(savedDatestr1 != nil ? .black : .gray)
                                    
                                    Spacer()
                                    Image("Image 3")
                                        .resizable()
                                        .padding(.trailing, 7.0)
                                        .frame(width: 25.0, height: 25.0)
                                    
                                }
                                .frame(width:ConstantClass.Emptytextfield.datewdth, height: ConstantClass.Emptytextfield.dateheigh)
                                .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                .overlay(
                                    ConstantClass.Emptytextfield.getOverlay()
                                )
                                .onTapGesture {
                                    showDatePicker.toggle()
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                  
                        
                        HStack{
                            
                            VStack{
                                
                                SearchBarView(searchText: $searchText)
                                
                            }
                            // .frame(width: Responsiveframes.widthPercentageToDP(75))
                            .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(10))
                            
                            
                            Spacer()
                            
                            VStack{
                                SupertimesheetFilter(value: $CompanyName,
                                                     showCompanyPicker: $showcompanypicker,
                                                     // showassignedtask: $supertasklistvm.showassignedtask,
                                                     //   showantssignedtask: $supertasklistvm.showantssignedtask,
                                                     onChange: {
                                    if CompanyName == "Break" {
                                        
                                        supertimsheet.requesttype = "Break"
                                        supertimsheet.datestrng = savedDatestr ?? ""
                                        supertimsheet.Timesheet = []
                                        supertimsheet.Getsupertimesheet()
                                                
                                    }
                                    else if CompanyName == "Checked-in" {
                                        supertimsheet.requesttype = "checkIn"
                                        supertimsheet.datestrng = savedDatestr ?? ""

                                        supertimsheet.Timesheet = []
                                        supertimsheet.Getsupertimesheet()
                                        
                                    }
                                    
                                    else if CompanyName == "Checked-out" {
                                        
                                        supertimsheet.requesttype = "checkOut"
                                        supertimsheet.datestrng = savedDatestr ?? ""

                                        supertimsheet.Timesheet = []
                                        supertimsheet.Getsupertimesheet()
                                        
                                    }
                                    else if CompanyName == "Out for Work" {
                                        
                                        supertimsheet.requesttype = "goOutsideTime"
                                        supertimsheet.datestrng = savedDatestr ?? ""
                                        supertimsheet.Timesheet = []
                                        supertimsheet.Getsupertimesheet()
                                        
                                    }
                                })
                                
                                .transition(.opacity)
                                .frame(width: Responsiveframes.widthPercentageToDP(10), height: Responsiveframes.heightPercentageToDP(5))
                                
                            }
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        if supertimsheet.Timesheet.count != 0 {
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVStack(spacing: 8) { // Set a constant spacing value
                                    ForEach(Array(supertimsheet.Timesheet.enumerated()).filter { _, obs in
                                        return (obs.userName.contains(searchText)) || searchText.isEmpty
                                    }, id: \.element) { index, obs1 in
                                        if CompanyName != "Break" {
                                            VStack(spacing: 8) { // Set a consistent spacing value
                                                VStack(alignment: .leading, spacing: 8.0) {
                                                    HStack {
                                                        let checkin = DateConverter.convertDatetotime(dateString: obs1.checkIn ?? "")
                                                        let checkout = DateConverter.convertDatetotime(dateString: obs1.checkOut ?? "")
                                                        let goforoutside = DateConverter.convertDatetotime(dateString: obs1.goOutsideTime ?? "")
                                                        
                                                        HStack {
                                                            if CompanyName == "Out for Work" {
                                                                Image("Ellipse 20")
                                                                Text(obs1.userName)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                    .foregroundColor(Color.black)
                                                                
                                                                Spacer()
                                                                HStack {
                                                                    Text(goforoutside)
                                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                        .foregroundColor(.greenapp)
                                                                }
                                                                .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
                                                                .background(Color.lightgreen)
                                                                .cornerRadius(22)
                                                                .padding(.trailing, 8)
                                                            }
                                                            if CompanyName == "Checked-in" {
                                                                Image("Ellipse 20")
                                                                Text(obs1.userName)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                    .foregroundColor(Color.black)
                                                                
                                                                Spacer()
                                                                HStack {
                                                                    Text(checkin)
                                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                        .foregroundColor(.greenapp)
                                                                }
                                                                .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
                                                                .background(Color.lightgreen)
                                                                .cornerRadius(22)
                                                                .padding(.trailing, 8)
                                                            } else if CompanyName == "Checked-out" {
                                                                Image("Ellipse 20")
                                                                Text(obs1.userName)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                    .foregroundColor(Color.black)
                                                                
                                                                Spacer()
                                                                HStack {
                                                                    Text(checkout)
                                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                        .foregroundColor(.red)
                                                                }
                                                                .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
                                                                .background(Color.lightred)
                                                                .cornerRadius(22)
                                                                .padding(.trailing, 8)
                                                            }
                                                        }
                                                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                                                    }
                                                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                                                }
                                            }
                                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                                            .padding(.bottom, 8) // Add consistent bottom padding
                                        }
                                        if CompanyName == "Break" {
                                            ForEach(obs1.breakTimearray, id: \.self) { breakTimeEntry in
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        let starttime = DateConverter.convertDatetotime(dateString: breakTimeEntry.startTime ?? "")
                                                        let starttimestr = DateConverter.convertDateFormatwithouttime(dateString: breakTimeEntry.startTime ?? "")
                                                        
                                                        //  if CompanyName == "Break" {
                                                        Image("Ellipse 20")
                                                        Text(breakTimeEntry.name ?? "")
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.red)
                                                        
                                                        Spacer()
                                                        HStack {
                                                            Text(starttime)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                .foregroundColor(.red)
                                                        }
                                                        .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
                                                        .background(Color.lightred)
                                                        .cornerRadius(22)
                                                        .padding(.trailing, 8)
                                                        // }
                                                    }
                                                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Button(action: {
                                supertimsheet.datestrng = savedDatestr ?? ""
                                supertimsheet.downloadtimesheet()
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Download Timesheet")
                                        .foregroundColor(.white)
                                        .font(ConstantClass.AppFonts.medium)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(6))
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                supertimsheet.datestrng = savedDatestr ?? ""
                                supertimsheet.downloadtimesheet()
                            }
                        }

                        
                        
                        
//                        if supertimsheet.Timesheet.count != 0 {
//                            ScrollView(.vertical, showsIndicators: false) {
//                                LazyVStack(spacing: 2) {
//                                    ForEach(Array(supertimsheet.Timesheet.enumerated()).filter { _, obs in
//                                        return (obs.userName.contains(searchText)) || searchText.isEmpty
//                                    }, id: \.element) { index, obs1 in
//                                        
//                                        VStack(spacing: 2) {
//                                            
//                                            VStack(alignment: .leading , spacing: 8.0) {
//                                                HStack {
//                                                    let checkin = DateConverter.convertDatetotime(dateString: obs1.checkIn ?? "")
//                                                    let checkout = DateConverter.convertDatetotime(dateString: obs1.checkOut ?? "")
//                                                    let goforoutside = DateConverter.convertDatetotime(dateString: obs1.goOutsideTime ?? "")
//                                                    
//                                                    HStack {
//                                                        if CompanyName == "Out for Work" {
//                                                            Image("Ellipse 20")
//                                                            Text(obs1.userName)
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(Color.black)
//                                                            
//                                                            Spacer()
//                                                            HStack {
//                                                                Text(goforoutside)
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(.greenapp)
//                                                            }
//                                                            .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
//                                                            .background(Color.lightgreen)
//                                                            .cornerRadius(22)
//                                                            .padding(.trailing)
//                                                        }
//                                                        if CompanyName == "Checked-in" {
//                                                            Image("Ellipse 20")
//                                                            Text(obs1.userName)
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(Color.black)
//                                                            
//                                                            Spacer()
//                                                            HStack {
//                                                                Text(checkin)
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(.greenapp)
//                                                            }
//                                                            .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
//                                                            .background(Color.lightgreen)
//                                                            .cornerRadius(22)
//                                                            .padding(.trailing)
//                                                        } else if CompanyName == "Checked-out" {
//                                                            Image("Ellipse 20")
//                                                            Text(obs1.userName)
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(Color.black)
//                                                            
//                                                            Spacer()
//                                                            HStack {
//                                                                Text(checkout)
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(.red)
//                                                            }
//                                                            .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
//                                                            .background(Color.lightred)
//                                                            .cornerRadius(22)
//                                                            .padding(.trailing)
//                                                        }
//                                                    }   .frame(width: Responsiveframes.widthPercentageToDP(90))
//                                                      
//                                                }
//                                                .frame(width: Responsiveframes.widthPercentageToDP(90))
//                                            }
//                                        }
//                                        .frame(width: Responsiveframes.widthPercentageToDP(90))
//                                        
//                                        ForEach(obs1.breakTimearray, id: \.self) { breakTimeEntry in
//                                            VStack(alignment: .leading)  {
//
//                                                HStack {
//                                                    let starttime = DateConverter.convertDatetotime(dateString: breakTimeEntry.startTime ?? "")
//                                                    
//                                                    let starttimestr = DateConverter.convertDateFormatwithouttime(dateString: breakTimeEntry.startTime ?? "")
//                                                    
//                                                    
//                                                    if CompanyName == "Break" {
//                                                        Image("Ellipse 20")
//                                                        Text(breakTimeEntry.name ?? "")
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.red)
//                                                        
//                                                        Spacer()
//                                                        HStack {
//                                                            Text(starttime)
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(.red)
//                                                        }
//                                                        .frame(width: Responsiveframes.widthPercentageToDP(28), height: Responsiveframes.heightPercentageToDP(6))
//                                                        .background(Color.lightred)
//                                                        .cornerRadius(22)
//                                                        .padding(.trailing)
//                                                    }
//                                                }
//                                                .frame(width: Responsiveframes.widthPercentageToDP(90))
//                                            
//                                            }
//                                            
//                                        }
//                                    }
//                                }
//                            }
//                            
//                            Button(action: {
//                                supertimsheet.datestrng = savedDatestr ?? ""
//                                supertimsheet.downloadtimesheet()
//                            }) {
//                                HStack {
//                                    Spacer()
//                                    Text("Download Timesheet")
//                                        .foregroundColor(.white)
//                                        .font(ConstantClass.AppFonts.medium)
//                                        .multilineTextAlignment(.center)
//                                        .lineLimit(1)
//                                    Spacer()
//                                }
//                            }
//                            .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(6))
//                            .background(Color.accentColor)
//                            .cornerRadius(10)
//                            .multilineTextAlignment(.center)
//                            .onTapGesture {
//                                supertimsheet.datestrng = savedDatestr ?? ""
//                                supertimsheet.downloadtimesheet()
//                            }
//                        }

//
//                        if supertimsheet.Timesheet.count !=  0  {
//                            ScrollView(.vertical , showsIndicators: false){
//                                VStack(alignment: .leading){
//                                    //  ForEach(supertimsheet.Timesheet, id: \.self) { obs in
//                                    
//                                    ForEach(Array(supertimsheet.Timesheet.enumerated()).filter { _, obs in
//                                        return (obs.userName.contains(searchText)) ||   searchText.isEmpty
//                                    }, id: \.element) { index, obs1 in
//                                        
//                                        VStack(alignment: .leading){
//                                            
//                                            VStack(alignment: .leading){
//                                                HStack{
//                                                    
//                                               
//                                                    let checkin = DateConverter.convertDatetotime(dateString: obs1.checkIn ?? "")
//                                                    let checkout = DateConverter.convertDatetotime(dateString: obs1.checkOut ?? "")
//                                                    let goforoutside = DateConverter.convertDatetotime(dateString: obs1.goOutsideTime ?? "")
//
//                                                    
//                                                    HStack{
//                                                        
//                                                        if CompanyName == "Out for Work" {
//                                                            
//                                                            
//                                                            Image("Ellipse 20")
//                                                            
//                                                            Text(obs1.userName )
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(Color.black)
//
//                                                            Spacer()
//                                                            HStack{
//                                                                
//                                                                
//                                                                Text(goforoutside)
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(.greenapp)
//                                                        }
//                                                             
//                                                       
//                                                            .frame(width: Responsiveframes.widthPercentageToDP(28),height: Responsiveframes.heightPercentageToDP(6))
//                                               
//                                                            .background(Color.lightgreen)
//                                                            .cornerRadius(22)
//                                                             .padding()
//
//                                                        }
//                                                       if CompanyName == "Checked-in" {
//                                                           
//                                                           Image("Ellipse 20")
//                                                           
//                                                           Text(obs1.userName )
//                                                               .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                               .foregroundColor(Color.black)
//                                                           Spacer()
//                                                           HStack{
//                                                               Text(checkin)
//                                                                   .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                   .foregroundColor(.greenapp)
//                                                           }
//
//                                                           .frame(width: Responsiveframes.widthPercentageToDP(28),height: Responsiveframes.heightPercentageToDP(6))
//                                                 
//                                                           .background(Color.lightgreen)
//                                                           .cornerRadius(22)
//                                                            .padding()
//                                                        }
//                                                        
//                                                        else if CompanyName == "Checked-out" {
//                                                            
//                                                            
//                                                            Image("Ellipse 20")
//                                                            
//                                                            Text(obs1.userName )
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(Color.black)
//                                                            Spacer()
//                                                    
//                                                            HStack{
//                                                                Text(checkout)
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(.red)
//                                                                
//                                                            }  
//                                                   
//                                                           
//                                                            .frame(width: Responsiveframes.widthPercentageToDP(28),height: Responsiveframes.heightPercentageToDP(6))
//                                             
//                                                            .background(Color.lightred)
//                                                            .cornerRadius(22)
//                                                             .padding()
//
//                                                        }
////
//
//                                                    }
//                                                    
//                                                }
//                                                .frame(width: Responsiveframes.widthPercentageToDP(80))
//                                        
//                                            }
//                                            
//                                        }
//                                        
//                                        .frame(width: Responsiveframes.widthPercentageToDP(90))
//                                         
//                                        ForEach(obs1.breakTimearray, id: \.self) { breakTimeEntry in
//                                            VStack {
//                                                HStack {
//                                                    HStack {
//                                                        
//                                                        let starttime = DateConverter.convertDatetotime(dateString: breakTimeEntry.startTime ?? "")
//                                                        
//                                                        let starttimestr = DateConverter.convertDateFormatwithouttime(dateString: breakTimeEntry.startTime ?? "") 
//                                                        
//                                                        if CompanyName == "Break" {
//                                                            
//                                                            Image("Ellipse 20")
//
//                                                            Text(breakTimeEntry.name ?? "")
//                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                .foregroundColor(Color.red)
//                                                            
//                                                            Spacer()
//                                                               
//                                                            HStack{
//                                                                Text(starttime)
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(.red)
//                                                                
//                                                            }
//                                                   
//                                                            .frame(width: Responsiveframes.widthPercentageToDP(28),height: Responsiveframes.heightPercentageToDP(6))
//                                                     
//                                                            .background(Color.lightred)
//                                                            .cornerRadius(22)
//                                                             .padding()
//                                       
//                                                        }
//                                                        
//                                                    }
//                                                }
//                                                .frame(width: Responsiveframes.widthPercentageToDP(80))
//                                                .padding()
//                                       
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                            
//                            
//                            Button(action: {
//                        
//                                supertimsheet.datestrng = savedDatestr ?? ""
//                                supertimsheet.downloadtimesheet()
//                                
//                            }) {
//                                HStack {
//                                    Spacer()
//                                    Text("Download Timesheet")
//                                        .foregroundColor(.white)
//                                        .font(ConstantClass.AppFonts.medium)
//                                        .multilineTextAlignment(.center)
//                                        .lineLimit(1)
//                                    Spacer()
//                                }
//                            }
//                            .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
//                            .background(Color.accentColor)
//                            .cornerRadius(10)
//                            .multilineTextAlignment(.center)
//                            
//                            .onTapGesture {
//                                
//                                supertimsheet.datestrng = savedDatestr ?? ""
//                                supertimsheet.downloadtimesheet()
//                            }
//                        }
                        
                        else {
                            Spacer()
                            EmptyListView(screenName: "timsheet")
                            Spacer()
                        }
                    }
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry
                    
                    if showDatePicker {
                        Superdatepicker(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date(), savedDatestr: $savedDatestr, savedDatestr1: $savedDatestr1)
                        // .animation(.linear)
                            .transition(.opacity)
                    }
                    
                }
            }
            
            
            
            
            
        
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
            //  .edgesIgnoringSafeArea(.bottom)
            
            
            
        }    .onAppear(){
            savedDatestr =  self.getcurrentdate()

            if savedDatestr1 != nil {
                supertimsheet.datestrng = savedDatestr1 ?? ""
                
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SetDate"), object: nil, queue: OperationQueue.main) {_ in
                
                supertimsheet.datestrng = savedDatestr ?? ""
                supertimsheet.Timesheet = []
                supertimsheet.Getsupertimesheet()
                
            }
            
            
            
            CompanyName = "Checked-in"
            supertimsheet.requesttype = "checkIn"
            supertimsheet.datestrng = savedDatestr ?? ""
            supertimsheet.Timesheet = []
            supertimsheet.Getsupertimesheet()

        }
        
        
        .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        
    }
    
    func getcurrentdate() -> String  {
        let date = Date()
        let df1 = DateFormatter()
        df1.dateFormat = "dd-MM-yyyy"
        let dateString1 = df1.string(from: date)
        savedDatestr1 = dateString1
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        savedDatestr = dateString
        return dateString
        
    }
    
}


struct Superdatepicker: View {
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    @Binding var savedDatestr: String?
    @Binding var savedDatestr1: String?
    
    var body: some View {
        ZStack {
//            Color.black.opacity(0.3)
//                .edgesIgnoringSafeArea(.all)
//            
            VStack(spacing: 20.0) {
                DatePicker(
                    "Test",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .colorScheme(.dark)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white.opacity(0.5))
                )
                .padding()
                
                Divider()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("blackcolor"))
                    .cornerRadius(10)
                    
                    Button(action: {
                        let formatter1 = DateFormatter()
                        formatter1.dateFormat = "dd-MM-yyyy"
                        let stro = formatter1.string(from: selectedDate)
                        savedDatestr1 = stro
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let str = formatter.string(from: selectedDate)
                        
                        savedDatestr = str
                        savedDate = selectedDate
                        showDatePicker = false
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetDate"), object: self)
                        
                    }, label: {
                        Text("Set Date")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("redColor"))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
//            .background(
//                RoundedRectangle(cornerRadius: 30)
//                    .foregroundColor(Color.black)
//            )
            .background(
                RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.cdDarkGray, Color.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.darkblue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))

            )
        }
    }
}



struct SupertimesheetFilter: View {
    
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    let typetasklist = ["Checked-in", "Checked-out" , "Break" , "Out for Work" ]
    var placeholder = "Checked-in"
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
struct SearchBarView1: View {
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
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                        }
                        
                        // Move the TextField outside the conditional block
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
                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(10))
                //                .padding(.horizontal, 27)
                
            }
            .padding(.horizontal)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct Timesheetpicker: View {
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    var onChange: (() -> Void)? // Callback function to notify parent
    
    let typetasklist = ["All", "Checked-in", "Out for Work" , "Break"]
    var placeholder = "All"
    
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
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            .foregroundColor(Color.white) // Set text color to white
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .lightblue : .lightblue) // Set text color to white
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            .padding(.leading, 10)
                        Spacer()
                        Image("Alt Arrow Down-1")
                            .foregroundColor(Color.lightblue) // Set arrow color to white
                            .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                            .padding(.trailing, 2)
                    }
                }
            }
        }
        
        .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.blue, lineWidth: 1)
        )
        
    }
}





//
//
//#Preview {
//    SuperTimesheet()
//}
