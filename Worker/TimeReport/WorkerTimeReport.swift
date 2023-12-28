//
//  WorkerTimeReport.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct WorkerTimeReport: View {
    @State private var Workinghourshistory = false
    @State private var Timesheet = false
    
    @StateObject var statuscheck = CompanylistbyemailVMgoogle()
    
    @State var currentdate  : String? = nil
    @State private var timeDifferenceString: String = ""

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        NavigationView{
            
            ZStack {
                GeometryReader { geometry in
                    
                    VStack(spacing:20.0){
                        VStack {
                            
                            VStack(alignment: .center, spacing: 8.0){
                                
                                
                                
                                let checkintime = DateConverter.convertDatetotime(dateString: statuscheck.Checkinmodel?.checkIn ?? "")
                                if checkintime == "" {
                                
                                    
                                    Text("Today Not Logged in." )
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        .foregroundColor(.blue)
                                    
                                    
                                }
                                else if checkintime != "" {
                                    Text("Logged in today at " + checkintime)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        .foregroundColor(.blue)
                                }
                                
                                    
                                
                                VStack(alignment: .center, spacing: 20.0) {
                                    if let checkinString = statuscheck.Checkinmodel?.checkIn {
                                        if checkinString == "" {
                                            // Display "0" for hours, minutes, and seconds if checkinString is empty
                                            HStack (spacing: 10) {
                                                TimeUnitView(time: "0")
                                                Text(":")
                                                    .font(.headline)
                                                    .foregroundColor(.accentColor)
                                                TimeUnitView(time: "0")
                                                Text(":")
                                                    .font(.headline)
                                                    .foregroundColor(.accentColor)
                                                TimeUnitView(time: "0")
                                            }
                                        } else if let checkinTime = formatDateString(checkinString) {
                                            // Calculate the time difference if checkinString is not empty
                                            let currentTime = Date()
                                            let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: checkinTime, to: currentTime)

                                            if let hours = timeDifference.hour, let minutes = timeDifference.minute, let seconds = timeDifference.second {
                                                HStack (spacing: 10) {
                                                    TimeUnitView(time: String(hours))
                                                    Text(":")
                                                        .font(.headline)
                                                        .foregroundColor(.accentColor)
                                                    TimeUnitView(time: String(format: "%02d", minutes))
                                                    Text(":")
                                                        .font(.headline)
                                                        .foregroundColor(.accentColor)
                                                    TimeUnitView(time: String(format: "%02d", seconds))
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(2)


                                        
                                VStack{
                                    Text("Shift end in 9 hours")
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        .foregroundColor(.blue)
                                    
                                }  .frame(width: Responsiveframes.widthPercentageToDP(80))
                            }
           
                            .frame(width: Responsiveframes.widthPercentageToDP(80))
                            
                            
                            Spacer()
                            
                            
                        }
                        .padding(.top,5)
                        .padding()
                        .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(20))
                        .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                        
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .inset(by: 0.5)
                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                        )
                        
                        
                        VStack{
                            Button(action: {
                                // Add your sign-in action here
                                Workinghourshistory.toggle()
                                
                            }) {
                                HStack {
                                    
                                    Text("Working hours history")
                                        .foregroundColor(.blue)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    //        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    Spacer()
                                }
                            }
                            .padding()
                            .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                            .onTapGesture {
                                Workinghourshistory.toggle()
                            }
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(Color.clear)
                            )
                            .cornerRadius(6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .inset(by: 0.5)
                                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
                            )
                            
                            Button(action: {
                                // Add your sign-in action here
                                Timesheet.toggle()
                                
                            }) {
                                HStack {
                                    
                                    Text("Time sheet")
                                        .foregroundColor(.blue)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    //        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    Spacer()
                                }
                            }
                            .padding()
                            .frame(width: ConstantClass.HstackTextFieldSize.width,height: ConstantClass.HstackTextFieldSize.height)
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(Color.clear)
                            )
                            .cornerRadius(6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .inset(by: 0.5)
                                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
                            )
                            
                            
                            .onTapGesture {
                                Timesheet.toggle()
                                
                            }
                            
                        }
                        
                        NavigationLink(destination: WorkerHoursHistory(showPicker: true), isActive: $Workinghourshistory) { EmptyView() }
                        NavigationLink(destination: WorkerTimesheet(showPicker: true), isActive: $Timesheet) { EmptyView() }
                        
                        Spacer()
                        
                    }
                    
                    .frame(width: min(geometry.size.width, geometry.size.height))
                    
                }
            }  .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
        .onAppear(){
            
            getCurrentDate()
            statuscheck.currentdate = currentdate ?? ""
            statuscheck.GetCheckintime()
            
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
    
    
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        currentdate = dateFormatter.string(from: date)
        print (currentdate)
        
        
        return currentdate ?? ""
    }
    
    func formatDateString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return dateFormatter.date(from: dateString)
    }
    
    
}






struct TimeUnitView: View {
    let time: String

    var body: some View {
        Text(time)
            .font(.headline)
            .foregroundColor(.black)
            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
            .frame(width: Responsiveframes.widthPercentageToDP(15), height: Responsiveframes.widthPercentageToDP(15))
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 6.0)
                    .stroke(Color.gray, lineWidth: 0.5)
                    .foregroundColor(.white)
            )
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}


#Preview {
    WorkerTimeReport()
}
