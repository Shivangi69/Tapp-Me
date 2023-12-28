//
//  WorkerTimesheet.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct WorkerTimesheet: View {
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    @State private var mainview = false
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var showingActionSheet = false
    @State private var selectedImages: [UIImage] = []
    @State var showDatePicker: Bool = false
    @State var savedDate: Date? = nil
    @State var savedDatestr  : String? = nil
    @State var savedDatestr1 : String? = nil
    @State var setnewpassword: Bool = false
    
    @ObservedObject var workerobs = SupertimesheetVM()

    @State var showDueDatePicker: Bool = false
    @State var savedDatedue: Date? = nil
    @State var saveddueDate  : String? = nil
    @State var savedDatedue1 : String? = nil
    
    @State var selectedYear: Int?
    @State var selectedMonth: Int?
    @State var showPicker: Bool
 
    @State private var showPickers = false

    var body: some View {
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack{
                        
                        HStack(){
                            
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
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            Spacer()

                            
                            VStack{
                                SupertimesheetFilter(value: $CompanyName,
                                                     showCompanyPicker: $showcompanypicker,
                                                     // showassignedtask: $supertasklistvm.showassignedtask,
                                                     //   showantssignedtask: $supertasklistvm.showantssignedtask,
                                                     onChange: {
                                    if CompanyName == "Break" {
                                        
                                        workerobs.requesttype = "Break"
                                        workerobs.todate = saveddueDate ?? ""
                                        workerobs.fromdate = savedDatestr ?? ""
                                        workerobs.Getworkertimesheet()

                                    }
                                    else if CompanyName == "Checked-in" {
                                        
                                        workerobs.requesttype = "checkIn"
                                        workerobs.todate = saveddueDate ?? ""
                                        workerobs.fromdate = savedDatestr ?? ""
                                   //     workerobs.Timesheet = []
                                        workerobs.Getworkertimesheet()
                                        
                                    }
                                    
                                    else if CompanyName == "Checked-out" {
                                    
                                        workerobs.requesttype = "checkOut"
                                        workerobs.todate = saveddueDate ?? ""
                                        workerobs.fromdate = savedDatestr ?? ""
                                     //   workerobs.Timesheet = []
                                        workerobs.Getworkertimesheet()
                                        
                                    }
                                    else if CompanyName == "Out for Work" {
                                        
                                        workerobs.requesttype = "goOutsideTime"
                                        workerobs.todate = saveddueDate ?? ""
                                        workerobs.fromdate = savedDatestr ?? ""
                                       // workerobs.Timesheet = []
                                        workerobs.Getworkertimesheet()
                                        
                                    }
                                })
                                
                                .transition(.opacity)
                                .frame(width: Responsiveframes.widthPercentageToDP(10), height: Responsiveframes.heightPercentageToDP(5))
                                
                            }
                            
                            
                
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        HStack{
                            
                            
                            VStack(alignment: .leading){
                        
                                
                                
                                VStack(alignment: .leading){
                                    Text("From")
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        .foregroundColor(Color.black)
                                    
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
                                    .frame(width:ConstantClass.Emptytextfield.datewdth1, height: ConstantClass.Emptytextfield.dateheigh1)
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
                           
                            Spacer()
                            
                            
                            VStack(alignment: .leading){
                                
                                
                                
                                VStack(alignment: .leading){
                         
                                        Text("To")
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .foregroundColor(Color.black)
                                HStack{
                                    
                                    Text(savedDatedue1 ?? "")
                                        .font(ConstantClass.AppFonts.light)
                                        .padding(.leading, 5.0)
                                        .foregroundColor(savedDatestr1 != nil ? .black : .gray)
                                    
                                    Spacer()
                                    Image("Image 3")
                                        .resizable()
                                        .padding(.trailing, 7.0)
                                        .frame(width: 25.0, height: 25.0)
                                    
                                }
                                .frame(width:ConstantClass.Emptytextfield.datewdth1, height: ConstantClass.Emptytextfield.dateheigh1)
                                .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                .overlay(
                                    ConstantClass.Emptytextfield.getOverlay()
                                )
                                .onTapGesture {
                                    showDueDatePicker.toggle()
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                                
                            }
                            }
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        
                        HStack{
                            
                            Button(action: {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ToSetDate"), object: self)
                                
                            }) {
                                Text("Search")
                                    .foregroundColor(.white)
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(5))
                            
                            .background(Color.accentColor)
                            .cornerRadius(6)
                            .padding()
                            .onTapGesture {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ToSetDate"), object: self)
                                
                                
                            }
                            Spacer()
                        }
                        
                        if workerobs.Timesheet.count != 0 {
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVStack(spacing: 2) {
                                    ForEach(Array(workerobs.Timesheet.enumerated()), id: \.element) { index, timesheetEntry in
                                        VStack(spacing: 2) {
                                            HStack {
                                                let checkin = DateConverter.convertDatetotime(dateString: timesheetEntry.checkIn ?? "")
                                                let checkout = DateConverter.convertDatetotime(dateString: timesheetEntry.checkOut ?? "")
                                                let checkindate = DateConverter.convertDateFormatwithouttime(dateString: timesheetEntry.checkIn ?? "")
                                                let outforwork = DateConverter.convertDatetotime(dateString: timesheetEntry.goOutsideTime ?? "")
                                                let outforworkdate = DateConverter.convertDateFormatwithouttime(dateString: timesheetEntry.goOutsideTime ?? "")
                                                let checloutdate = DateConverter.convertDateFormatwithouttime(dateString: timesheetEntry.checkOut ?? "")

                                                if CompanyName == "Checked-in" {
                                                    HStack {
                                                        Image("Ellipse 20")
                                                        Text("Check-In")
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.green)
                                                        Text("at " + checkin)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.black)
                                                        Text(checkindate)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.blue)
                                                    }
                                                    .padding()
                                                    .frame(width: ConstantClass.HstackTextFieldSize.width, height: ConstantClass.HstackTextFieldSize.height)
                                                    .overlay(
                                                        ConstantClass.Emptytextfield.getOverlay()
                                                    )
                                                } else if CompanyName == "Checked-out" {
                                                    HStack {
                                                        Image("Ellipse 20")
                                                        Text("Check-out")
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.red)
                                                        Text("at " + checkout)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.black)
                                                        Text(checloutdate)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.blue)
                                                    }
                                                    .padding()
                                                    .frame(width: ConstantClass.HstackTextFieldSize.width, height: ConstantClass.HstackTextFieldSize.height)
                                                    .overlay(
                                                        ConstantClass.Emptytextfield.getOverlay()
                                                    )
                                                } else if CompanyName == "Out for Work" {
                                                    HStack {
                                                        Image("Ellipse 20")
                                                        Text("Out for Work")
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.red)
                                                        Text("at " + outforwork)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.black)
                                                        Text(outforworkdate)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            .foregroundColor(Color.blue)
                                                    }
                                                    .frame(width: ConstantClass.HstackTextFieldSize.width, height: ConstantClass.HstackTextFieldSize.height)
                                                    .overlay(
                                                        ConstantClass.Emptytextfield.getOverlay()
                                                    )
                                                }
                                            }
                                            .frame(width: ConstantClass.HstackTextFieldSize.width, height: ConstantClass.HstackTextFieldSize.height)

                                            ForEach(workerobs.breaktime, id: \.self) { breakTimeEntry in
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        let starttime = DateConverter.convertDatetotime(dateString: breakTimeEntry.startTime ?? "")
                                                        let starttimestr = DateConverter.convertDateFormatwithouttime(dateString: breakTimeEntry.startTime ?? "")
                                                        if CompanyName == "Break" {
                                                            HStack {
                                                                Image("Ellipse 20")
                                                                Text("Break")
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                    .foregroundColor(Color.red)
                                                                Text("at " + starttime)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                    .foregroundColor(Color.black)
                                                                Text(starttimestr)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                    .foregroundColor(Color.black)
                                                            }
                                                            .padding()
                                                            .frame(width: ConstantClass.HstackTextFieldSize.width, height: ConstantClass.HstackTextFieldSize.height)
                                                            .overlay(
                                                                ConstantClass.Emptytextfield.getOverlay()
                                                            )
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                            }
                        }

//
//                        if workerobs.Timesheet.count !=  0  {
//                            ScrollView(.vertical, showsIndicators: false) {
//                                LazyVStack(spacing: 0) {
//                                    
//                                    ForEach(Array(workerobs.Timesheet.enumerated()), id: \.element) { index, timesheetEntry in
//                                        
//                                        VStack(spacing: 0){
//                                            HStack {
////                                                HStack {
//                                                    
//                                                    let checkin = DateConverter.convertDatetotime(dateString: timesheetEntry.checkIn ?? "")
//                                                    let checkout = DateConverter.convertDatetotime(dateString: timesheetEntry.checkOut ?? "")
//                                                    
//                                                    let checkindate = DateConverter.convertDateFormatwithouttime(dateString: timesheetEntry.checkIn ?? "")
//                                                    
//                                                    let outforwork = DateConverter.convertDatetotime(dateString: timesheetEntry.goOutsideTime ?? "")
//                                                    
//                                                    let outforworkdate = DateConverter.convertDateFormatwithouttime(dateString: timesheetEntry.goOutsideTime ?? "")
//                                                    
//                                               
//                                                    let checloutdate = DateConverter.convertDateFormatwithouttime(dateString: timesheetEntry.checkOut ?? "")
//                                                    
//                                                    if CompanyName == "Checked-in"  {
//                                                        HStack {
//                                                        Image("Ellipse 20")
//                                                        Text("Check-In")
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.green)
//                                                        
//                                                        Text("at " + checkin)
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.black)
//                                                        
//                                                        Text(checkindate)
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.blue)
//                                                        
//                                                    }.padding()
//                                                        .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
//
//                                                        .overlay(
//                                                            ConstantClass.Emptytextfield.getOverlay()
//                                                        )
//                                                    
//                                                        
//                                                    } else if CompanyName == "Checked-out" {
//                                                        HStack {
//                                                            Image("Ellipse 20")
//                                                        Text("Check-out")
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.red)
//                                                        
//                                                        Text("at " + checkout)
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.black)
//                                                        
//                                                        Text(checloutdate)
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.blue)
//                                                    }.padding()
//                                                        .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
//
//                                                        .overlay(
//                                                            ConstantClass.Emptytextfield.getOverlay()
//                                                        )
//                                                    
//                                                    } else if CompanyName == "Out for Work"  {
//                                                        HStack {
//                                                            Image("Ellipse 20")
//                                                        Text("Out for Work")
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.red)
//                                                        
//                                                        Text("at " + outforwork)
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.black)
//                                                        
//                                                        Text(outforworkdate)
//                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            .foregroundColor(Color.blue)
//                                                        
//                                                    }
//                                                        .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
//
//                                                        .overlay(
//                                                            ConstantClass.Emptytextfield.getOverlay()
//                                                        )
//                                                    
//                                                    }
//                                                    
//                             
//                                            }
//                                  
//                                            .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
//
//                                            ForEach(workerobs.breaktime, id: \.self) { breakTimeEntry in
//                                                VStack(alignment: .leading) {
//                                                 
//                                                    HStack {
//                                                        //                                                            Image("Ellipse 20")
//                                                        
//                                                        let starttime = DateConverter.convertDatetotime(dateString: breakTimeEntry.startTime ?? "")
//                                                        
//                                                        let starttimestr = DateConverter.convertDateFormatwithouttime(dateString: breakTimeEntry.startTime ?? "")
//                                                        
//                                                        
//                                                        if CompanyName == "Break" {
//                                                            HStack{
//                                                                Image("Ellipse 20")
//                                                                
//                                                                Text("Break")
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(Color.red)
//                                                                
//                                                                Text("at " + starttime)
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(Color.black)
//                                                                
//                                                                Text(starttimestr)
//                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                                    .foregroundColor(Color.black)
//                                                            }.padding()
//                                                                .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
//
//                                                                .overlay(
//                                                                    ConstantClass.Emptytextfield.getOverlay()
//                                                                )
//                                                        }
//                                                    }
//                                             
//                                                }
//                                                Spacer()
//                                            }
//                                        }
//                                  
//                                  
//                                    }
//                                    
//                                }
//                             
//                                .frame(width: Responsiveframes.widthPercentageToDP(90))
//
//                                
//                       
//                            }
//                      
//                        }
                        
                     
                        else {
                            
                            Spacer()
                            EmptyListView(screenName: "timsheet")
                            Spacer()
                        }
                        
           

                        
                    }
                    .frame(width: min(geometry.size.width, geometry.size.height))

                    if showDatePicker {
                        FromDatePicker(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date(), savedDatestr: $savedDatestr, savedDatestr1: $savedDatestr1)
                           // .animation(.linear)
                            .transition(.opacity)
                    }
                    
                    
                    if showDueDatePicker {
                        ToDatePicker(showDatePicker: $showDueDatePicker, savedDate: $savedDatedue, selectedDate: savedDatedue ?? Date(), savedDatestr: $saveddueDate, savedDatestr1: $savedDatedue1)
                           // .animation(.linear)
                            .transition(.opacity)
                    }
                    
                }
            }
          
            .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
          
            
            
            
        }.onAppear(){
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "ToSetDate"), object: nil, queue: OperationQueue.main) {_ in
                 
                workerobs.todate = saveddueDate ?? ""
                workerobs.Timesheet = []
                workerobs.Getworkertimesheet()
                
            }
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "FromSetDate"), object: nil, queue: OperationQueue.main) {_ in
                
                workerobs.fromdate = savedDatestr ?? ""
                workerobs.Timesheet = []
                workerobs.Getworkertimesheet()
                
            }
        
            savedDatestr =  self.getcurrentdate()
            saveddueDate =  self.getcurrentdate()
            CompanyName = "Checked-in"
            workerobs.requesttype = "checkIn"
            workerobs.todate = saveddueDate ?? ""
            workerobs.fromdate = savedDatestr ?? ""
            workerobs.Getworkertimesheet()
            
          
            
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
 //       savedDatestr1 = dateString1
        savedDatedue1 = dateString1
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        savedDatestr = dateString
        saveddueDate = dateString

     //   saveddueDate = dateString1

        return dateString
        
    }
}


struct FromDatePicker: View {
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    @Binding var savedDatestr: String?
    @Binding var savedDatestr1: String?
    
    var body: some View {
        ZStack {
//        Color.black.opacity(0.3)
//        .edgesIgnoringSafeArea(.all)
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
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FromSetDate"), object: self)
                        
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
//                    .foregroundColor(Color.accentColor)
//            )
            .background(
                RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.cdDarkGray, Color.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.darkblue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))

            )

        }
    }
}


struct ToDatePicker: View {
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
//                DatePicker(
//                    "Test",
//                    selection: $selectedDate,
//                    in: ...Date(), // Set a range up to the current date
//                    displayedComponents: [.date]
//                )
//                .datePickerStyle(GraphicalDatePickerStyle())
//                .colorScheme(.dark)
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(Color.white.opacity(0.5))
//                )
//                .padding()
                
                
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
                        
                        print(savedDatestr1 ?? "")
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let str = formatter.string(from: selectedDate)
                        
        
                        savedDatestr = str
                        
                        savedDate = selectedDate
                        showDatePicker = false
                        
                        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ToSetDate"), object: self)
                        
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

           
            
            .background(
                RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.cdDarkGray, Color.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.darkblue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))

            )
        }
    }
}


struct YearPicker: View {

    @Binding var selectedYear: Int?
    @Binding var showYearPicker: Bool
    
    var onChange: (() -> Void)? // Callback function to notify parent

    let years = Array(2000...2050)
    var placeholder = "Select Year"
  
    var body: some View {
        
        HStack {
            Menu {
                ForEach(years, id: \.self) { year in
                    Button(action: {
                        self.selectedYear = year
                        self.showYearPicker.toggle()
                        onChange?() // Invoke callback

                    }) {
                        Text("\(year)")
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            .foregroundColor(Color.white) // Set text color to white
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(selectedYear.map { "\($0)" } ?? placeholder)
                            .foregroundColor(selectedYear == nil ? .lightblue : .lightblue) // Set text color to white
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


struct MonthPicker: View {

    @Binding var selectedMonth: Int?
    @Binding var showMonthPicker: Bool
    
    var onChange: (() -> Void)? // Callback function to notify parent

    let months = Array(1...12)
    var placeholder = "Select Month"
  
    var body: some View {
        
        HStack {
            Menu {
                ForEach(months, id: \.self) { month in
                    Button(action: {
                        self.selectedMonth = month
                        self.showMonthPicker.toggle()
                        onChange?() // Invoke callback

                    }) {
                        Text("\(month)")
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                            .foregroundColor(Color.white) // Set text color to white
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(selectedMonth.map { "\($0)" } ?? placeholder)
                            .foregroundColor(selectedMonth == nil ? .lightblue : .lightblue) // Set text color to white
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


struct YearMonthPicker: View {
    @Binding var selectedYear: Int?
    @Binding var selectedMonth: Int?
    @Binding var showPicker: Bool
    
    var onChange: (() -> Void)? // Callback function to notify parent
    
    let years = Array(2021...2050)
    let months = Array(1...12)
    var yearPlaceholder = "Select Year"
    var monthPlaceholder = "Month"
    
    var body: some View {
        
        HStack{
        Menu {
            VStack {
                YearPicker(selectedYear: $selectedYear, showYearPicker: $showPicker, onChange: onChange)
                    .padding(.bottom, 10)
                
                MonthPicker(selectedMonth: $selectedMonth, showMonthPicker: $showPicker, onChange: onChange)
            }
        } label: {
            Text("\(selectedYear.map { "\($0)" } ?? yearPlaceholder) & \(selectedMonth.map { "\($0)" } ?? monthPlaceholder)")
                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                .padding(.leading, 10)
        }
    }
        .frame(width: Responsiveframes.widthPercentageToDP(33), height: Responsiveframes.heightPercentageToDP(5))
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.blue, lineWidth: 1)
        )
    }
}


